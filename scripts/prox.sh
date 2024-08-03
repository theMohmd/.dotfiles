#!/bin/bash

# Variables
PROXY_IP="192.168.1.34"  # Replace with your SOCKS5 proxy IP
PROXY_PORT="1080"         # Replace with your SOCKS5 proxy port
REDIRECT_PORT="12345"
CONFIG_FILE="/etc/redsocks.conf"

# Function to set up the proxy
setup_proxy() {
    echo "Setting up proxy..."

    # Install redsocks if not already installed
    if ! command -v redsocks &> /dev/null; then
        echo "redsocks not found, installing..."
        sudo pacman -S --noconfirm redsocks
    fi

    # Set up redsocks
    sudo tee $CONFIG_FILE > /dev/null <<EOF
base {
    log_info = on;
    log_debug = off;
    log = "file:/var/log/redsocks/redsocks.log";
    daemon = on;
    pid_file = "/var/run/redsocks.pid";
    redir_ip = 127.0.0.1;
    redir_port = $REDIRECT_PORT;
}

socks5 {
    type = socks5;
    ip = $PROXY_IP;
    port = $PROXY_PORT;
    login = "proxy_user";
    password = "proxy_pass";
}
EOF

    # Create iptables rules
    sudo iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-port $REDIRECT_PORT

    # Start redsocks
    sudo systemctl restart redsocks
    sudo systemctl enable redsocks

    echo "All outgoing traffic is now being redirected to the SOCKS5 proxy."
}

# Function to remove the proxy setup
remove_proxy() {
    echo "Removing proxy setup..."

    # Remove iptables rules
    sudo iptables -t nat -D OUTPUT -p tcp -j REDIRECT --to-port $REDIRECT_PORT

    # Stop and disable redsocks
    sudo systemctl stop redsocks
    sudo systemctl disable redsocks

    # Remove redsocks configuration file
    sudo rm -f $CONFIG_FILE

    echo "Proxy redirection has been removed."
}

# Main script logic
if [ "$1" == "on" ]; then
    setup_proxy
elif [ "$1" == "off" ]; then
    remove_proxy
else
    echo "Usage: $0 {enable|disable}"
    exit 1
fi
