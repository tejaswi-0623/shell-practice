#!bin/bash

userid=$(id -u)
logs_folder="var/log/shell-practice"
logs_file="var/log/shell-practice/$0.log"

if [ $userid -ne 0 ]; then
 echo "please run the script with root user access" | tee -a $logs_file
 exit 1
fi

mkdir -p $logs_folder

validate(){
    if [ $1 -ne 0 ]; then
     echo "$2 installation is.......failed" | tee -a $logs_file
     exit 1
    else
     echo "$2 installation is ......success" | tee -a $logs_file
    fi
}

for package in $@ #sudo give package names at run time
do 
 dnf list installed $package &>> $logs_file
if [ $? -ne 0 ]; then
 echo "$package not installed, installing now" 
 dnf install $package -y &>> $logs_file
 validate $? "$package"
else
  echo "$pacakge already installed, so skipping now"
fi

done