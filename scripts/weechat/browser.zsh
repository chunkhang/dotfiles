#!/usr/bin/env zsh

for url in "$@"; do
  firefox="Firefox"
  chrome="Google Chrome"

  # Determine browser to use
  browser="$firefox"

  if [[ "$url" =~ "https://.*\.slack\.com/call/.*" ]]; then
    browser="$chrome"
  fi

  if [[ "$url" =~ "https://zoom\.us/.*" ]]; then
    browser="$chrome"
    url=$(echo "$url" | sed 's/\/j\//\/wc\//' | sed 's/?/\/join?/')
  fi

  # Open url
  open -a "$browser" "$url"
done
