#!/bin/bash

logs_folder="/var/log/disk-alert"
logs_file="$logs_folder/disk.log"

mkdir -p $logs_folder

#log function for timestamp
log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $logs_file
}

log "disk usage check script started"
log "high disk usage alerted at"

disk_usage=$(df -hT | grep -v Filesystem)
usage_threshold=2 #in real-time we give 70 or 75 or 80

while IFS= read -r line; do
   use=$(df -hT | grep -v Filesystem | awk '{print $6}' | cut -d "%" -f1)
   mounted=$(df -hT | grep -v Filesystem | awk '{print $7}')

   