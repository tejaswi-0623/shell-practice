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

#log function for timestamp 
log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $logs_file
}

#$1=first argument to the function
#$(date "+%Y-%m-%d %H:%M:%S") is command for timestamp
#tee -a $logs_file appending output to log filr and print on the screen

#checking root user or not
if [ $userid -ne 0 ]; then
  echo -e " $R please run the script with root user access $N"
  exit 1
fi 

#usage function for how to run the script 
usage(){
    log "$G usage:: sudo backup <source_dir> <destination_dir> <days>[Default 14 days] $N"
    exit 1
}

#If the user did not provide at least two arguments, call usage function and exit the script
if [ $# -lt 2 ]; then #$#---number of arguments
   usage
fi

#to check source directory exists
if [ ! -d "$source_dir" ]; then  #-d=directory
  echo -e "$R Source Directory : $source_dir does not exist $N" #$1=source_dir
  exit 1
fi

#to check destination directory exists
if [ ! -d "$destination_dir" ]; then 
  echo -e "$R Destination directory : $destination_dir does not exist $N" #$2=destination_dir
  exit 1
fi

#find the log files
files=$(find "$source_dir" -name "*.log" -type f -mtime +$days)

log "backup started"
log "source directory is : $source_dir"
log "destination directory is : $destination_dir"
log "rention days is :$days"
