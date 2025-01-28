#!/bin/bash

# System Health Monitor Script by Shivakant

OUTPUT_FILE="/home/michaelmax/linux_epic/system_health.log"
SEPARATOR="---------------------------------------------------"

# Function to check and create the log file if it doesn't exist
check_log_file() {
    if [ ! -f "$OUTPUT_FILE" ]; then
        echo "Log file does not exist. Creating log file at $OUTPUT_FILE"
        touch $OUTPUT_FILE
    fi
}

# Function to record the current date
date_info() {
    echo "$SEPARATOR" >> $OUTPUT_FILE
    echo "System Health Report - $(date)" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record CPU usage
cpu_usage() {
    echo "### CPU Details ###" >> $OUTPUT_FILE
    top -b -n 1 | grep "Cpu(s)" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record memory details
memory_info() {
    echo "### Memory Details ###" >> $OUTPUT_FILE
    free -h >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record disk details
disk_info() {
    echo "### Disk Details ###" >> $OUTPUT_FILE
    df -h >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record network activity
network_activity() {
    echo "### Network Activity ###" >> $OUTPUT_FILE
    ifconfig | grep "RX packets" >> $OUTPUT_FILE
    ifconfig | grep "TX packets" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record top CPU-consuming processes
top_cpu_processes() {
    echo "### Top 10 CPU-Consuming Processes ###" >> $OUTPUT_FILE
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -11 >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record top memory-consuming processes
top_memory_processes() {
    echo "### Top 5 Memory-Consuming Processes ###" >> $OUTPUT_FILE
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6 >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Function to record system uptime
system_uptime() {
    echo "### System Uptime ###" >> $OUTPUT_FILE
    uptime >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}

# Main function to call all the functions
main() {
    check_log_file
    date_info
    cpu_usage
    memory_info
    disk_info
    network_activity
    top_cpu_processes
    top_memory_processes
    system_uptime
    echo "Report saved to $OUTPUT_FILE"
}

# Execute the main function
main

