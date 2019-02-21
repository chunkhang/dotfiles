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
alias gd='f() { git diff $@ | cdiff -s -w 0 };f'
alias gi='git init'
alias gk='f() { git checkout $@ };f'
alias gka='git checkout -- "*"'
alias gl='git log --oneline --decorate --color --graph --all'
alias gm='f() { git merge $@ };f'
alias gn='git open'
alias gp='git push'
alias gr='git remote'
alias gs='git status'
alias gu='git pull'
alias gw='f() { git show $@ | cdiff -s -w 0 };f'

# Docker
alias dk='docker-compose'
alias dkl='docker-compose logs'
alias dkr='docker-compose restart'
alias dku='docker-compose up'
alias dkd='docker-compose down'

# pnpm
alias pnl='pnpm list --depth=0'
alias pnlg='pnpm list --depth=0 -g'

# Glances
alias glances='glances --disable-bold'

# Miscellaneous
alias cls='clear'
alias lgrep='f() { l | grep $@ };f'
alias tree='tree -C'
alias agl='ag --pager less'
alias vi='vim'
alias stack='git-stack'
