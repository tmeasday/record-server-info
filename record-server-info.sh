#!/usr/bin/env bash

APP=verso
GCONTROL=/usr/local/lib/python2.7/dist-packages/gcontrol/git-shell-commands/gcontrol

MACHINES=$(sudo -H -u $APP $GCONTROL inventory | grep MeteorApp)


while read -r MACHINE; do
  IP=$(echo "$MACHINE" | cut -f 1 -d ' ')
  NAME=$(echo "$MACHINE" | cut -f 2 -d '/' | cut -f 1 -d ")")

  echo "$IP -> $NAME"
done <<< "$MACHINES"
