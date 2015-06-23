#!/usr/bin/env bash

if [ $# -lt 3 ]; then
  echo "Usage: ./record-server-info.sh APP USERNAME PASSWORD"
  exit 1
fi

APP=$1
USER=$2
PASS=$3

PORT=8080
GCONTROL=/usr/local/lib/python2.7/dist-packages/gcontrol/git-shell-commands/gcontrol

DATE=$(date)

MACHINES=$(sudo -H -u $APP $GCONTROL inventory | grep MeteorApp)
while read -r MACHINE; do
  IP=$(echo "$MACHINE" | cut -f 1 -d ' ')
  NAME=$(echo "$MACHINE" | cut -f 2 -d '/' | cut -f 1 -d ")")

  OUTPUT=$(curl "http://$USER:$PASS@$IP:$PORT/info")
  echo $OUTPUT
done <<< "$MACHINES"
