#!/usr/bin/env zsh

# Open mission control
skhd --key "shift + ctrl - up"

# Destroy current desktop
sleep 0.5
desktop="$(chunkc tiling::query --desktop id)"
osascript << EOF
    tell application "System Events"
        tell list 1 of group "Spaces Bar" of group $(chunkc tiling::query --monitor id) of group "Mission Control" of process "Dock"
            tell button "Desktop $desktop" to perform action "AXRemoveDesktop"
        end tell
    end tell
EOF

# Close mission control
sleep 0.5
skhd --key "escape"

title="Desktop Manager"
subtitle="Desktop $desktop destroyed"
~/.scripts/helpers/notify.zsh $title $subtitle
