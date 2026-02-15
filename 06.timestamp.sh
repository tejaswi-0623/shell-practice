#!bin/bash

#timestamp=$(date)
#echo "script executed at: $timestamp" ----to know executed script time

start_time=$(date +%s)
echo "program start time is: $start_time"

sleep 10

end_time=$(date +%s)
echo "program executed time is: $end_time"

total_time=$(($end_time-$start_time))
echo "the duration of program is: $total_time"