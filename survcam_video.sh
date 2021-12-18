#!/bin/bash
FILENAME=${1}
#FPS_FACTOR=$((25 / ${VIDEO_FPS}))
FPS_FACTOR=$(bc <<< "scale=2; 25/${VIDEO_FPS}")
echo "FPS_FACTOR=${FPS_FACTOR}"
/usr/bin/avconv -y -rtsp_transport tcp -i "rtsp://192.168.1.10/user=admin&password=Gr8nadA&channel=1&stream=0.sdp" -c copy -map 0 -t ${VIDEO_LENGTH} -f mp4 /tmp/survcam.mp4
# We have to post-convert not to drop frames :(
# No. We now have set the desired frame rate in the camera itself.
# /usr/bin/avconv -y -i /tmp/survcam.mp4 -vf "setpts=${FPS_FACTOR}*PTS" -r ${VIDEO_FPS} ${FILENAME}
mv /tmp/survcam.mp4 ${FILENAME}
