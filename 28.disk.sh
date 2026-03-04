#!/bin/bash

logs_folder="/var/log/disk-alert"
logs_file="$logs_folder/disk.log"
message=""

mkdir -p $logs_folder

#log function for timestamp
log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $logs_file
}

log "high disk usage alerted at"

disk_usage=$(df -hT | grep -v Filesystem)
usage_threshold=30 #in real-time we give 70 or 75 or 80

#we have so many disks/devices in fileystem so we are giving in loop and we need to append input vairable to loop so using while loop
while IFS= read -r line 
do
   use=$(echo $line | awk '{print $6}' | cut -d "%" -f1) 
   mounted_device=$(echo $line | awk '{print $7}')

   if [ "$use" -ge "$usage_threshold" ]; then
      message+="high disk usage on $mounted_device:$use% \n"
   fi
done <<< $disk_usage

echo -e "$message"

#script for disk utilization more than 30 for device/disk
#sudo sh 28.disk.sh
#2026-03-04 20:57:45 | high disk usage alerted at
#high disk usage on /:38%
#high disk usage on /boot:81%
#if we didn't use cut -d % commmand it didnot compare with percentages so we are using this cut command here

