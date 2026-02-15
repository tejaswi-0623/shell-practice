#!/bin/bash

num1=100
#num2=200.5

#sum=$(($num1+num2))
#echo "the result is: $sum"
#syntax error: invalid arithmetic operator (error token is ".5") shell doesn't support float

num3=200
sum2=$(($num1+$num3))
echo "the result is: $sum2"
#the result is: 300



num4=honey
sum3=$(($num1+$num4))
echo "the result is: $sum3"
#the result is: 100 here it takes string value as zero and performed operation

#Array
fruits=("apple","cherry","banana","pear")
echo "Fruits we defined are: ${fruits[@]}"
echo "first fruit is: ${fruits[0]}"
echo "second fruit is: ${fruits[1]}"
echo "third fruit is: ${fruits[2]}"
echo "fourth fruit is: ${fruits[3]}"