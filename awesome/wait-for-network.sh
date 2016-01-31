#!/bin/bash

until wget -q -O - http://www.duckduckgo.com | grep 'Help Spread DuckDuckGo!' > /dev/null; do
  sleep 2
done

for arg; do
  if ! ( pgrep -u $USER -x $(echo $arg | cut -f 1 -d " ") > /dev/null ); then
    $arg &
  fi
done
