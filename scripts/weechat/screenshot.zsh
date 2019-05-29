#!/usr/bin/env zsh

directory="$TMPDIR"
filename="screenshot.png"
destination="$directory$filename"

# Create image from clipboard
pngpaste "$destination"
if [ $? -eq 0 ]; then
    echo "$destination"
    exit 0
else
    exit 1
fi
