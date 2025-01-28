#!/bin/bash

# System Health Monitor Script by Shivakant

# Output file for logging
OUTPUT_FILE="/home/michaelmax/linux_epic/system_health.log"
SEPARATOR="---------------------------------------------------"

date_info() {
    echo "$SEPARATOR" >> $OUTPUT_FILE
    echo "System Health Report - $(date)" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


cpu_usage() {
    echo "### CPU Details ###" >> $OUTPUT_FILE
    top -b -n 1 | grep "Cpu(s)" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


memory_info() {
    echo "### Memory Details ###" >> $OUTPUT_FILE
    free -h >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


disk_info() {
    echo "### Disk Details ###" >> $OUTPUT_FILE
    df -h >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


network_activity() {
    echo "### Network Activity ###" >> $OUTPUT_FILE
    ifconfig | grep "RX packets" >> $OUTPUT_FILE
    ifconfig | grep "TX packets" >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


top_cpu_processes() {
    echo "### Top 10 CPU-Consuming Processes ###" >> $OUTPUT_FILE
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -11 >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


top_memory_processes() {
    echo "### Top 5 Memory-Consuming Processes ###" >> $OUTPUT_FILE
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6 >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


system_uptime() {
    echo "### System Uptime ###" >> $OUTPUT_FILE
    uptime >> $OUTPUT_FILE
    echo "$SEPARATOR" >> $OUTPUT_FILE
}


main() {
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

main

