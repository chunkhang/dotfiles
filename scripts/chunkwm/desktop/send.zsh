#!/usr/bin/env zsh

function send {
    chunkc tiling::window --send-to-desktop "$1"
    skhd --key "ctrl - $2"
}

function main {
    local char="${1:0:1}"
    case "$char" in
        "l") send "prev" "left";;
        "r") send "next" "right";;
        *) send "$char" "$char";;
    esac
}

main "$@"
