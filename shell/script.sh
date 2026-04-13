#!/bin/bash

LOG_FILE="monitor.log"

echo "===== $(date) =====" >> $LOG_FILE

# CPU Usage (simple)
CPU=$(top -bn1 | grep "Cpu" | awk '{print $2}')
echo "CPU: $CPU%" >> $LOG_FILE

# Memory Usage (simple)
MEM=$(free | grep Mem | awk '{print $3/$2 * 100}')
echo "Memory: $MEM%" >> $LOG_FILE

# Disk Usage (simple)
DISK=$(df / | tail -1 | awk '{print $5}')
echo "Disk: $DISK" >> $LOG_FILE

# Check nginx
STATUS=$(systemctl is-active nginx)

if [ "$STATUS" != "active" ]; then
    echo "Nginx is DOWN → Restarting" >> $LOG_FILE
    systemctl restart nginx
else
    echo "Nginx is RUNNING" >> $LOG_FILE
fi

echo "" >> $LOG_FILE