#!/bin/bash
email=soren.kuula@gmail.com

check_file_growing() {
cam_no=$1
HOURS=$(date +"%H")
if [ $HOURS -lt 5 ] ; then
return 0
continue
elif [ $HOURS -gt 17 ] ; then
return 0
fi

before=$(ls -la /tmp | grep ipcam_${cam_no} | cut -c25-33)
sleep 30
after=$(ls -la /tmp | grep ipcam_${cam_no} | cut -c25-33)
if [ -e "${before}" ]; then return 1; fi
if [ -e "${after}" ]; then return 1; fi
if [ "${after}" -gt "${before}" ]; then
return 0
else
echo "Ingen vaekst i filstr. set fra ${cam_no} ${before} / ${after}."
echo "Ingen vaekst i filstr. set fra ${cam_no} ${before} / ${after}." | mail -s "Problem med kamera ${cam_no}" ${email}
return 1
fi
}

check_ping() {
address=$1
/bin/ping -q -c3 192.168.0.${address}
result=$?
if [ "${result}" -ne "0" ]; then
echo "Ingen ping respons hoert fra ${cam_no}"
echo "Ingen ping respons hoert fra ${cam_no}" | mail -s "Problem med kamera ${cam_no}" ${email}
fi
return ${result}
}

cam_no=$1
check_file_growing ${cam_no}
check_ping ${cam_no}
