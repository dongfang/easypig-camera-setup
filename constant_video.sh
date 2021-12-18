#!/bin/bash
EACH_VIDEO_LENGTH=3600
CAMNAME=$1
BASEDIR=$(dirname "$0")
while :
do
HOURS=$(date +"%H")
if [ $HOURS -lt 5 ] ; then
sleep 1
continue
elif [ $HOURS -gt 17 ] ; then
sleep 1
continue
fi
NOW=$(date +%s)
((LENGTH=${EACH_VIDEO_LENGTH} - ( ${NOW} % ${EACH_VIDEO_LENGTH} ) ))
((END=${NOW} + ${LENGTH}))
END_DATETIME=$(date -d @${END})
NOW_DATETIME=$(date -d @${NOW})
echo ${NOW_DATETIME}: Making video of length ${LENGTH}, should be until ${END_DATETIME}
${BASEDIR}/video.sh ${CAMNAME} ${LENGTH}
sleep 5
#date -d @${END}
done
