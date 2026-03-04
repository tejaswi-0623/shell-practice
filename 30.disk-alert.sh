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
      message+="high disk usage alert on $mounted_device:$usage_threshold <br>" #<br> means new line in html
    fi
done <<<$disk_usage

echo -e "$message"

sh 29.mail.sh "tejaswij993@gmail.com" "High Disk usage alert on $IP_ADDRESS" "$message" "HIGH_disk_usage" "$IP_ADDRESS" "DevOps Team"

#this script is for disk utilization and trigger mail
#we are calling 29.mail.sh script here and giving inputs for $1,$2,$3,$4,$5and $6
#we are giving private address and that is command to get private ip address in AWS EC2 instance

#below is the output we got in mail
# Hi DevOps Team,

# There is an issue of DISK_UTILISATION typein the server. Please find the details below.

# Server IP: 172.31.70.127
# high disk usage alert on /:20
# high disk usage alert on /var:20
# high disk usage alert on /boot:20

# Regards,
# Monitoring Team