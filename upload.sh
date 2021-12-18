#!/bin/bash
BASEDIR=$(dirname "$0")
while :
do
HOURS=$(date +%-H)
if (( ${HOURS} <= 24 )); then # only upload vids in the night.
# ${BASEDIR}/upload_scp.sh 25
#${BASEDIR}/upload_gdcp.sh 40
echo "At: $(date)"
${BASEDIR}/upload_easyeye.sh 100
fi
sleep 3
done
