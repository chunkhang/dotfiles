# vim: set foldmethod=marker:

# =============================================================================
# OH MY ZSH {{{
# =============================================================================

export ZSH=$HOME/.zsh/oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh/oh-my-zsh-custom
export ZSH_THEME=marcus
export DISABLE_AUTO_TITLE=true
export DISABLE_AUTO_UPDATE=true

# }}}
# =============================================================================
# ALIASES {{{
# =============================================================================

# ------------------------------------------------------------------------------
# Pyenv
# ------------------------------------------------------------------------------
alias activate='pyenv activate'
alias deactivate='pyenv deactivate'
alias lsvenv='pyenv virtualenvs'
alias mkvenv='pyenv virtualenv'
alias rmvenv='pyenv uninstall'

# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------
alias ga='f() { git add $@ };f'
alias gap='f() { git add -p $@ };f'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='f() { git commit -m $@ };f'
alias gcp='f() { git cherry-pick $@ };f'
alias gd='f() { git diff $@ | cdiff -s -w 0 };f'
alias gdc='f() { git diff --cached $@ | cdiff -s -w 0 };f'
alias gds='f() { git --no-pager diff --stat $1..@ };f'
alias gdt='git difftool'
alias gi='git init'
alias gk='f() { git checkout $@ };f'
alias gka='git checkout -- "*"'
alias gl='git log --oneline --decorate --color --graph --all --first-parent'
alias gm='f() { git merge $@ };f'
alias gmt='git mergetool'
alias gn='git open'
alias gp='git push'
alias gpu='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gr='git rebase'
alias gs='git status'
alias gu='git pull'
alias gw='f() { git show $@ | cdiff -s -w 0 };f'
alias gx='nvim $(git diff --name-only --diff-filter=U)'

# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------
alias dk='docker-compose'
alias dkl='docker-compose logs'
alias dkr='docker-compose restart'
alias dku='docker-compose up'
alias dkd='docker-compose down'
alias dkk='docker-compose kill'
alias dkb='docker-compose build'

# ------------------------------------------------------------------------------
# Ripgrep
# ------------------------------------------------------------------------------
alias rgl='f() { rg --pretty $@ | less };f'
alias rgv='f() { nvim -q <(rg --vimgrep $@) };f'

# ------------------------------------------------------------------------------
# Miscellaneous
# ------------------------------------------------------------------------------
alias cls='clear'
alias lgrep='f() { l | grep $@ };f'
alias tree='tree -C'
alias v='nvim'
alias stack='git-stack'
alias tweet='t update'
alias wiki='nvim $HOME/Dropbox/wiki/index.wiki'
alias hp='http-prompt'
alias fd='fd --hidden'
alias pt='papertrail'
alias ncdu='ncdu --color=dark --confirm-quit'
alias mutt='neomutt'
alias tf='terraform'

# }}}
# =============================================================================
# FUNCTIONS {{{
# =============================================================================

# Perform operations on Bluetooth
function blue() {
  function showHelp() {
    echo "usage: blue <command>"
    echo
    echo "commands:"
    echo "  status     show Bluetooth status"
    echo "  enable     turn on Bluetooth"
    echo "  disable    turn off Bluetooth"
  }
  function showStatus() {
    s="Bluetooth is: $(blueutil status | cut -c 9-)"
    echo "$s"
  }
  if [ "$#" = 0 ]; then
    showHelp
  else
    case "$1" in
      "status")
        showStatus
        ;;
      "enable")
        echo "Enabling Bluetooth..."
        blueutil on
        showStatus
        ;;
      "disable")
        echo "Disabling Bluetooth..."
        blueutil off
        showStatus
        ;;
      *)
        showHelp
        ;;
    esac
  fi
}

# Execute various cleaning commands
function clean() {
  echo "Cleaning system..."
  $HOME/.scripts/system/clean
  echo "Done cleaning."
}

# Perform operations on DNS
function dns() {
  function showHelp() {
    echo "usage: dns <command>"
    echo
    echo "commands:"
    echo "  status    show current DNS"
    echo "  google    use Google DNS"
    echo "  reset     reset DNS"
    echo "  flush     flush DNS cache"
  }
  function showStatus() {
    s="Current DNS:\n$(networksetup -getdnsservers Wi-Fi | sed 's/^/  /')"
    echo "$s"
  }
  if [ "$#" = 0 ]; then
    showHelp
  else
    case "$1" in
      "status")
        showStatus
        ;;
      "google")
        echo "Using Google DNS..."
        sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
        showStatus
        ;;
      "reset")
        echo "Resetting DNS..."
        sudo networksetup -setdnsservers Wi-Fi empty
        showStatus
        ;;
      "flush")
        echo "Flushing DNS cache..."
        sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
        echo "Done flushing."
        ;;
      *)
        showHelp
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

# Eject all mountable volumes
function eject() {
  echo "Ejecting all mountable volumes..."
  osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
  echo "Done ejecting."
}

# Perform operations on Gatekeeper
function gate() {
  function showHelp() {
    echo "usage: gate <command>"
    echo
    echo "commands:"
    echo "  status     show Gatekeeper status"
    echo "  enable     turn on Gatekeeper"
    echo "  disable    turn off Gatekeeper"
  }
  function showStatus() {
    s="Gatekeeper is: $(spctl --status | cut -c 13-)"
    echo "$s"
  }
  if [ "$#" = 0 ]; then
    showHelp
  else
    case "$1" in
      "status")
        showStatus
        ;;
      "enable")
        echo "Enabling Gatekeeper..."
        sudo spctl --master-enable
        showStatus
        ;;
      "disable")
        echo "Disabling Gatekeeper..."
        sudo spctl --master-disable
        showStatus
        ;;
      *)
        showHelp
        ;;
    esac
  fi
}

# Execute new shell
function refresh() {
  echo "Refreshing shell..."
  exec "$SHELL" -l
}

# Perform operations on Wi-Fi
function wifi() {
  function showHelp() {
    echo "usage: wifi <command>"
    echo
    echo "commands:"
    echo "  status     show Wi-Fi status"
    echo "  enable     turn on Wi-Fi"
    echo "  disable    turn off Wi-Fi"
  }
  function showStatus() {
      s="Wi-Fi is: $(networksetup -getairportpower en0 | cut -c 20- | tr O o)"
      echo "$s"
  }
  if [ "$#" = 0 ]; then
    showHelp
  else
    case "$1" in
      "status")
        showStatus
        ;;
      "enable")
        echo "Enabling Wi-Fi..."
        networksetup -setairportpower en0 on
        showStatus
        ;;
      "disable")
        echo "Disabling Wi-Fi..."
        networksetup -setairportpower en0 off
        showStatus
        ;;
      *)
        showHelp
        ;;
    esac
  fi
}

# }}}
# =============================================================================
# PLUGINS {{{
# =============================================================================

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
plugins+=(colored-man-pages)
source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# z
# -----------------------------------------------------------------------------
source /usr/local/etc/profile.d/z.sh

# -----------------------------------------------------------------------------
# zmv
# -----------------------------------------------------------------------------
autoload zmv

# -----------------------------------------------------------------------------
# fzf
# -----------------------------------------------------------------------------
FZF_DEFAULT_COMMAND='rg --files --color=never'
FZF_CTRL_R_OPTS='--exact'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_CTRL_T_OPTS="--select-1 --exit-0"
FZF_ALT_C_COMMAND='fd --type directory'
FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C -L 1 {} | head -200'"
source /usr/local/opt/fzf/shell/key-bindings.zsh

# -----------------------------------------------------------------------------
# Syntax highlighting
# -----------------------------------------------------------------------------
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=60
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}
# =============================================================================
# COMPLETIONS {{{
# =============================================================================

fpath=($HOME/.zsh/completions $fpath)
autoload -Uz compinit
compinit

# }}}
# =============================================================================
