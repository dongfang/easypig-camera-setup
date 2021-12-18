#!/bin/bash
BASEDIR=$(dirname "$0")
CAMERANAME=${1}
SETTINGSFILENAME=${BASEDIR}/${CAMERANAME}_settings.sh

if [ ! -f ${SETTINGSFILENAME} ]; then echo "${CAMERANAME} was not set up"; exit 0; fi

. ${SETTINGSFILENAME}

TEMPFILENAME=/tmp/${CAMERANAME}_snap_temp.jpg
FILENAME="/home/pi/pictures/${CAMERANAME}_snap_"$(date +%d%m%Y_%H%M).jpg
HOURS=$(date +%-H)
STATUSLIGHT=26

if (( ${HOURS} >= ${CAMERALIGHT_FROM_HOUR} && ${HOURS} <= ${CAMERALIGHT_TO_HOUR} )); then USE_LIGHT=1; else USE_LIGHT=0;fi

# Status LED
if [ ! -d /sys/class/gpio/gpio${STATUSLIGHT} ]; then
  sudo echo ${STATUSLIGHT} > /sys/class/gpio/export
  sleep 1
fi

sudo echo out > /sys/class/gpio/gpio${STATUSLIGHT}/direction
sudo echo 1 > /sys/class/gpio/gpio${STATUSLIGHT}/value

# Camera light
if [ ! -d /sys/class/gpio/gpio${CAMERALIGHT_PORT} ]; then
  sudo echo ${CAMERALIGHT_PORT} > /sys/class/gpio/export
  sleep 1
  sudo echo out > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/direction
  sudo echo ${CAMERALIGHT_OFF} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value
fi

if [ ${USE_LIGHT} -eq 1 ]; then
  sudo echo ${CAMERALIGHT_ON} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value
#  sleep ${CAMERALIGHT_WAIT}
fi

${COMMAND} ${TEMPFILENAME} > /dev/null
CAMERA_RC=$?

sudo echo ${CAMERALIGHT_OFF} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value

#ALREADY=$(cat /sys/class/gpio/gpio13/value)
#if [ ${ALREADY} -eq 1 ]; then NEW_VALUE=0; else NEW_VALUE=1; fi
#if [ ${CAMERA_RC} -eq 0 ]; then sudo echo ${NEW_VALUE} > /sys/class/gpio/gpio13/value; fi

# Get a permission denied for trynig to set value to 0. Even as root.
if [ ${CAMERA_RC} -eq 0 ]; then $(sudo echo in > /sys/class/gpio/gpio${STATUSLIGHT}/direction); fi

if [ -f ${TEMPFILENAME} ]; then
  convert ${TEMPFILENAME} -resize 35% -rotate 90 -quality 50% -
  cp ${TEMPFILENAME} ${FILENAME}
else
  echo "No picture was taken; ${CAMERANAME} not working?"
fi
