#!/bin/bash

# --- FUNCTIONS ---
show_ip() {
    echo "=== PUBLIC IP ==="
    curl -s ifconfig.me
    echo -e "\n(This is the IP address seen by the Internet, it may differ from your private LAN IP)\n"
}

show_ports() {
    echo "=== OPEN PORTS (LISTENING) ==="
    lsof -i -P | grep LISTEN
    echo -e "\n(This list shows which services on your Mac are waiting for incoming connections)\n"
}

sniff_http() {
    echo "=== HTTP TRAFFIC CAPTURE ON PORT 80 ==="
    echo "Open a browser and visit a website using http:// (not https)."
    echo "Press CTRL+C to stop."
    sudo tcpdump -i any port 80
}

show_firewall() {
    echo "=== FIREWALL STATUS (pf) ==="
    sudo pfctl -s info
    echo
    echo "=== ACTIVE RULES ==="
    sudo pfctl -sr
    echo -e "\n(If no rules appear, pf is probably disabled)\n"
}

sniff_custom_port() {
    echo -n "Enter the port number you want to capture: "
    read port
    if [[ "$port" =~ ^[0-9]+$ ]]; then
        echo "=== TRAFFIC CAPTURE ON PORT $port ==="
        echo "Press CTRL+C to stop."
        sudo tcpdump -i any port "$port"
    else
        echo "Invalid port number."
    fi
}
# --- INTERACTIVE MENU ---
while true; do
    echo "=================================="
    echo "       Network Tools (macOS)      "
    echo "=================================="
    echo "1) Show my public IP"
    echo "2) Show open ports"
    echo "3) Capture HTTP traffic (port 80)"
    echo "4) Capture traffic on a custom port"
    echo "5) Check firewall (pf)"
    echo "6) Exit"
    echo -n "Choose an option [1-6]: "
    read opt

    case $opt in
        1) show_ip ;;
        2) show_ports ;;
        3) sniff_http ;;
        4) sniff_custom_port ;;
        5) show_firewall ;;
        6) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option";;
    esac
done