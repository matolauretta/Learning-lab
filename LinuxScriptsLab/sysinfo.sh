#!/bin/sh

# This script collects system information and outputs it in a formatted way.

echo "System Information"
echo "=================="   
echo "Hostname: $(hostname)"
echo "Disk Usage:"
df -h | awk 'NR==1 || /\/$/ {print}'
echo "Memory Usage:"
sysctl -a | awk '/hw\.mem/ { printf "%s: %.1f GB\n", $1, $2 / 1024 / 1024 / 1024 }'
echo "Heaviest Processes:"
ps aux | sort -nrk 4 | head -n 5 | awk 'BEGIN {print "PID\tCOMMAND\tMEMORY\tCPU"} {print $2 "\t" $11 "\t" $4 "\t" $3}'
echo "Local IP Address:"
ipconfig getifaddr en0 || echo "Could not retrieve local IP address"
echo "External IP Address:"
curl -s https://ipinfo.io/ip && echo "" || echo "Could not retrieve external IP address"
echo "Gateway IP Address:"
netstat -nr -f inet |grep default | awk '/en0/ {print $2}'
echo "=================="   