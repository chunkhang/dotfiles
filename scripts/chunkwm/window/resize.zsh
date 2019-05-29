#!/usr/bin/env zsh

ratio="0.1"

function resize {
    while [[ "$1" ]]; do
        chunkc tiling::window --use-temporary-ratio "$1" --adjust-window-edge "$2"
        shift; shift
    done
}

function main {
    case "${1:0:1}" in
        "l") resize $ratio "west" "-$ratio" "east";;
        "r") resize $ratio "east" "-$ratio" "west";;
        "d") resize $ratio "south" "-$ratio" "north";;
        "u") resize $ratio "north" "-$ratio" "south";;
    esac
}

main "$@"
