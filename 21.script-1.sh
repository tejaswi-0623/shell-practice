#!/bin/bash

country="INDIA"
code="+91"

echo "I am living in $country"
echo "code of $country to phone call is $code"
echo "PID of script-1 is $$"

sh 22.script-2.sh  #by calling another script
source ./22.script-2.sh #by using source command to call another script ./ means to give present directory


#sh 22.script-2.sh for this script calling below one is output 
#I am living in INDIA
#code of INDIA to phone call is +91
#PID of script-1 is 13033
#I am living in                                
#code of the country to phone call is
#PID of script-1 is 13034

#using source command below one is output
#I am living in INDIA
#code of INDIA to phone call is +91
#PID of script-1 is 14155
#I am living in INDIA
#code of the country to phone call is +91
#PID of script-1 is 14155

#by using source command we can access other script vairables and the scripts has same PID
#by using other script call we can't access other script vairables and the PID's of both scripts are different

