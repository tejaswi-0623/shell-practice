#!/bin/bash

num1=100
#num2=200.5

#sum=$(($num1+num2))
#echo "the result is: $sum"

#syntax error: invalid arithmetic operator (error token is ".5") shell doesn't support float

num3=200
sum2=$(($num1+$num3))
ech0 "the result is: $sum2"


