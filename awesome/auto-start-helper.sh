#!/bin/bash

STATE_LINE=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep 'state'`
STATE=$(echo $STATE_LINE | cut -f 2 -d ' ')

echo $STATE

while [ ! -e $HOME/Private/.readable ]; do
  echo "Waiting for encrypted directory..."
  sleep 0.3s
done

if [ "$STATE" != "discharging" ]; then
  echo "Not on battery"
  ${HOME}/.config/awesome/wait-for-network.sh $@
else
  echo "On batterry"
  echo "Not running applications"
fi
