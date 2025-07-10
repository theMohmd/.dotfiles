#!/bin/bash

# OpenVPN Connection Script with Restart Functionality
# Press 'r' to restart the connection

VPN_CONFIG="/etc/openvpn/client/vpn.ovpn"
PASS_FILE="/etc/openvpn/client/pass.txt"
VPN_COMMAND="sudo openvpn --data-ciphers AES-128-CBC --config $VPN_CONFIG --auth-user-pass $PASS_FILE"
SUCCESS_PATTERN="Timers: ping 20, ping-restart 60"

cleanup() {
    echo -e "\n\nCleaning up..."
    sudo pkill -f "openvpn.*$VPN_CONFIG" 2>/dev/null
    stty echo
    exit 0
}

trap cleanup SIGINT SIGTERM

echo "OpenVPN Connection Manager"
echo "========================="
echo "Press 'r' to restart connection, Ctrl+C to exit"

stty -echo

while true; do
    echo -e "\nStarting OpenVPN connection..."
    echo "Connecting..."

    $VPN_COMMAND 2>&1 | while IFS= read -r line; do
        echo "$line"
        if [[ "$line" == *"$SUCCESS_PATTERN"* ]]; then
            echo -e "\n✓ Connection established!"
            echo "Press 'r' to restart connection, Ctrl+C to exit"
        fi
    done &
    
    LOG_PID=$!
    sleep 2  # Give openvpn a moment to start
    VPN_PID=$(pgrep -f "openvpn.*$VPN_CONFIG" | head -n 1)

    while kill -0 "$LOG_PID" 2>/dev/null; do
        if read -t 0.1 -n 1 -s key 2>/dev/null; then
            if [[ "$key" == "r" || "$key" == "R" ]]; then
                echo -e "\n\nRestarting connection..."
                sudo pkill -f "openvpn.*$VPN_CONFIG" 2>/dev/null
                kill "$LOG_PID" 2>/dev/null
                sleep 2
                break
            fi
        fi
    done

    if kill -0 "$LOG_PID" 2>/dev/null; then
        continue
    else
        echo -e "\nConnection lost, restarting..."
        sleep 2
    fi
done
