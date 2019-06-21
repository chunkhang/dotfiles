#!/usr/bin/env zsh

for url in "$@"; do
    firefox="firefox"
    chrome="google-chrome"

    # Determine browser to use
    browser="$firefox"
    if [[ "$url" =~ "https://.*\.slack\.com/call/.*" ]]; then
        browser="$chrome"
    fi

    # Open url
    "$browser" "$url"
done
