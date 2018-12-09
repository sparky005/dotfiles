#!/usr/bin/env bash

# Terminate already running bar instances
killall -q redshift

# Wait until the processes have been shut down
while pgrep -u $UID -x redshift >/dev/null; do sleep 1; done

# Launch bar1 and bar2
redshift -l $(curl ipinfo.io | jq -j .loc | tr ',' ':') &> /var/log/redshift/redshift.log &

echo "Redshift launched!"
