#!/bin/bash
#to hide the password from reading in prompt script

echo "please enter user name"
read user_name
echo "user name is: $user_name"

echo "please enter password"
read -s password

#echo "password you enter is: $password" 
