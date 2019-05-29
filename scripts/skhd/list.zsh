#!/usr/bin/env zsh

title="Shortcut List"

content=""
for line in "$@"; do
    content="$content\n$line"
done

# Remove first newline
content=${content:2}
# Replace dash with tab
# Inserting tab character: https://stackoverflow.com/a/2623007
tab=$'\t'
content=$(echo $content | sed "s/ - /$tab/g")

~/.scripts/helpers/dialog.zsh $title $content
