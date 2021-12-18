#!/bin/bash
CAMERALIGHT_FROM_HOUR=6
CAMERALIGHT_TO_HOUR=12
CAMERALIGHT_WAIT=3
CAMERALIGHT_PORT=12

#Pictures are evaluated using imagemagick, and a simple brightness number derived.
#Any picture (night time) with less brightness will be rejected.
MINIMUM_BRIGHTNESS=15

CAMERALIGHT_ON=0
CAMERALIGHT_OFF=0
SUFFIX=".mp4"

COMMAND="/usr/bin/avconv -rtsp_transport tcp -i rtsp://192.168.1.10/user=admin&password=Gr8nadA&channel=1&stream=0.sdp -f image2 -vframes 1 -pix_fmt yuvj420p"
VIDEO_COMMAND="/home/pi/bin/survcam_video.sh"
