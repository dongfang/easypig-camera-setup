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
ARCHIVEDIR="/home/pi/archive"

. ${BASEDIR}/set_reverse_proxy.sh

LOCKFILE=/tmp/upload.lock
FOLDERIDFILE=/tmp/gdcp.folder.id

if [ ! -f ${LOCKFILE} ]; then
  touch ${LOCKFILE}

  FILES=$(ls -1t ${PICTUREDIR} | head -n${NUM_FILES})
  if [ ! -z "${FILES}" ]; then
    # echo "Trying to send ${FILES}"
    cd ${PICTUREDIR}

    if [ ! -f ${FOLDERIDFILE} ]; then
	echo resolving folder ID
      HOSTNAME=$(hostname)
      SINGLE="single"$(echo $HOSTNAME | cut -c4)
      FOLDERID=$(${BASEDIR}/gdcp list | grep ${SINGLE} | cut -f2)
      echo ${FOLDERID} > ${FOLDERIDFILE}
    echo $FOLDERID

    fi
    
    FOLDERID=$(cat ${FOLDERIDFILE})

    ${BASEDIR}/gdcp upload -p ${FOLDERID} ${FILES} 
    RC=$?

    if [ ${RC} -eq 0 ]; then
      echo "Success, archiving the files."
#      mv ${FILES} ${ARCHIVEDIR}
rm ${FILES}
    fi
  else
    echo "Nothing to do!"
  fi
  # Clean out anything older than MAX_AGE days
  # find ${ARCHIVEDIR} -mtime +${MAX_AGE} -exec rm \{\} \;

  rm ${LOCKFILE}
fi
