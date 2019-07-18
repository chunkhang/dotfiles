#!/usr/bin/env zsh

# Open mission control
skhd --key "shift + ctrl - up"

# Create new desktop
osascript &>/dev/null << EOF
    tell application "System Events"
        click (every button whose value of attribute "AXDescription" is "add desktop") \
        of group "Spaces Bar" of group $(chunkc tiling::query --monitor id) of group "Mission Control" of process "Dock"
    end tell
EOF

# Close mission control
skhd --key "escape"

# Get desktop id
all_desktops=$(chunkc tiling::query --desktops-for-monitor $(chunkc tiling::query --monitor id))
desktop=$(echo -n $all_desktops | tail -c 1)

# Switch to desktop
sleep 0.25
skhd --key "ctrl - $desktop"

title="Desktop Manager"
subtitle="Desktop $desktop created"
~/.scripts/helpers/notify.zsh $title $subtitle
