#!/bin/bash
dir_resolve()
{
cd "$1" 2>/dev/null || return $?  # cd to desired directory; if fail, quell any error messages but return exit status
echo "`pwd -P`" # output full, link-resolved path
}

NONEXPANDED=$(dirname $0) 
BASEDIR=$(dir_resolve "${NONEXPANDED}")

NUM_FILES=$1
MAX_AGE=100
PICTUREDIR="/home/pi/pictures"
VIDEODIR="/home/pi/videos"

. ${BASEDIR}/set_reverse_proxy.sh

  FILES=$(ls -1t ${PICTUREDIR} | head -n${NUM_FILES})
  if [ ! -z "${FILES}" ]; then
    # echo "Trying to send ${FILES}"
    cd ${PICTUREDIR}

    for FILE in ${FILES}; do
      echo "Trying curl -X POST -Fcid=10 -F image=@${FILE} http://${REVERSE_PROXY_SERVER}:8080/upload"
      FILENAME=$(basename ${FILE})
      CAMERANAME=$(echo ${FILENAME} | cut -d "_" -f1)
      DATE=$(echo ${FILENAME} | cut -d "_" -f2- | cut -d "." -f1)
      RESPONSE=$(curl -X POST -Fcid=$(hostname)_${CAMERANAME} -F date="${DATE}" -F filename=${FILENAME} -F image=@${FILE} http://${REVERSE_PROXY_SERVER}:8080/upload)
      RC=$?
      if [[ ${RESPONSE} == *"error"* ]]; then STUPID_HAS_ERROR=1; else STUPID_HAS_ERROR=0; fi
      if [ ${RC} -eq 0 -a ${STUPID_HAS_ERROR} -eq 0 ]; then
        rm ${FILE}
        echo "success."
      else
        echo "upload failed: ${RESPONSE}"
        exit
      fi
    done
  fi

  FILES=$(ls -1t ${VIDEODIR} | head -n1)
  if [ ! -z "${FILES}" ]; then
  # echo "Trying to send ${FILES}"
  cd ${VIDEODIR}

  for FILE in ${FILES}; do
    echo "Trying curl -X POST -Fcid=10 -F image=@${FILE} http://${REVERSE_PROXY_SERVER}:8080/videoupload"
    FILENAME=$(basename ${FILE})
    CAMERANAME=$(echo ${FILENAME} | cut -d "_" -f1)
    DATE=$(echo ${FILENAME} | cut -d "_" -f2- | cut -d "." -f1)
    RESPONSE=$(curl -X POST -Fcid=$(hostname)_${CAMERANAME} -F date="${DATE}" -F filename=${FILENAME} -F video=@${FILE} http://${REVERSE_PROXY_SERVER}:8080/videoupload)
    RC=$?
    if [[ ${RESPONSE} == *"error"* ]]; then STUPID_HAS_ERROR=1; else STUPID_HAS_ERROR=0; fi
    if [ ${RC} -eq 0 -a ${STUPID_HAS_ERROR} -eq 0 ]; then
      rm ${FILE}
      echo "success."
    else
      echo "upload failed: ${RESPONSE}"
      exit
    fi
  done
fi

