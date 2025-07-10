#!/bin/bash

# Default values
PACKAGE_MANAGER="pnpm"
USE_LOCALHOST=false
TIMEOUT=30

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
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [-l|--localhost] [-c|--command <package_manager>]"
            exit 1
            ;;
    esac
done

# Get current directory name
DIR_NAME=$(basename "$PWD")

# Function to check if server is ready
check_server_ready() {
    local port=$1
    local url="http://localhost:$port"
    
    for i in {1..30}; do
        if curl -s --connect-timeout 1 "$url" > /dev/null 2>&1; then
            return 0
        fi
        sleep 1
    done
    return 1
}

# Function to add hosts entry if it doesn't exist
add_hosts_entry() {
    local name=$1
    local entry="127.0.0.1 $name.local"
    
    if ! grep -q "$name.local" /etc/hosts 2>/dev/null; then
        echo "$entry" | sudo tee -a /etc/hosts > /dev/null
    fi
}

# Start the dev server in background and capture output
echo "Starting $PACKAGE_MANAGER run dev..."
temp_log=$(mktemp)

# Start dev server and capture output
$PACKAGE_MANAGER run dev 2>&1 | tee "$temp_log" &
DEV_PID=$!

# Wait for port to appear in output
echo "Waiting for server to start..."
PORT=""
for i in $(seq 1 $TIMEOUT); do
    # Look for common Next.js port patterns
    PORT=$(grep -oE "(localhost:|127\.0\.0\.1:|http://localhost:)([0-9]+)" "$temp_log" | grep -oE "[0-9]+" | head -1)
    
    if [[ -n "$PORT" ]]; then
        echo "Detected port: $PORT"
        break
    fi
    sleep 1
done

# If no port found, continue with dev server running but don't open browser
if [[ -z "$PORT" ]]; then
    echo "Could not detect port within $TIMEOUT seconds. Server is still running but browser won't open."
    wait $DEV_PID
    rm -f "$temp_log"
    exit 0
fi

# Wait for server to be ready
echo "Waiting for server to be ready..."
if ! check_server_ready "$PORT"; then
    echo "Server didn't become ready in time, but continuing..."
fi

# Determine URL to open
if [[ "$USE_LOCALHOST" == true ]]; then
    URL="http://localhost:$PORT"
    echo "Opening $URL in Chrome..."
else
    # Add hosts entry
    add_hosts_entry "$DIR_NAME"
    URL="http://$DIR_NAME.local:$PORT"
    echo "Opening $URL in Chrome..."
fi

# Open in Chrome
if command -v google-chrome &> /dev/null; then
    google-chrome "$URL" &
elif command -v google-chrome-stable &> /dev/null; then
    google-chrome-stable "$URL" &
elif command -v chromium &> /dev/null; then
    chromium "$URL" &
elif command -v chromium-browser &> /dev/null; then
    chromium-browser "$URL" &
else
    echo "Chrome/Chromium not found. Please open $URL manually."
fi

# Clean up temp file and wait for dev server
rm -f "$temp_log"
wait $DEV_PID
