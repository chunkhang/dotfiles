#!/usr/bin/env zsh

title=$1
subtitle=$2
content=$3
osascript << EOF
    display notification "$content" with title "$title" subtitle "$subtitle"
EOF
