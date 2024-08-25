# Monitoring-System-Resource-for-a-proxy-Server
## A Bash script that monitors various system resources for a proxy server and presents them in a dashboard format

### Run the script without any arguments to display the full dashboard.  

`./monitor.sh`: Displays the full dashboard and refreshes every few seconds.

### Run the script with command-line switches to view specific parts of the dashboard.  
`./monitor.sh -cpu`: Displays only the CPU usage and system load.  
`./monitor.sh -memory`: Displays only the memory usage.  
`./monitor.sh -network`: Displays network monitoring information.  
`./monitor.sh -disk`: Displays disk usage.  
`./monitor.sh -process`: Displays process monitoring information.  
`./monitor.sh -services`: Displays the status of essential services.  
