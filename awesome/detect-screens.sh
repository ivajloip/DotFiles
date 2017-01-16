#!/bin/bash

HDMI_SCREEN="HDMI1"
LAPTOP_SCREEN="eDP1"

if ( xrandr | grep "${HDMI_SCREEN} connected" > /dev/null ); then
  echo "Switching to dual-screen"
  xrandr --output ${LAPTOP_SCREEN} --auto --output ${HDMI_SCREEN} --auto --primary --left-of ${LAPTOP_SCREEN}
elif ( xrandr | grep "${HDMI_SCREEN} disconnected" > /dev/null ); then
  echo "Switching back to single screen"
  xrandr --output ${LAPTOP_SCREEN} --auto --primary --output ${HDMI_SCREEN} --off
fi
