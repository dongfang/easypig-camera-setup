#!/bin/bash
LED_PORT=19
BASEDIR=$(dirname "$0")
FILENAME="/home/pi/pictures/raspicam/"`date +%d%m%Y_%H%M`.jpg
HOURS=`date +%H`
if (( ${HOURS} >= 6 && ${HOURS} <= 16 )); then USE_LIGHT=1; else USE_LIGHT=0;fi

echo "Using light: ${USE_LIGHT}"
echo "File name = ${FILENAME}"

# Camera light
if [ ! -d /sys/class/gpio/gpio${LED_PORT} ]; then
  sudo echo ${LED_PORT} > /sys/class/gpio/export
  sleep 1
fi
sudo echo out > /sys/class/gpio/gpio${LED_PORT}/direction

if [ ${USE_LIGHT} -eq 1 ]; then
  sudo echo 1 > /sys/class/gpio/gpio${LED_PORT}/value
fi

/usr/bin/raspistill -w 1280 -h 720 --nopreview --timeout 2000 -o ${FILENAME}
RC=$?

sudo echo 0 > /sys/class/gpio/gpio${LED_PORT}/value

if [ -f ${FILENAME} ]; then
  BRIGHT=$(convert ${FILENAME} -colorspace gray -format "%[fx:100*mean]" info:)
  echo ${BRIGHT}
  if [ $(echo "${BRIGHT} >= 10" | bc -l ) -eq 1 ]; then
    ${BASEDIR}/gdcp upload -p 0B7UdEKxG3H4GekRzVHFZYzBuZEU ${FILENAME}
  fi
  if [ $? -eq 0 ]; then rm ${FILENAME}; fi
fi
