#!/bin/bash

PKEXEC="/usr/bin/pkexec"
HELPER="/usr/sbin/xfpm-power-backlight-helper"

MAX_B=$($PKEXEC $HELPER --get-max-brightness)
CURR=$($PKEXEC $HELPER --get-brightness)
DELTA=${1}

NEW=$(python3 -c "print(round((($CURR / $MAX_B) + $DELTA / 100) * $MAX_B))")

PERCENT=$(python3 -c "print(int(round(100*$NEW/$MAX_B)))")

/usr/bin/notify-send -i /usr/share/icons/HighContrast/32x32/status/display-brightness.png -t 2000 "Brightness ${PERCENT}%"

echo $MAX_B $CURR $DELTA $NER

$PKEXEC $HELPER --set-brightness $NEW
