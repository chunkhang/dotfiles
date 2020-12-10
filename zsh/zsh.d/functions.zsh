# Use ctrl-p for switching directory
function _ctrl_p() {
  local dir=$( \
    z -l | tac | head -n 100 | awk '{print $2}'| \
    grep --invert-match --line-regexp --fixed-strings "$(pwd)" | \
    sed "s,${HOME},~," | \
    fzf --reverse --tiebreak=end,index --exact --height 40% | \
    sed "s,~,${HOME}," \
  )
  if [[ -d "$dir" ]]; then
    cd "$dir"
  fi
  zle fzf-redraw-prompt
}
zle -N _ctrl_p
bindkey '^P' _ctrl_p

# Perform operations on DNS
function dns() {
  function show-help() {
    echo "usage: dns <command>"
    echo
    echo "commands:"
    echo "  status      show current DNS"
    echo "  google      use Google DNS"
    echo "  cloudflare  use Cloudflare DNS"
    echo "  reset       reset DNS"
    echo "  flush       flush DNS cache"
  }
  function show-status() {
    s="Current DNS:\n$(networksetup -getdnsservers Wi-Fi | sed 's/^/  /')"
    echo "$s"
  }
  if [[ "$#" = 0 ]]; then
    show-help
  else
    case "$1" in
      "status")
        show-status
        ;;
      "google")
        echo "Using Google DNS..."
        sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
        show-status
        ;;
      "cloudflare")
        echo "Using Cloudflare DNS..."
        sudo networksetup -setdnsservers Wi-Fi 1.1.1.1
        show-status
        ;;
      "reset")
        echo "Resetting DNS..."
        sudo networksetup -setdnsservers Wi-Fi empty
        show-status
        ;;
      "flush")
        echo "Flushing DNS cache..."
        sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
        echo "Done flushing."
        ;;
      *)
        show-help
        ;;
    esac
  fi
}

# Turn off display
function douse() {
  echo "Turning off display..."
  b=$(brightness -l 2>/dev/null | grep "brightness" | sed 's/display 0: brightness //')
  printf "Hit enter to revert brightness."
  sleep 1
  brightness -d 0 0
  read "x?"
  brightness -d 0 "$b"
  echo "Display turned on."
}

# Show git log with fzf
function fzf-git-log() {
  git log --color --decorate --oneline "$@" | \
    fzf --ansi --reverse --tiebreak=index --no-sort --exact \
      --preview " \
        echo {} | \
        cut -d ' ' -f 1 | \
        xargs git show --color --first-parent \
      " \
      --bind "enter:execute-silent( \
        echo {} | \
        cut -d ' ' -f 1 | \
        tr -d '\n' | \
        pbcopy \
      )+accept"
}

# Perform operations on Gatekeeper
function gate() {
  function show-help() {
    echo "usage: gate <command>"
    echo
    echo "commands:"
    echo "  status     show Gatekeeper status"
    echo "  enable     turn on Gatekeeper"
    echo "  disable    turn off Gatekeeper"
  }
  function show-status() {
    s="Gatekeeper is: $(spctl --status | cut -c 13-)"
    echo "$s"
  }
  if [[ "$#" = 0 ]]; then
    show-help
  else
    case "$1" in
      "status")
        show-status
        ;;
      "enable")
        echo "Enabling Gatekeeper..."
        sudo spctl --master-enable
        show-status
        ;;
      "disable")
        echo "Disabling Gatekeeper..."
        sudo spctl --master-disable
        show-status
        ;;
      *)
        show-help
        ;;
    esac
  fi
}

# Execute new shell
function refresh() {
  echo "Refreshing shell..."
  exec "$SHELL" -l
}

# Open todo
function todo() {
  local todo_filename=".todo"
  local directory="$PWD"
  local todo_path
  while [[ "$directory" != "/" ]] ; do
    todo_path=$(find "$directory" -maxdepth 1 -name "$todo_filename")
    if [[ -n "$todo_path" ]]; then
      break
    fi
    directory=$(realpath "${directory}/..")
  done
  if [[ -z "$todo_path" ]]; then
    echo "Create a ${todo_filename} file first."
    return 1
  fi
  if [[ "$#" = 0 ]]; then
    "$EDITOR" "$todo_path"
  else
    echo "$@" >> "$todo_path"
  fi
  echo "$todo_path"
}

# Print repository version
function version() {
  if [[ -f 'package.json' ]]; then
    jq --raw-output '.version' package.json
  else
    return 1
  fi
}

# Connect to Wi-Fi network with fzf
function wifi() {
  ssid=$( \
    airport --scan | \
    tail -n +2 | cut -c 1-32 | sed 's/^ *//' | sort --ignore-case | \
    fzf --reverse --tiebreak=index --no-sort \
  )
  if [[ "$?" = 0 ]]; then
    echo "Connecting to \"${ssid}\"..."
    password=$( \
      security find-generic-password \
        -D 'AirPort network password' -a "$ssid" -w \
        2>/dev/null \
    )
    if [[ "$?" != 0 ]]; then
      password="-"
    fi
    networksetup -setairportnetwork en0 "$ssid" "$password"
    echo
  fi
}
