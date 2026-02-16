#!/bin/bash

userid=$(id -u)  #userid is vairable 
Logs_folder="var/log/shell-practice"  
Logs_file="var/log/shell-practice/$0.log"  

if [ $userid -ne 0 ]; then
  echo "please run this script with root user access" | tee -a $Logs_file
  exit 1
fi

mkdir -p $Logs_folder #$Logs_folder is accessing vairable

validate(){
    if [ $1 -ne 0 ]; then
      echo " $2 is..........failed" | tee -a $Logs_file
      exit 1
    else
      echo " $2 is.........success" | tee -a $Logs_file
    fi
}

dnf install nginx -y &>> $Logs_file
validate $? "nginx installtion"

dnf install mysql -y &>> $Logs_file
validate $? "mysql installation"

dnf install redis -y &>> $Logs_file
validate $? "redis installation"

#logs_folder is vairable and "var/log/shell-practice" is folder path
#logs_file is vairable and "var/log/shell-practice/$0.log" is file path and $0 is script name
#-p means if there okay otherwise create folder with name logs_folder
#tee command will print in the screen and save it in the logs_file
#-a means append -->not overwrite the log_file just append to it
#&>> $LOGS_FILE appends both at output and errors to a log file.