#!/bin/bash

set -e #ERR--->error

trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR

echo "Hello World"
echo "I am learning Shell"
echoo "printing error here"
echo "No error in this"

#run the script sh 19.trap.sh and we get output as below
#Hello World
#I am learning Shell
#19.trap.sh: line 9: echoo: command not found
#There is an error in 9, Command: echoo "printing error here"

