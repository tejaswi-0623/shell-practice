#!/bin/bash

logs_folder="/var/log/alert"
logs_file="$logs_folder/disk-alert.log"
message=""
IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

mkdir -p $logs_folder

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S")| $1" |tee -a $logs_file
}

log "high disk usage alert at"

disk_usage=$(df -hT |grep -v Filesystem)
usage_threshold=20 #in real we give 70 0r 75

while IFS= read -r line #line is vairable here 
do
    device_use=$(echo $line |awk '{print $6}'|cut -d "%" -f1)
    mounted_device=$(echo $line |awk '{print $7}')
    if [ "$device_use" -ge "$usage_threshold" ]; then
      message+="high disk usage alert on $mounted_device:$usage_threshold \n"
    fi
done <<<$disk_usage

echo -e "$message"

sh 29.mail.sh "tejaswij993@gmail.com" "High Disk usage alert on $IP_ADDRESS" "$message" "HIGH_disk_usage" "$IP_ADDRESS" "DevOps Team"

#this script is for disk utilization and send trigger mail
#we are calling 29.mail.sh script here and giving inputs for $1,$2,$3,$4,$5and $6
#we are giving private address and that is command to get private ip address in AWS EC2 instance