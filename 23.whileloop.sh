#!/bin/bash

count=1

while [ $count -le 5 ]
do
  echo "count now is $count"
  sleep 1
  ((count++))
done


while IFS= read -r line; do   #will read the file line by line ifs=internal field  and line is vairable here
  echo "$line" #print line
done < 22.script-2.sh # input which file to read