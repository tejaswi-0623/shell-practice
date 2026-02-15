#!/bin/bash

###special vairables####
#$1,$2.....$N are arguments passed to script
echo "all arguments passed to script: $@"
echo "number of arguments passed to script: $#"
echo "to know script name: $0"
echo "present working directory: $PWD"
echo "who is running the script: $USER"
echo "process intsance id (PID) of the script: $$"
sleep 10 &
echo "process instance id (PID) of recently excuted background process: $!"
echo "exit status of previous command: $?"



#sh 07.specialvairables.sh mani hani rani
#all arguments passed to script: mani hani rani
#number of arguments passed to script: 3
#to know script name: 07.specialvairables.sh
#present working directory: /home/ec2-user/shell-practice
#who is running the script: ec2-user
#process intsance id (PID) of the script: 15661
#process instance id (PID) of recently excuted background process: 15662
#exit status of previous command: 0
