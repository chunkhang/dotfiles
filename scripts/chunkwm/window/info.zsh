#!/usr/bin/env zsh

owner="$(chunkc tiling::query --window owner)"
floating="Float: $(chunkc tiling::query --window float)"
name="$(chunkc tiling::query --window name)"

title="Window Manager"
subtitle="$owner | $floating"
content=$name
~/.scripts/helpers/notify.zsh $title $subtitle $content
