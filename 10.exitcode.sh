#!bin/bash

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


#id -u represents user id if id is 0--->root access o
#id is number---->user id
#exit 1 means if any error then stop the script
#sudo sh 10.exitcode.sh
#nginx will be installed now