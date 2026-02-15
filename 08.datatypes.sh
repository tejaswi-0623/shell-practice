#!/bin/bash

num1=100
#num2=200.5

#sum=$(($num1+num2))
#echo "the result is: $sum"
#syntax error: invalid arithmetic operator (error token is ".5") shell doesn't support float

num3=200
sum2=$(($num1+$num3))
echo "the result is: $sum2"


num4=honey
sum3=$(($num1+$num4))
echo "the result is: $sum3"


