#!/bin/bash

logs_folder="/home/ec2-user/app-logs"
logs_file="$logs_folder/$0.log"

if [ ! -d $logs_folder ]; then
  echo -e "$logs_folder does not exist"
  exit 1
fi

files_to_delete=$(find $logs_folder -name "*.log" -mtime +14) #vairable=$(command)


while IFS= read -r file; do
  echo  "deleteing files are: $file"
  rm -f $file
  echo  "deleted files: $file"
done <<< $files_to_delete 

#to schedule time to delete log for example to delte now
#crontab -e edit crontab file like this to every minute ==>* * * * * sh /home/ec2-user/shell-practice/25.crontab.sh
#save the crontab file
#sudo tail -f /var/log/cron now we will see the shell-practice/25.crontab.sh deleting files
#now cd and go to cd app-logs and give list ls -l the log files older than 14 days will be deleted
#like this we can write script to delete log files and delete them by scheduling crontabs
#mkdir app-logs and create some files with older than 14 days and then execute this script
