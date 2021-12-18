#!/bin/bash
FILENAME=$1
MINIMUM_BRIGHTNESS=${2=25}

BRIGHTNESS=$(convert ${FILENAME} -colorspace gray -format "%[fx:100*mean]" info:)
RETVAL=$(echo "${BRIGHTNESS} >= ${MINIMUM_BRIGHTNESS}" | bc -l )

MESSAGE=$(if [ ${RETVAL} -eq 1 ]; then echo "OK"; else echo "Too dark"; fi)
echo "Brightness: ${BRIGHTNESS}. ${MESSAGE}"
#; if [ $retval -eq 1 ]; then echo "OK"; else echo "Too dark"; fi
exit ${RETVAL}
