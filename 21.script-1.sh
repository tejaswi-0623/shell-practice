#!/bin/bash

country="INDIA"
code="+91"

echo "I am living in $country"
echo "code of $country to phone call is $code"
echo "PID of script-1 is $$"

#sh 22.script-2.sh  #by calling another script
source ./22.script-2.sh #by using source command to call another script


#sh 22.script-2.sh for this script calling
#I am living in INDIA
#code of INDIA to phone call is +91
#PID of script-1 is 13033
#I am living in
#code of the country to phone call is
#PID of script-1 is 13034
