#!/bin/bash

number=$1

if [ $number -gt 30 ]; then
echo "given number is greater than 30"

elif [ $number -eq 30 ]; then
echo "given number is equal to 30"

else
echo "given number is less than 30"

fi