#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]; then
  echo "please give root access to user and run the script"
  exit 1
fi

echo "installing nginx"
dnf install nginx -y

if [ $? -ne 0 ]; then
    echo "Installing Nginx ... FAILURE"
    exit 1
else
    echo "Installing Nginx ... SUCCESS"
fi

#installing mysql............................
dnf install mysql -y

if [ $? -ne 0 ]; then
 echo "installing mysql is failure"
 exit 1

else
 echo "installing mysql is success"

fi

#checking user id has root access or not
#if not have root access then exit the script
#if root user install nginx
#if you check with $? command if exit code is o then nginx installtion is success
#now install mysql
#if you check with $? command if exit code is o then mysql installtion is success