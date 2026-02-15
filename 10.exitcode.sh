#!bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]; then
  echo "please give root access to user and run the script"
  exit 1
fi

echo "installing nginx"
dnf install nginx -y

if [ $? -ne 0 ]; then
 echo "nginx installation is failure"
else
 echo "nginx installation is success"

fi