#!/bin/bash

count=1

while [ $count -le 5 ]
do
  echo "count now is $count"
  sleep 1
  ((count++))
done


while IFS= read -r line; do
  # Process each line here
  echo "$line"
done < 22-script-2.sh # input which file to read