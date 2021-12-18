#!/bin/bash
CAMERALIGHT_FROM_HOUR=0
CAMERALIGHT_TO_HOUR=25

# How to disable completely
#CAMERALIGHT_FROM_HOUR=30
#CAMERALIGHT_TO_HOUR=-1
CAMERALIGHT_WAIT=0
CAMERALIGHT_PORT=6

#Pictures are evaluated using imagemagick, and a simple brightness number derived.
#Any picture (night time) with less brightness will be rejected.
MINIMUM_BRIGHTNESS=15
CAMERALIGHT_ON=0
CAMERALIGHT_OFF=1

SUFFIX=".h264"

COMMAND="/usr/bin/raspistill -w 1280 -h 720 --nopreview --timeout 1000 -o"
VIDEO_COMMAND="/home/pi/bin/raspivid.sh "
