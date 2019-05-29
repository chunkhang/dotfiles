#!/usr/bin/env zsh

if ! pgrep afplay &>/dev/null; then
    ~/.scripts/helpers/notify.zsh "Rain Machine" "Rain starts falling..."
    afplay -q 1 ~/Dropbox/wiki/assets/audio/rain.m4a &>/dev/null &!
else
    ~/.scripts/helpers/notify.zsh "Rain Machine" "The rain stopped."
    killall afplay &>/dev/null
fi
