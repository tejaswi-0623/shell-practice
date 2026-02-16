#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]; then
  echo "please run this script with root user access"
  exit 1
fi

validate(){
    if [ $1 -ne 0 ]; then
     echo "$2 is.....failed"
    else
     echo "$2 is.....success"
    fi
}

dnf install nginx -y
validate $? "nginx installation"  #here $1=$? and $2=nginx installtion

dnf install mysql -y
validate $? "mysql installation"  #here $1=$? and $2=mysql installtion

dnf install redis -y
validate $? "redis installation" #here $1=$? and $2=redis installtion


#here we didnot declare vairables separately shell automatically assigned vairables by itself
#as $1--->$? and $2-->given installations
#if you run the script as sh 12.functions.sh we get output as "please run this script with root user access"
#if you run the script as sudo sh 12.functions.sh then nginx,mysql and nodejs will be installed and get as success


