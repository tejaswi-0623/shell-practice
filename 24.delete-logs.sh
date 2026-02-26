#!/bin/bash

logs_folder="/home/ec2-user/app-logs"
logs_file="$logs_folder/$0.log"

if [ ! -d $logs_folder ]; then  #to check directory or folder that exists to delete the logs
  echo -e " $logs_folder doesn't exist"
  exit 1
fi

files_to_delete=$(find $logs_folder -name "*.log" -mtime + 14) 
#name==file names *.log==log files to delete mtime==modified time +14=older than 14 days

while IFS= read -r filepath; do #filepath is vairable here
  echo "the files need to be deleted or deleting files: $filepath"
  rm -f $filepath  #rm==remove f=force 
  echo "deleted files are: $filepath"
done <<< $files_to_delete #<<<==appeending input vairable


# here we are writing while loop to read the files line by line