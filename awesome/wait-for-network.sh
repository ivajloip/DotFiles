#!/bin/bash

until wget -q -O - http://www.duckduckgo.com | grep "DuckDuckGo" | grep "track" > /dev/null; do
  sleep 2
  notify-send -u critical -t 1500 "No internet connection detected. Maybe login is required."
done

for arg; do
  if ! ( pgrep -u $USER -x $(echo $arg | cut -f 1 -d " ") > /dev/null ); then
    $arg &
  fi
done
