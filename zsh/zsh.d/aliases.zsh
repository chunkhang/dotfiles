# =============================================================================
# Setup abbreviation expansion
# =============================================================================

typeset -a _abbr_abbreviations
typeset -a _abbr_history

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

# =============================================================================
# Aliases / Abbreviations
# =============================================================================

# -----------------------------------------------------------------------------
# Overrides
# -----------------------------------------------------------------------------

alias ls='ls --color=auto'
alias fd='fd --hidden'
alias tree='tree -a'
alias ncdu='ncdu --color=dark --confirm-quit'
alias newsboat='newsboat --quiet'
alias xclip='xclip -selection clipboard'

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------

alias l='ls -lah'
alias lgrep='() { l | grep --color "$@" }'
alias -- -='cd -'
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias \?='echo "$?"'
alias cls='clear'

# -----------------------------------------------------------------------------
# Short Forms
# -----------------------------------------------------------------------------

alias v='nvim'
alias mutt='neomutt'
abbr t='touch'
abbr k='kubectl'
abbr j='just'
abbr f='flux'
abbr d='docker'
abbr g='git'
abbr h='helm'

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

abbr gd='git ydiff'
abbr gdc='git ydiff --cached'
abbr gds='git diff --stat'

abbr gr='git rebase'
abbr gri='git rebase --interactive'
abbr grc='git rebase --continue'
abbr gra='git rebase --abort'

abbr gcp='git cherry-pick'
abbr gcpc='git cherry-pick --continue'
abbr gcpa='git cherry-pick --abort'

abbr gt='git stash'
abbr gtl='git stash list'
abbr gtp='git stash pop'
abbr gtc='git stash clear'

abbr gw='git show'

abbr gl='git log'
alias gll='fzf-git-log'
alias gla='git log --oneline --decorate --color --graph --all'

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
abbr gfb='git flow bugfix'

abbr ge='git worktree'
abbr gea='git worktree add'
abbr gel='git worktree list'
abbr gep='git worktree prune'

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
# tmux
# -----------------------------------------------------------------------------

abbr tm='tmux'

abbr tma='tmux attach'

abbr tmd='tmux detach'

abbr tmk='tmux kill-server'

# ------------------------------------------------------------------------------
# Ripgrep
# ------------------------------------------------------------------------------

alias rgl='() { rg --pretty "$@" | less }'
alias rgv='() { nvim -q <(rg --vimgrep "$@") }'
