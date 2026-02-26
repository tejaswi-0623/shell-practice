#!/bin/bash

logs_folder="/home/ec2-user/app-logs"
logs_file="$logs_folder/$0.log"

if [ ! -d $logs_folder ]; then
  echo -e "$logs_folder does not exist"
  exit 1
fi

files_to_delete=$(find $logs_folder -name "*.log" -mtime +14) #vairable=$(command)


while IFS= read -r $file; do
  echo  "deleteing files : $logs_folder"
  rm -f $file
  echo  "deleted files: $file"
done <<< $files_to_delete 