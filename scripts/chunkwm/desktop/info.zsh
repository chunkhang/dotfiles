#!/usr/bin/env zsh

desktop="Desktop $(chunkc tiling::query --desktop id)"
mode="Mode: $(chunkc tiling::query --desktop mode)"

title="Desktop Manager"
subtitle="$desktop | $mode"
~/.scripts/helpers/notify.zsh $title $subtitle
