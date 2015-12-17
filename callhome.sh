#!/bin/bash

: ${VERBOSE:=0}
: ${PIDFILE:=/var/run/callhome.pid}
: ${HQ_HOST:=hq.example.com}
: ${HQ_PORT:=2022}
: ${STRICTHOSTKEYCHECKING:=yes}
: ${PROXY_PORT:=2022}
: ${IDENTITYFILE:=./example/id_rsa}

if [ -r $PIDFILE ] && pkill -0 -F $PIDFILE
then
  echo "already running, exiting.." >&2
  exit 0
fi

if ssh -p ${HQ_PORT} -i ${IDENTITYFILE} -o StrictHostKeyChecking=${STRICTHOSTKEYCHECKING} -fNT -R ${PROXY_PORT}:127.0.0.1:22 ${HQ_HOST}
then
  pgrep -P 1 -n -f "ssh -p ${HQ_PORT}" > $PIDFILE
else
  echo "cannot dial home :( exiting.." >&2
  exit 1
fi
