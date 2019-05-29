#!/usr/bin/env zsh

title=$1
content=$2

osascript << EOF
    display dialog "$content" with title "$title" \
    buttons {"Close"} default button "Close"
EOF
