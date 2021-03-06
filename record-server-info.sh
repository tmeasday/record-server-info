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
OUTPUT=/data/readings/server-info

DATE=$(date +%F-%H:%M:%S)

MACHINES=$(sudo -H -u $APP $GCONTROL inventory | grep MeteorApp)
while read -r MACHINE; do
  IP=$(echo "$MACHINE" | cut -f 1 -d ' ')
  NAME=$(echo "$MACHINE" | cut -f 2 -d '/' | cut -f 1 -d ")")

  OUTDIR="$OUTPUT/$NAME"
  mkdir -p $OUTDIR

  curl "http://$USER:$PASS@$IP:$PORT/info" > "$OUTDIR/$DATE.json"
done <<< "$MACHINES"
