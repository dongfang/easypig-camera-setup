#!/bin/bash
CAMERALIGHT_FROM_HOUR=25
CAMERALIGHT_TO_HOUR=-1
CAMERALIGHT_WAIT=0
CAMERALIGHT_PORT=1
CAMERALIGHT_ON=0
CAMERALIGHT_OFF=1

#Pictures are evaluated using imagemagick, and a simple brightness number derived.
#Any picture (night time) with less brightness will be rejected.
MINIMUM_BRIGHTNESS=15

AUTO_EXPOSURE=1
#BRIGHTNESS=100
FOCUS_AUTO=0
FOCUS_ABSOLUTE=20

#EXPOSURE=100
DELAY=1

ARGS=""
DA=$([ -n "${DELAY}" ] && echo " -D${DELAY}" || echo "")
#EA=$([ -n "${EXPOSURE}" ] && echo " --set-exposure=${EXPOSURE}" || echo "")
ARGS=${ARGS}${DA}

CONTROL="/usr/bin/v4l2-ctl"
#${CONTROL} -c exposure_auto=${AUTO_EXPOSURE}
if [ -n "${BRIGHTNESS}" ]; then ${CONTROL} -c brightness=${BRIGHTNESS}; fi
#${CONTROL} -c focus_auto=${FOCUS_AUTO}
#${CONTROL} -c focus_absolute=${FOCUS_ABSOLUTE}

COMMAND="/usr/bin/fswebcam --no-banner ${ARGS} -r 1280x720 --fps 15 -S 50"

NUM_FRAMES=$((${VIDEO_LENGTH} * ${VIDEO_FPS}))
# https://raspberrypi.stackexchange.com/questions/23953/webcam-capture-into-mp4-or-mov-ffmpeg-is-very-slow-at-this - a  soft-encode solution.
# It really should be possible without gstreamer?!?
#VIDEO_COMMAND="/usr/bin/avconv -f video4linux2 -input_format h264 -video_size hd1080 -framerate 5 -i /dev/video0 -c copy "
VIDEO_COMMAND="/usr/bin/gst-launch-1.0 -e uvch264src num-buffers=${NUM_FRAMES} device=/dev/video0 name=src auto-start=true src.vidsrc ! queue ! video/x-h264,width=1280,height=720,framerate=${VIDEO_FPS}/1 ! h264parse ! mp4mux ! filesink location="
