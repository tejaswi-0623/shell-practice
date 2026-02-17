#!bin/bash

userid=$(id -u)
logs_folder="var/log/shell-practice"
logs_file="var/log/shell-practice/$0.log"

if [ $userid -ne 0 ]; then
 echo "please run the script with root user access" | tee -a $logs_file
 exit 1
fi

mkdir -p $logs_folder

validate(){
    if [ $1 -ne 0 ]; then
     echo "$2 installation is.......failed" | tee -a $logs_file
     exit 1
    else
     echo "$2 installation is ......success" | tee -a $logs_file
    fi
}

for package in $@ #sudo give package names at run time
do 
 dnf list installed $package &>> $logs_file
  if [ $? -ne 0 ]; then
    echo "$package not installed, installing now" 
    dnf install $package -y &>> $logs_file
    validate $? "$package"
  else
  echo "$package is already installed, so skipping now"
  fi

done

#userid not equal to 0 so asking to get root user access and exit the script
#we need to check status of initial command everytime shell won't do so we have to check
#for that we are writing validate function to check status of previous command if not equal to zero will failed and exit the script if equals to zero script will eun further
#if we have multiple packages to install we can write in for loop and can give package names suring time
#in this we are checking for packages installed list if there script will say already installed otherwise it will install new package
#we are calling validate function $1=$? and $2=$package
#if we give like this  sh 15.packages.sh below one is output
#tee: var/log/shell-practice/15.packages.sh.log: Permission denied
#please run the script with root user access
#if we give like this  sudo sh 15.packages.sh nginx mysql nodejs below one is output
#nginx is already installed, so skipping now
#mysql is already installed, so skipping now
#nodejs not installed, installing now
#nodejs installation is ......success

