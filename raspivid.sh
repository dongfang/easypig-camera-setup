#!/bin/bash
LENGTH_MS=$((${VIDEO_LENGTH} * 1000))
echo "VIDEO_FPS=${VIDEO_FPS}, LENGTH_MS=${LENGTH_MS}"
FILENAME=${1}
rm /tmp/raspicam.h264
raspivid -w 1280 -h 720 -fps ${VIDEO_FPS} -t ${LENGTH_MS} -o /tmp/raspicam.h264
MP4Box -add /tmp/raspicam.h264 ${FILENAME}
