#!/bin/bash
INTERVAL=60
#echo $EACH_VIDEO_LENGTH
CAMNAME=$1
BASEDIR=$(dirname "$0")
while :
do
HOURS=$(date +"%H")
if [ $HOURS -lt 5 ] ; then
sleep 1
continue
elif [ $HOURS -gt 20 ] ; then
sleep 1
continue
fi
NOW=$(date +%s)
((FIRE=${NOW} + ${INTERVAL} - ( ${NOW} % ${INTERVAL} ) + 10 ))
FIRE_DATETIME=$(date -d @${FIRE})
echo Firing photo at time ${FIRE_DATETIME}
while :
do
NOW=$(date +%s)
if [ $NOW -ge $FIRE ]; then break
sleep 1
fi
done
#echo Firing now.
${BASEDIR}/photo.sh ${CAMNAME}
#date -d @${END}
done
