# Pyenv
alias activate='pyenv activate'
alias deactivate='pyenv deactivate'
alias lsvenv='pyenv virtualenvs'
alias mkvenv='pyenv virtualenv'
alias rmvenv='pyenv uninstall'

# Git
alias ga='f() { git add $@ };f'
alias gb='git branch'
alias gc='git commit'
alias gcm='f() { git commit -m $@ };f'
alias gcp='f() { git cherry-pick $@ };f'
alias gd='f() { git diff $@ | cdiff -s };f'
alias gi='git init'
alias gk='f() { git checkout $@ };f'
alias gl='git log --oneline --decorate --color --graph --all'
alias gm='f() { git merge $@ };f'
alias gn='git open'
alias gp='git push'
alias gr='git remote'
alias gs='git status'
alias gu='git pull'

# Docker
alias dk='f() { docker-compose $@ };f'

# pnpm
alias pnl='pnpm list --depth=0'
alias pnlg='pnpm list --depth=0 -g'

# Glances
alias glances='glances --disable-bold'

# Miscellaneous
alias cls='clear'
alias lgrep='f() { l | grep $@ };f'
