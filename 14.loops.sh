#!/bin/bash

userid=$(id -u)
logs_folder="var/log/shell-practice" #is folder path
logs_file="var/log/shell-practice/$0.log" #file path and $0 means script name

if [ $userid -ne 0 ]; then
  echo "please run the script with root user access" | tee -a $logs_file
  exit 1
fi

mkdir -p $logs_folder

validate(){
    if [ $1 -ne 0 ]; then
     echo "$2 is......failed" | tee -a $logs_file
     exit 1
    else
    echo "$2 is......success" | tee -a $logs_file
}

for package in $@ # sudo sh 14-loops.sh nginx mysql means giving args at run time
do 
  dnf install $package -y &>> $logs_file
  validate $? "$package installation"
done

#package is vairable
#$@ means giving all arguments
#calling $1=$? and $2=$package installation and $package means accessing package vairable
#userid,logs_folder and logs_file are vairables
#tee means print in the screen and save output in logs_file 
#&>> means append at output and show errors to logs_file
#if you run sh 14.loops.sh we get output ad please run the script with root user access
#if you run sudo 14.loops.sh mysql nginx will install them at run time instead of giving them in code