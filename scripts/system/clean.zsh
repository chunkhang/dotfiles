#!/usr/bin/env zsh -l

color() {
    local green="\e[32m"
    local blue="\e[1;34m"
    local white="\e[0m"

    local color="${(P)$(echo $1)}"
    local text="$2"

    echo -n "$color$text$white"
}

line() {
    local char="-"
    local length=80

    local line="$(printf %${length}s)"

    echo "${line// /$char}"
}

main() {
    local commands=(
        "rm -rf ~/Library/Developer/Xcode/DerivedData"
        "pnpm store prune"
        "npm cache clean --force"
        "docker image prune"
        "docker container prune"
        "brew cleanup"
        "rm ~/.weechat/weechat_crash_*.log"
    )

    local length=${#commands[@]}
    for i in $(seq 1 $length); do
        local step="$i/$length"
        local cmd="${commands[$i]}"

        line
        echo "$(color green $step) $(color blue $cmd)"
        line
        eval "$cmd"
        echo
    done
}

main "$@"
