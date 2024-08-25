#!/bin/bash


REFRESH_INTERVAL=5

# Function to display the top 10 most used applications
function show_top_apps() {
    echo "Top 10 Applications by CPU and Memory Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 11
    echo ""
}

# Function to display network monitoring
function show_network_monitoring() {
    echo "Network Monitoring:"
    echo "Concurrent connections to the server:"
    ss -tun | wc -l
    echo "Packet drops:"
    netstat -s | grep "packet receive errors"
    echo "MB in and out:"
    ifstat -b 1 1 | awk 'NR==3 {print "In: " $1 " KB/s, Out: " $2 " KB/s"}'
    echo ""
}

# Function to display disk usage
function show_disk_usage() {
    echo "Disk Usage:"
    df -h | awk '$5 > 80 {print "WARNING: Partition "$6" is using "$5" of disk space!"} {print $0}'
    echo ""
}

# Function to display system load
function show_system_load() {
    echo "System Load:"
    uptime
    echo "CPU Usage Breakdown:"
    mpstat | awk '/all/ {print "User: "$3"% System: "$5"% Idle: "$12"%"}'
    echo ""
}

# Function to display memory usage
function show_memory_usage() {
    echo "Memory Usage:"
    free -h
    echo ""
}

# Function to display process monitoring
function show_process_monitoring() {
    echo "Process Monitoring:"
    echo "Number of active processes: $(ps aux | wc -l)"
    echo "Top 5 processes by CPU and Memory Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    echo ""
}

# Function to display service monitoring
function show_service_monitoring() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done
    echo ""
}

# Function to display the full dashboard
function show_dashboard() {
    clear
    show_top_apps
    show_network_monitoring
    show_disk_usage
    show_system_load
    show_memory_usage
    show_process_monitoring
    show_service_monitoring
}

# Command-line switches
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -cpu)
        show_system_load
        shift
        ;;
        -memory)
        show_memory_usage
        shift
        ;;
        -network)
        show_network_monitoring
        shift
        ;;
        -disk)
        show_disk_usage
        shift
        ;;
        -process)
        show_process_monitoring
        shift
        ;;
        -services)
        show_service_monitoring
        shift
        ;;
        *)
        # Full dashboard
        show_dashboard
        sleep $REFRESH_INTERVAL
        ;;
    esac
done

# If no switches provided, show full dashboard with refresh
if [[ $# -eq 0 ]]; then
    while true
    do
        show_dashboard
        sleep $REFRESH_INTERVAL
    done
fi
