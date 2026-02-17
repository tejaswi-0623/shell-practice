#!/bin/bash
set -e # this will be checking for errors, if errors it will exit

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
     echo -e "$2 installation is .......$red failed $normal" |tee -a $logs_file
     exit 1
    else
      echo -e "$2 installation is .....$green success $normal" |tee -a $logs_file
    fi
}

for package in $@  #give package names at run time with sudo access
  do
    dnf list installed $package &>> $logs_file #list of installed packages
    if [ $? -ne 0 ]; then
       echo -e "$package not installed, $blue installing now $normal"
       dnf install $package -y &>> $logs_file
       #validate $? "$package"
    else
      echo -e "$package already installed, $yellow skipping now $normal"
    fi
done