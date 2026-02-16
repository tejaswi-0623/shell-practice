#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]; then
  echo "please run this script with root user access"
  exit 1
fi

validate(){
    if [ $1 -ne 0 ]; then
     echo "$2 is.....success"
    else
     echo "$2 is.....failed"
    fi
}

dnf install nginx -y
validate $? "nginx installation"

dnf install mysql -y
validate $? "mysql installation"

dnf install redis -y
validate $? "redis installation"



