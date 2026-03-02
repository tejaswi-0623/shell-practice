#!/bin/bash

userid=$(id -u)
logs_folder="/var/log/app-logs"
logs_file="$logs_folder/backup.log"  #backup is filename
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
source_dir=$1
destination_dir=$2
days=${3:-14} #$3 for third argument and default we give as 14 days if user not supplied retention days

mkdir -p $logs_folder

#cehcking root user or not
if [ $userid -ne 0 ]; then
  echo -e " $R please run the script with root user access $N"
  exit 1
fi 

#log function for timestamp 
log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $logs_file
}

#$1=first argument to the function
#$(date "+%Y-%m-%d %H:%M:%S") is command for timestamp
#tee -a $logs_file appending output to log filr and print on the screen

usage(){
    log "$G usage sudo backup <source_dir> <destination_dir> <days>[Default 14 days] $N"
    exit 1
}