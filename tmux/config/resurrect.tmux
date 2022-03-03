#!/bin/sh

tmux set -g "@resurrect-processes" "false"
# tmux set -g "@resurrect-save" "S"
# tmux set -g "@resurrect-restore" "R"

# tmux bind Q confirm -p "Kill server after saving? (y/n)" "run '#{@resurrect-save-script-path}' ; kill-server"
# tmux bind R confirm -p "Kill server after saving? (y/n)" "run '#{@resurrect-save-script-path}' ; kill-server"
