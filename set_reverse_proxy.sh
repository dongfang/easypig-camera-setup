#!/bin/bash
BOXNUMBER=$(hostname | cut -c4)
REVERSE_PROXY_PORT=222${BOXNUMBER}
REVERSE_PROXY_USER=dongfang
REVERSE_PROXY_SERVER=35.187.184.208

SERVER_ALIVE_INTERVAL=60
SERVER_ALIVE_COUNT_MAX=3
