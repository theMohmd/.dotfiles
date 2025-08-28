#!/bin/bash

# Enhanced development server startup script
# Improvements: better error handling, more robust port detection, configurable timeout

# Default values
PACKAGE_MANAGER="pnpm"
USE_LOCALHOST=false
TIMEOUT=30
VERBOSE=false
NO_BROWSER=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--localhost)
            USE_LOCALHOST=true
            shift
            ;;
        -c|--command)
            PACKAGE_MANAGER="$2"
            shift 2
            ;;
        -t|--timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -n|--no-browser)
            NO_BROWSER=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -l, --localhost        Use localhost instead of .local domain"
            echo "  -c, --command CMD      Package manager command (default: pnpm)"
            echo "  -t, --timeout SEC      Timeout in seconds (default: 30)"
            echo "  -v, --verbose          Verbose output"
            echo "  -n, --no-browser       Don't open browser automatically"
            echo "  -h, --help             Show this help message"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Usage: $0 [-l|--localhost] [-c|--command <package_manager>] [-t|--timeout <seconds>] [-v|--verbose] [-n|--no-browser]"
            exit 1
            ;;
    esac
done

# Validate package manager exists
if ! command -v "$PACKAGE_MANAGER" &> /dev/null; then
    print_error "Package manager '$PACKAGE_MANAGER' not found"
    exit 1
fi

# Check if package.json exists
if [[ ! -f "package.json" ]]; then
    print_error "No package.json found in current directory"
    exit 1
fi

# Get current directory name
DIR_NAME=$(basename "$PWD")

# Function to check if server is ready
check_server_ready() {
    local port=$1
    local url="http://localhost:$port"
    
    [[ "$VERBOSE" == true ]] && print_status "Checking server readiness at $url"
    
    for i in {1..30}; do
        if curl -s --connect-timeout 1 "$url" > /dev/null 2>&1; then
            return 0
        fi
        sleep 1
    done
    return 1
}

# Function to check if hosts entry exists and add if needed
add_hosts_entry() {
    local name=$1
    local entry="127.0.0.1 $name.local"
    
    # Check if /etc/hosts exists and is readable
    if [[ ! -r /etc/hosts ]]; then
        print_error "/etc/hosts is not readable"
        return 1
    fi
    
    # Check if entry already exists (more robust check)
    if grep -q "^127\.0\.0\.1[[:space:]]\+$name\.local\([[:space:]]\|$\)" /etc/hosts 2>/dev/null; then
        [[ "$VERBOSE" == true ]] && print_status "Hosts entry for $name.local already exists"
        return 0
    fi
    
    # Try to add the entry
    print_status "Adding hosts entry: $entry"
    if echo "$entry" | sudo tee -a /etc/hosts > /dev/null 2>&1; then
        print_status "Successfully added hosts entry for $name.local"
        return 0
    else
        print_error "Failed to add hosts entry to /etc/hosts"
        return 1
    fi
}

# Function to detect port from various dev server outputs
detect_port() {
    local log_file=$1
    local port=""
    
    # Try multiple patterns for different frameworks
    patterns=(
        "localhost:([0-9]+)"
        "127\.0\.0\.1:([0-9]+)"
        "http://localhost:([0-9]+)"
        "Local:.*:([0-9]+)"
        "ready on.*:([0-9]+)"
        "server started on.*:([0-9]+)"
        "running on.*:([0-9]+)"
    )
    
    for pattern in "${patterns[@]}"; do
        port=$(grep -oE "$pattern" "$log_file" | grep -oE "[0-9]+" | head -1)
        if [[ -n "$port" ]]; then
            break
        fi
    done
    
    echo "$port"
}

# Cleanup function
cleanup() {
    print_status "Cleaning up..."
    [[ -n "$temp_log" && -f "$temp_log" ]] && rm -f "$temp_log"
    if [[ -n "$DEV_PID" ]]; then
        kill "$DEV_PID" 2>/dev/null
    fi
}

# Set up signal handlers
trap cleanup EXIT INT TERM

# Start the dev server in background and capture output
print_status "Starting $PACKAGE_MANAGER run dev..."
temp_log=$(mktemp)

# Start dev server and capture output
$PACKAGE_MANAGER run dev 2>&1 | tee "$temp_log" &
DEV_PID=$!

# Wait for port to appear in output
print_status "Waiting for server to start (timeout: ${TIMEOUT}s)..."
PORT=""

for i in $(seq 1 $TIMEOUT); do
    PORT=$(detect_port "$temp_log")
    
    if [[ -n "$PORT" ]]; then
        print_status "Detected port: $PORT"
        break
    fi
    
    # Check if process is still running
    if ! kill -0 "$DEV_PID" 2>/dev/null; then
        print_error "Dev server process died unexpectedly"
        exit 1
    fi
    
    sleep 1
done

# If no port found, continue with dev server running but don't open browser
if [[ -z "$PORT" ]]; then
    print_warning "Could not detect port within $TIMEOUT seconds. Server is still running but browser won't open."
    print_status "Check the output above for manual connection details"
    wait $DEV_PID
    exit 0
fi

# Wait for server to be ready
print_status "Waiting for server to be ready..."
if ! check_server_ready "$PORT"; then
    print_warning "Server didn't become ready in time, but continuing..."
fi

# Determine URL to open based on flags and hosts entry status
URL=""
if [[ "$USE_LOCALHOST" == true ]]; then
    # Explicitly requested localhost
    URL="http://localhost:$PORT"
    print_status "Using localhost as requested"
else
    # Try to use .local domain, but don't fallback to localhost if it fails
    if add_hosts_entry "$DIR_NAME"; then
        URL="http://$DIR_NAME.local:$PORT"
        print_status "Using .local domain: $URL"
    else
        print_error "Could not set up .local domain and localhost not requested"
        print_status "Development server is running at http://localhost:$PORT"
        print_status "You can manually add '127.0.0.1 $DIR_NAME.local' to /etc/hosts and use http://$DIR_NAME.local:$PORT"
        
        # Don't open browser if we can't set up the desired URL
        if [[ "$NO_BROWSER" == false ]]; then
            print_warning "Not opening browser due to hosts entry failure. Use -l/--localhost flag to force localhost usage."
        fi
        
        print_status "Press Ctrl+C to stop the server"
        wait $DEV_PID
        exit 0
    fi
fi

# Open in Chrome with better browser detection
open_in_browser() {
    local url=$1
    local browsers=("google-chrome" "google-chrome-stable" "chromium" "chromium-browser" "firefox" "open" "xdg-open")
    
    for browser in "${browsers[@]}"; do
        if command -v "$browser" &> /dev/null; then
            print_status "Opening $url with $browser"
            "$browser" "$url" &
            return 0
        fi
    done
    
    print_warning "No supported browser found. Please open $url manually."
    return 1
}

# Open in browser if requested and URL is set
if [[ "$NO_BROWSER" == true ]]; then
    print_status "Browser opening disabled. Development server is running at $URL"
elif [[ -n "$URL" ]]; then
    open_in_browser "$URL"
fi

# Print final status
if [[ -n "$URL" ]]; then
    print_status "Development server is running at $URL"
fi
print_status "Press Ctrl+C to stop the server"

# Wait for dev server (cleanup will handle the rest)
wait $DEV_PID
