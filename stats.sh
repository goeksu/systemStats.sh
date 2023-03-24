#!/bin/bash

BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

while true; do
   
    clear

    #print header
    echo -e "${BLUE}=== SYSTEM STATISTICS ===${RESET}"
    echo

    #get CPU usage
    CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print s"%"}')
    echo -e "${YELLOW}CPU Usage:${RESET} $CPU_USAGE"

    #get memory usage
    MEM_USAGE=$(vm_stat | grep "Pages active" | awk '{ print $3 }' | sed 's/\.//')
    MEM_USAGE=$((MEM_USAGE * 4096 / 1024 / 1024))
    echo -e "${YELLOW}Memory Usage:${RESET} $MEM_USAGE MB"

    # Get disk usage
    DISK_USAGE=$(df -H / | awk 'NR==2 {print $5}')
    echo -e "${YELLOW}Disk Usage:${RESET} $DISK_USAGE"

    #get network activity
    NETWORK_IN=$(netstat -ibn | grep -e "en0" -e "en1" | awk '{if ($1 == "en0" || $1 == "en1") sum+=$7} END {print sum}')
    NETWORK_OUT=$(netstat -ibn | grep -e "en0" -e "en1" | awk '{if ($1 == "en0" || $1 == "en1") sum+=$10} END {print sum}')
    echo -e "${YELLOW}Network Activity:${RESET}"
    echo -e "${CYAN}Bytes In:${RESET} $NETWORK_IN"
    echo -e "${CYAN}Bytes Out:${RESET} $NETWORK_OUT"

    #refresh every 5 seconds
    sleep 5
done

