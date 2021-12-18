#!/bin/bash
BASEDIR=$(dirname "$0")
NUM_FILES=$1
MAX_AGE=100
PICTUREDIR="/home/pi/pictures"
ARCHIVEDIR="/home/pi/archive"

. ${BASEDIR}/set_reverse_proxy.sh

LOCKFILE=/tmp/upload.lock
if [ ! -f ${LOCKFILE} ]; then
  touch ${LOCKFILE}

  FILES=$(ls -1t ${PICTUREDIR} | tail -n${NUM_FILES})
  if [ ! -z "${FILES}" ]; then
    echo "Trying to send ${FILES}"
    cd ${PICTUREDIR}
    scp ${FILES} ${REVERSE_PROXY_USER}@${REVERSE_PROXY_SERVER}:$(hostname)
    RC=$?
    if [ ${RC} -eq 0 ]; then
      echo "Success, archiving the files."
      mv ${FILES} ${ARCHIVEDIR}
    fi
  else
    echo "Nothing to do!"
  fi
  # Clean out anything older than MAX_AGE days
  # find ${ARCHIVEDIR} -mtime +${MAX_AGE} -exec rm \{\} \;

  rm ${LOCKFILE}
fi
