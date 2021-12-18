#!/bin/bash
email=soren.kuula@gmail.com
lsusb | grep Logitech
result=$?
if [ "${result}" -ne "0" ]; then
echo "Intet USB webcam set paa $(hostname)"
echo "Intet USB webcam set paa $(hostname)" | mail -s "Problem med webcam" ${email}
fi
#return ${result}

