#!/bin/bash
BASEDIR=$(dirname "$0")
CAMERANAME=${1}
LOCKFILE="/tmp/${CAMERANAME}.lock"
VIDEO_LENGTH=${2}

#if [ ! -f ${LOCKFILE} ]; then
#touch ${LOCKFILE}

SETTINGSFILENAME=${BASEDIR}/${CAMERANAME}_settings.sh
if [ -f ${SETTINGSFILENAME} ]; then
. ${SETTINGSFILENAME}

# Status LED
#STATUSLIGHT=13
#if [ ! -d /sys/class/gpio/gpio${STATUSLIGHT} ]; then
#  sudo echo ${STATUSLIGHT} > /sys/class/gpio/export
#  sleep 1
#fi
#sudo echo out > /sys/class/gpio/gpio${STATUSLIGHT}/direction
#sudo echo 1 > /sys/class/gpio/gpio${STATUSLIGHT}/value

TEMPFILENAME=/tmp/${CAMERANAME}_$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1).mp4
FILENAME="/home/pi/videos/${CAMERANAME}_"$(date +%y%m%d_%H%M%S).mp4

# Camera light (always on)
#if [ ! -d /sys/class/gpio/gpio${CAMERALIGHT_PORT} ]; then
#  sudo echo ${CAMERALIGHT_PORT} > /sys/class/gpio/export
#  sleep 1
#  sudo echo out > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/direction
#  sudo echo ${CAMERALIGHT_OFF} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value
#fi

#sudo echo ${CAMERALIGHT_ON} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value
#sleep ${CAMERALIGHT_WAIT}

# Unfortuantely, we can't reliably re-encode the stream here. We just have to record in source frame rate.
echo ${VIDEO_COMMAND} ${TEMPFILENAME}
${VIDEO_COMMAND} ${TEMPFILENAME}

#sudo echo ${CAMERALIGHT_OFF} > /sys/class/gpio/gpio${CAMERALIGHT_PORT}/value

mv ${TEMPFILENAME} ${FILENAME}
echo "Final name : ${FILENAME}"

else
echo "${CAMERANAME} was not set up"
fi

#rm ${LOCKFILE}
#else
#echo "Lockfile for ${CAMERANAME} exists, exiting."
#fi
