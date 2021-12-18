#!/bin/bash
VIDEO_LENGTH=${2}
CAMNAME=${1}
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
((LENGTH=${VIDEO_LENGTH} - ( ${NOW} % ${VIDEO_LENGTH} ) ))
((END=${NOW} + ${LENGTH}))
NOW_DATETIME=$(date -d @${NOW})
END_DATETIME=$(date -d @${END})
echo ${NOW_DATETIME}: making video of length ${LENGTH}, should be until ${END_DATETIME}
${BASEDIR}/video.sh ${CAMNAME} ${LENGTH}
#date -d @${END}
done
