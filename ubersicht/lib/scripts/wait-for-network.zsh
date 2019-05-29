#!/usr/bin/env zsh

# Check for internet connection every 10 seconds until successful
# https://github.com/felixhageloh/uebersicht/issues/196#issuecomment-212549931
while true; do
    if ping -c 1 8.8.8.8 &> /dev/null; then
        break
    else
        sleep 10
    fi
done
