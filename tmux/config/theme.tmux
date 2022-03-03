#!/bin/sh

black="#282c34"
yellow="#e5c07b"
white="#aab2bf"
grey="#5c6370"

status_length="100"
base_index="1"
window_status="#{window_index} #{window_name}#{?pane_synchronized,+,}"

# Options
tmux set -g "default-terminal" "tmux-256color"
tmux set -g "terminal-overrides" "*-256color:Tc"
tmux set -g "display-time" "1000"
tmux set -g "monitor-activity" "off"
tmux set -g "monitor-bell" "off"

# Status
tmux set -g "status" "on"
tmux set -g "status-interval" "0"
tmux set -g "status-justify" "left"
tmux set -g "status-left" ""
tmux set -g "status-left-length" "$status_length"
tmux set -g "status-right" "#{?client_prefix,#{prefix},} [#{session_name}]"
tmux set -g "status-right-length" "$status_length"
tmux set -g "status-style" "fg=${white},bg=${black}"

# Message
tmux set -g "message-style" "fg=${white},bg=${black}"
tmux set -g "message-command-style" "fg=${white},bg=${black}"

# Windows
tmux set -g "base-index" "$base_index"
tmux set -g "renumber-windows" "on"
tmux set -g "allow-rename" "off"
tmux set -g "automatic-rename" "off"
tmux set -g "window-style" "fg=${white},bg=${black}"
tmux set -g "window-active-style" "fg=${white},bg=${black}"
tmux set -g "window-status-separator" "   "
tmux set -g "window-status-format" "#[fg=${grey},bg=${black}]${window_status}"
tmux set -g "window-status-current-format" "#[fg=${white},bg=${black}]${window_status}"

# Panes
tmux set -g "pane-base-index" "$base_index"
tmux set -g "pane-border-style" "fg=${grey},bg=${black}"
tmux set -g "pane-active-border-style" "fg=${white},bg=${black}"
tmux set -g "display-panes-colour" "$grey"
tmux set -g "display-panes-active-colour" "$white"

# Copy mode
tmux set -g "copy-mode-match-style" "fg=${black},bg=${yellow}"
tmux set -g "copy-mode-current-match-style" "fg=${black},bg=${yellow}"
