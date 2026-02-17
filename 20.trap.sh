
#!/bin/bash

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR

USERID=$(id -u)
Logs_folder="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $Logs_folder

for package in $@ # sudo sh 14-loops.sh nginx mysql nodejs
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
        echo "$package not installed, installing now"
        dnf install $package -y &>>$LOGS_FILE
    else
        echo -e "$package already installed ... $Y SKIPPING $N"
    fi
done


#if we run the script like sudo sh 20.trap.sh nginx fdfijdf we get output like this
#nginx already installed ...  SKIPPING
#There is an error in 24, Command: dnf list installed $package &>> $LOGS_FILE
#first one is valid and second one is incorrect package soo showed error
#using set and trap function we can't understand the exact flow of the script like why it happened
#both validate and set,trap function do similar kind of work 
