#!/bin/bash
BASEDIR=$(dirname "$0")
export VIDEO_LENGTH=300
export VIDEO_FPS=10
${BASEDIR}/video.sh raspicam
${BASEDIR}/video.sh webcam
PING="/bin/ping -q -c1 -W 10"
${PING} 192.168.1.10 > /dev/null
if [ $? -eq 0 ]; then
  echo "LAN OK"
else
#  echo "wlan0 network connection is down! Attempting reconnection."
  sudo /sbin/ifdown eth0 && sudo /sbin/ifup eth0
fi

${BASEDIR}/video.sh securitycam
