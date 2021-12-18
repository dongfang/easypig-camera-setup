#!/bin/bash

#Pictures are evaluated using imagemagick, and a simple brightness number derived.
#Any picture (night time) with less brightness will be rejected.
MINIMUM_BRIGHTNESS=15

#/usr/bin/ffmpeg -y -rtsp_transport tcp -i "rtsp://192.168.0.133/user=admin&password=Xi80Smatso&channel=1&stream=0.sdp" -vcodec copy -map 0 -t 60 -f mp4 /tmp/cam133.mp4
CAMERA_URL="rtsp://192.168.0.133/user=admin&password=Xi80Smatso&channel=1&stream=0.sdp"
COMMAND="/usr/bin/avconv -rtsp_transport tcp -i ${CAMERA_URL} -f image2 -vframes 1 -pix_fmt yuvj420p"

#FPS_FACTOR=$((25 / ${VIDEO_FPS}))
#FPS_FACTOR=$(bc <<< "scale=2; 25/${VIDEO_FPS}")
#echo "FPS_FACTOR=${FPS_FACTOR}"
VIDEO_COMMAND="/usr/bin/ffmpeg -y -rtsp_transport tcp -i ${CAMERA_URL} -vcodec copy -map 0 -t ${VIDEO_LENGTH} -f mp4"
# We have to post-convert not to drop frames :(
# No. We now have set the desired frame rate in the camera itself.
# /usr/bin/avconv -y -i /tmp/survcam.mp4 -vf "setpts=${FPS_FACTOR}*PTS" -r ${VIDEO_FPS} ${FILENAME}
