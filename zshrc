# vim: set foldmethod=marker:

# =============================================================================
# OPTIONS {{{
# =============================================================================

# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/history.md
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

# }}}
# =============================================================================
# PLUGINS {{{
# =============================================================================

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------

export ZSH=$HOME/.zsh/oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh/oh-my-zsh-custom
export ZSH_THEME=marcus
export DISABLE_AUTO_TITLE=true
export DISABLE_AUTO_UPDATE=true

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
FZF_CTRL_T_OPTS='--select-1 --exit-0'
FZF_ALT_C_COMMAND='fd --type directory'
FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C -L 1 {} | head -200'"
export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#282c34,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

source /usr/local/opt/fzf/shell/key-bindings.zsh
bindkey -s '^P' '^T'

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
# FUNCTIONS {{{
# =============================================================================

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
    fzf --ansi --reverse --tiebreak=index --no-sort \
      --preview " \
        echo {} | \
        grep --only-matching '[a-f0-9]\{7\}' | \
        xargs git show --color --first-parent \
      "
}

# Show tmux windows with fzf
function fzf-tmux-windows() {
  tmux list-windows -F '#{window_name}' | \
    fzf --tiebreak=index --no-sort | \
  xargs -I {} tmux select-window -t '{}'
  tput cuu 2
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

# Download placeholder image
function picsum() {
  function show-help() {
    echo "usage: picsum <width> [height]"
  }
  function download-image() {
    curl --location "https://picsum.photos/${1}/${2}" --output "$3" 2>/dev/null 
    echo "$3"
  }
  if [[ "$#" = 0 ]]; then
    show-help
  elif [[ "$#" = 1 ]]; then
    download-image "$1" "$1" "${RANDOM}-${1}-${1}.jpg"
  else
    download-image "$1" "$2" "${RANDOM}-${1}-${2}.jpg"
  fi
}

# Execute new shell
function refresh() {
  echo "Refreshing shell..."
  exec "$SHELL" -l
}

# }}}
# =============================================================================
# ALIASES {{{
# =============================================================================

typeset -a _abbr_abbreviations
_abbr_abbreviations=()

typeset -a _abbr_history
_abbr_history=()

function abbr() {
  if [[ "$#" = 0 ]]; then
    echo "${(j/\n/)_abbr_history}"
  else
    alias "$1"
    _abbr_abbreviations+=("${1%%=*}")
    _abbr_history+=("$1")
  fi
}

function _abbr_expand() {
  # Pattern of all possible abbreviations to match
  # e.g. (ab|cd|ef)
  local match="(${(j/|/)_abbr_abbreviations})"
  if [[
    # $ ab => $ apple banana
    "$LBUFFER" =~ "^ *${match}$" ||
    # $ ls; ab => $ ls; apple banana
    # $ ls || ab => $ ls || apple banana
    # $ ls && ab => $ ls && apple banana
    "$LBUFFER" =~ "[;|&] *${match}$"
  ]]; then
    zle _expand_alias
  fi
}
zle -N _abbr_expand

function _abbr_space() {
  zle _abbr_expand
  zle self-insert
}
zle -N _abbr_space

function _abbr_enter() {
  zle _abbr_expand
  zle accept-line
}
zle -N _abbr_enter

bindkey ' ' _abbr_space
bindkey '^M' _abbr_enter
bindkey '^ ' magic-space
bindkey -M isearch ' ' magic-space

# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

abbr gk='git checkout'
abbr gkb='git checkout -b'

abbr gb='git branch'
abbr gbm='git branch -m'
abbr gbd='git branch -d'
abbr gbdd='git branch -D'
abbr gbr='git branch --remote'

abbr gs='git status'

abbr ga='git add'
abbr gap='git add --patch'

abbr gc='git commit'
abbr gca='git commit --amend'
abbr gcm='git commit --message'

abbr gd='git diff'
abbr gdc='git diff --cached'
abbr gds='git diff --stat'
alias gdd='() { git diff "$@" | cdiff -s -w 0 }'
alias gdcc='() { git diff --cached "$@" | cdiff -s -w 0 }'

abbr gr='git rebase'
abbr gri='git rebase --interactive'
abbr grc='git rebase --continue'
abbr gra='git rebase --abort'

abbr gcp='git cherry-pick'

abbr gt='git stash'
abbr gtl='git stash list'
abbr gtp='git stash pop'
abbr gtc='git stash clear'

abbr gw='git show'
alias gww='() { git show "$@" | cdiff -s -w 0 }'

abbr gl='git log'
alias gll='fzf-git-log'
alias gla='git log --oneline --decorate --color --graph --all --first-parent'

abbr gm='git merge'
abbr gmc='git merge --continue'
abbr gma='git merge --abort'

abbr gp='git push'
abbr gpf='git push --force'
alias gpu='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

abbr gu='git pull'

abbr gv='git revert'
abbr gvc='git revert --continue'
abbr gva='git revert --abort'

abbr gdt='git difftool'
abbr gmt='git mergetool'

abbr gn='git open'

abbr gf='git flow'
abbr gff='git flow feature'
abbr gfh='git flow hotfix'
abbr gfr='git flow release'

# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------

abbr dk='docker-compose'

abbr dkb='docker-compose build'

abbr dku='docker-compose up'

abbr dkd='docker-compose down'

abbr dkp='docker-compose pause'

abbr dkup='docker-compose unpause'

abbr dkl='docker-compose logs'

abbr dkr='docker-compose restart'

abbr dkk='docker-compose kill'

# -----------------------------------------------------------------------------
# PM2
# -----------------------------------------------------------------------------

abbr pp='pm2'

abbr pps='pm2 start'

abbr ppso='pm2 start --only'

abbr ppr='pm2 restart'

abbr ppt='pm2 stop'

abbr ppd='pm2 delete'

abbr ppl='pm2 logs'
abbr pple='pm2 logs --err'

abbr ppf='pm2 flush'

abbr ppls='pm2 ls'

abbr ppm='pm2 monit'

# -----------------------------------------------------------------------------
# tmux
# -----------------------------------------------------------------------------

abbr tm='tmux'

abbr tma='tmux attach -t'

abbr tmd='tmux detach'

abbr tmk='tmux kill-server'

# ------------------------------------------------------------------------------
# Ripgrep
# ------------------------------------------------------------------------------

alias rgl='() { rg --pretty "$@" | less }'
alias rgv='() { nvim -q <(rg --vimgrep "$@") }'

# ------------------------------------------------------------------------------
# Miscellaneous
# ------------------------------------------------------------------------------

alias \?='echo "$?"'
alias cls='clear'
alias fd='fd --hidden'
alias hp='http-prompt'
alias lgrep='() { l | grep "$@" }'
alias mutt='neomutt'
alias ncdu='ncdu --color=dark --confirm-quit'
alias pt='papertrail'
alias tf='terraform'
alias tree='tree -C'
alias tweet='t update'
alias v='nvim'
alias wiki='nvim $HOME/Dropbox/wiki/index.wiki'

# }}}
# =============================================================================
# HOOKS {{{
# =============================================================================

function _nvm_use() {
  if [[ -f .nvmrc ]]; then
    nvm use
  fi
}

function _nvm_hook() {
  emulate -L zsh
  _nvm_use
}

_nvm_use
add-zsh-hook chpwd _nvm_hook

# }}}
# =============================================================================
