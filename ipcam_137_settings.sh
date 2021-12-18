#!/bin/bash

#Pictures are evaluated using imagemagick, and a simple brightness number derived.
#Any picture (night time) with less brightness will be rejected.
MINIMUM_BRIGHTNESS=15

#SUFFIX=".mp4"

CAMERA_URL="rtsp://admin:Xi80Smatso@192.168.0.137/Streaming/Channels/101"
COMMAND="/usr/bin/avconv -rtsp_transport tcp -i ${CAMERA_URL} -f image2 -vframes 1 -pix_fmt yuvj420p"

#FPS_FACTOR=$((25 / ${VIDEO_FPS}))
#FPS_FACTOR=$(bc <<< "scale=2; 25/${VIDEO_FPS}")
#echo "FPS_FACTOR=${FPS_FACTOR}"
VIDEO_COMMAND="/usr/bin/ffmpeg -y -rtsp_transport tcp -i ${CAMERA_URL} -c copy -map 0 -t ${VIDEO_LENGTH} -f mp4"
# We have to post-convert not to drop frames :(
# No. We now have set the desired frame rate in the camera itself.
# /usr/bin/avconv -y -i /tmp/survcam.mp4 -vf "setpts=${FPS_FACTOR}*PTS" -r ${VIDEO_FPS} ${FILENAME}
