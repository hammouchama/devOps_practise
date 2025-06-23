#!/bin/bash

echo "================ Server Performance Stats ================"

# CPU Usage
echo -e "\n>> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "Used: " $2 + $4 "%, Idle: " $8 "%"}'

# Memory Usage
echo -e "\n>> Total Memory Usage:"
free -h | awk '/Mem:/ {
    used=$3; free=$4; total=$2;
    printf("Used: %s, Free: %s, Total: %s (%.2f%% used)\n", used, free, total, $3/$2 * 100)
}'

# Disk Usage
echo -e "\n>> Total Disk Usage:"
df -h --total | awk '/total/ {
    printf("Used: %s, Available: %s, Total: %s (%.2f%% used)\n", $3, $4, $2, $5)
}'

# Top 5 processes by CPU usage
echo -e "\n>> Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo -e "\n>> Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo -e "\n=========================================================="
