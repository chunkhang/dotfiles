#!/usr/bin/env zsh

~/.scripts/helpers/notify.zsh "Ubersicht" "Refreshing..."
osascript -e 'tell application "Übersicht" to refresh'
