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


#if we give set -e no need to call validate function
#if we give two packages like this sudo sh 18.set.sh nginx hkdhfid in run time we got output like below
#nginx already installed,  skipping now
#we didn't get any output or error msg in terminal but if you check in logs like below we observe error
#sudo less var/log/shell-practice/18.set.sh.log
#Installed Packages
#nginx.x86_64           2:1.20.1-22.el9_6.3           @rhel-9-appstream-rhui-rpms
#Error: No matching Packages to list
#var/log/shell-practice/18.set.sh.log (END)
#that is second package is wrong and exited the script
