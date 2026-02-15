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
