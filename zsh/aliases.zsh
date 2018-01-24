# Pyenv
alias activate='pyenv activate'
alias deactivate='pyenv deactivate'
alias lsvenv='pyenv virtualenvs'
alias mkvenv='pyenv virtualenv'
alias rmvenv='pyenv uninstall'

# Git
alias ga='f() { git add $@ };f'
alias gc='git commit'
alias gcm='f() { git commit -m $1 };f'
alias gd='f() { git diff $1 | cdiff -s };f'
alias gi='git init'
alias gk='f() { git checkout $1 };f'
alias gl='git log --oneline --decorate --color --graph --all'
alias gm='f() { git merge $1 };f'
alias go='git open'
alias gp='git push'
alias gs='git status'

# Glances
alias glances='glances --disable-bold'
