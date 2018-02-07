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
alias gd='f() { git diff $@ | cdiff -s };f'
alias gi='git init'
alias gk='f() { git checkout $@ };f'
alias gl='git log --oneline --decorate --color --graph --all'
alias gm='f() { git merge $@ };f'
alias go='git open'
alias gp='git push'
alias gs='git status'

# Glances
alias glances='glances --disable-bold'
