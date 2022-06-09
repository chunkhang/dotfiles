#!/bin/sh

tmux set -g "@scroll-speed-num-lines-per-scroll" "2"
if [[ "$(uname -s)" = "Linux" ]]; then
  tmux set -g "@scroll-speed-num-lines-per-scroll" "3"
fi

tmux set -g "@emulate-scroll-for-no-mouse-alternate-buffer" "on"
