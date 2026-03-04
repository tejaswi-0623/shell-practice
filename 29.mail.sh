#!/bin/bash

TO_ADDRESS=$1
SUBJECT=$2
MESSAGE_BODY=$3
ALERT_TYPE=$4
SERVER_IP=$5
TO_TEAM=$6
FINAL_MESSAGE_BODY=$(echo $MESSAGE_BODY | sed -e 's/[]\/$*.^[]/\\&/g')

FINAL_MESSAGE=$(sed -e "s/TO_TEAM/$TO_TEAM/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/SERVER_IP/$SERVER_IP/g" -e "s/MESSAGE/$FINAL_MESSAGE_BODY/g" template.html)


{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$FINAL_MESSAGE"
} | msmtp "$TO_ADDRESS"

#we will call this script in disk-alert.sh script 
#we are giving sed -e for temporary for permanent means sed -i


#below is the output we got in mail
# Hi DevOps Team,

# There is an issue of DISK_UTILISATION type in the server. Please find the details below.

# Server IP: 172.31.70.127
# high disk usage alert on /:20
# high disk usage alert on /var:20
# high disk usage alert on /boot:20

# Regards,
# Monitoring Team