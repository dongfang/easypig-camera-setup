#!/bin/bash
BASEDIR=$(dirname "$0")
CAMNAME=${1}
VIDEO_LENGTH=${2}
while : 
do
${BASEDIR}/video_loop.sh ${CAMNAME} ${VIDEO_LENGTH} 2>&1 >> ~/${CAMNAME}.log
done
