#!/bin/bash

userid=$(id -u)
logs_folder="var/log/shell-practice"
logs_file="var/log/shell-practice/$0.log"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
normal="\e[0m"

if [ $userid -ne 0 ]; then
 echo -e "$red please run this script with root user access $normal" |tee -a $logs_file
 exit 1
fi

mkdir -p $logs_folder

validate(){
    if [ $1 -ne 0 ]; then
     echo -e "$red $2 installation is .......failed $normal" |tee -a $logs_file
     exit 1
    else
      echo -e "$green $2 installation is .....success $normal" |tee -a $logs_file
    fi
}

for package in $@  #give package names at run time with sudo access
  do
    dnf list installed $package &>> $logs_file #list of installed packages
    if [ $? -ne 0 ]; then
       echo -e " $blue $package not installed, installing now $normal"
       dnf install $package -y &>> $logs_file
       validate $? "$package"
    else
      echo -e "$yellow $package already installed, skipping now $normal"
    fi
done