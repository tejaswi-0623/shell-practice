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

#create app-logs and destination-dir through terminal prompt
# sudo sh 26.backup.sh /home/ec2-user/app-logs /home/ec2-user/destination_dir this command terminal prompt
# 2026-03-02 22:18:58 | backup started
# 2026-03-02 22:18:58 | source directory is : /home/ec2-user/app-logs
# 2026-03-02 22:18:58 | destination directory is : /home/ec2-user/destination_dir
# 2026-03-02 22:18:58 | rention days is :14


#archeive the files
if [ -z "${files}" ]; then #-z to check vairable is empty or not and files is vairable here
   log " No files to archeive.....$Y skipping $N"   #if empty execute this line
else
   # app-logs-$timestamp.zip
   log "files found to archeive.....$files"  
   timestamp=$(date +%F:%H:%M:%S) #%F →full date in YYYY-MM-DD, %H → hours, %M → minutes, %S → seconds
   zip_file="$destination_dir/app-logs-$timestamp.tar.gz" #zipping the file with timestamp
   log "Archieve name: $zip_file" 
   tar -zcvf $zip_file $(find $source_dir -name "*.log" -type f -mtime +$days) #zcvf means create a gzip-compressed archive, verbose, specifying the filename
 

 #check archeive is success or not
   if [ -f $zip_file ]; then #-f=file exists or not
        log "Archeival is ... $G SUCCESS $N"
   #delete the file
        while IFS= read -r filepath; do
        # Process each line here
        log "Deleting file: $filepath"
        rm -f $filepath
        log "Deleted file: $filepath"
        done <<< $files
    else
        log "Archeival is ... $R FAILURE $N"
        exit 1
    fi
fi

#we are first creating source and destination directory through shell prompt ex:app-logs destination-dir
#now in script create folder and file for logs, source and destination directory and retention days
#we are using log function with timestamp to show output in log files
#checking root user or not 
#check source and destination directories exist or not
#we are backuping the files using usage function
#we are finding the files using find command and storing the command in files vairable; as vairable=$(command)
#archeive the file with timestamp and place in destination directory to archeive we are using tar zcvf command
#checking whether archeive is success or not and then deleting the files

#create app-logs and destination-dir directories in terminal(mobaxterm) prompt 
#in app-logs directory create some ".log" files ex:touch -d 20260215 nginx.log cart.log user.log data.log service.log
# sudo sh 26.backup.sh /home/ec2-user/app-logs /home/ec2-user/destination_dir in mobaxterm prompt
# 2026-03-02 22:48:39 | backup started
# 2026-03-02 22:48:39 | source directory is : /home/ec2-user/app-logs
# 2026-03-02 22:48:39 | destination directory is : /home/ec2-user/destination_dir
# 2026-03-02 22:48:39 | rention days is :14
# 2026-03-02 22:48:39 | files found to archeive...../home/ec2-user/app-logs/nginx.log
# /home/ec2-user/app-logs/cart.log
# /home/ec2-user/app-logs/user.log
# /home/ec2-user/app-logs/data.log
# /home/ec2-user/app-logs/service.log
# 2026-03-02 22:48:39 | Archieve name: /home/ec2-user/destination_dir/app-logs-2026-03-02:22:48:39.tar.gz
# tar: Removing leading `/' from member names
# /home/ec2-user/app-logs/nginx.log
# tar: Removing leading `/' from hard link targets
# /home/ec2-user/app-logs/cart.log
# /home/ec2-user/app-logs/user.log
# /home/ec2-user/app-logs/data.log
# /home/ec2-user/app-logs/service.log
# 2026-03-02 22:48:39 | Archeival is ...  SUCCESS
# 2026-03-02 22:48:39 | Deleting file: /home/ec2-user/app-logs/nginx.log
# 2026-03-02 22:48:39 | Deleted file: /home/ec2-user/app-logs/nginx.log
# 2026-03-02 22:48:39 | Deleting file: /home/ec2-user/app-logs/cart.log
# 2026-03-02 22:48:39 | Deleted file: /home/ec2-user/app-logs/cart.log
# 2026-03-02 22:48:39 | Deleting file: /home/ec2-user/app-logs/user.log
# 2026-03-02 22:48:39 | Deleted file: /home/ec2-user/app-logs/user.log
# 2026-03-02 22:48:39 | Deleting file: /home/ec2-user/app-logs/data.log
# 2026-03-02 22:48:39 | Deleted file: /home/ec2-user/app-logs/data.log
# 2026-03-02 22:48:39 | Deleting file: /home/ec2-user/app-logs/service.log
# 2026-03-02 22:48:39 | Deleted file: /home/ec2-user/app-logs/service.log


