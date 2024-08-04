#!/bin/bash

# List of DNS servers to test
DNS_SERVERS=(
    "8.8.8.8" "8.8.4.4" "76.76.2.0" "76.76.10.0" "9.9.9.9" "149.112.112.112"
    "208.67.222.222" "208.67.220.220" "1.1.1.1" "1.0.0.1" "94.140.14.14" "94.140.15.15"
    "185.228.168.9" "185.228.169.9" "76.76.19.19" "76.223.122.150" "8.26.56.26" "8.20.247.20"
    "149.112.121.10" "149.112.122.10" "138.197.140.189" "168.235.111.72" "94.130.180.225" "78.47.64.161"
    "77.88.8.8" "77.88.8.1" "74.82.42.42" "80.80.80.80" "80.80.81.81" "216.146.35.35" "216.146.36.36"
    "205.171.3.65" "205.171.2.65"
)

# Number of ping requests
NUM_REQUESTS=10

# Function to test a DNS server
test_dns_server() {
    local dns_server=$1
    echo "Testing DNS server: $dns_server"
    local result=$(ping -c $NUM_REQUESTS $dns_server 2>&1)
    local packet_loss=$(echo "$result" | grep 'packet loss' | awk '{print $6}' | sed 's/%//')
    local rtt=$(echo "$result" | grep 'rtt' | awk -F '/' '{print $5}')
    if [ -z "$packet_loss" ]; then
        packet_loss=100
        rtt="N/A"
    fi
    echo "Result for $dns_server: Packet Loss = $packet_loss%, Average Latency = $rtt ms"
    echo "$dns_server,$packet_loss,$rtt" >> $TEMP_FILE
}

# Temporary file to store results
TEMP_FILE=$(mktemp)

# Clear the temporary file
echo "DNS Server,Packet Loss,Average Latency (ms)" > $TEMP_FILE

# Test each DNS server
for dns in "${DNS_SERVERS[@]}"; do
    test_dns_server $dns
done

# Sort the results by packet loss and then by average latency
sorted_results=$(sort -t, -k2,2n -k3,3n $TEMP_FILE)

# Find the best ping parameters
best_packet_loss=$(echo "$sorted_results" | head -n 2 | tail -n 1 | cut -d, -f2)
best_latency=$(echo "$sorted_results" | head -n 2 | tail -n 1 | cut -d, -f3)

# Print the sorted results as a table with best parameters highlighted in green and packet loss in red
echo -e "\nSorted Results:"
echo -e "DNS Server\tPacket Loss\tAverage Latency (ms)"
while IFS=, read -r dns_server packet_loss latency; do
    if [[ "$packet_loss" == "$best_packet_loss" && "$latency" == "$best_latency" ]]; then
        echo -e "\e[32m$dns_server\t$packet_loss%\t$latency ms\e[0m"
    elif [[ "$packet_loss" != "0" ]]; then
        echo -e "\e[31m$dns_server\t$packet_loss%\t$latency ms\e[0m"
    else
        echo -e "$dns_server\t$packet_loss%\t$latency ms"
    fi
done <<< "$sorted_results"

# Ask user if they want to set the top 5 DNS servers as nameservers
read -p "Do you want to set the top 5 DNS servers with the best ping times as nameservers in /etc/resolv.conf? (y/n): " choice
if [[ $choice == "y" || $choice == "Y" ]]; then
    # Get the top 5 DNS servers
    TOP_DNS_SERVERS=$(echo "$sorted_results" | head -n 6 | tail -n 5 | cut -d, -f1)
    
    # Backup existing resolv.conf
    sudo cp /etc/resolv.conf /etc/resolv.conf.bak
    
    # Clear existing nameservers
    sudo sh -c 'echo "" > /etc/resolv.conf'
    
    # Add top 5 DNS servers as nameservers
    for dns in $TOP_DNS_SERVERS; do
        sudo sh -c "echo nameserver $dns >> /etc/resolv.conf"
    done
    
    echo "Top 5 DNS servers have been set as nameservers in /etc/resolv.conf"
else
    echo "No changes made to /etc/resolv.conf"
fi

# Remove the temporary file
rm -f $TEMP_FILE
