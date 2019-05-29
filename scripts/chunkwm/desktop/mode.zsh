#!/usr/bin/env zsh

mode="monocle"
if [ "$mode" = "$(chunkc tiling::query --desktop mode)" ]; then
    mode="bsp"
fi
chunkc tiling::desktop --layout "$mode"
title="Desktop Manager"
subtitle="Desktop now in $mode mode"
~/.scripts/helpers/notify.zsh "$title" "$subtitle"
