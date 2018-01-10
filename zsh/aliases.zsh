# Pyenv
alias activate='pyenv activate'
alias deactivate='pyenv deactivate'
alias lsvenv='pyenv virtualenvs'
alias mkvenv='pyenv virtualenv'
alias rmvenv='pyenv uninstall'

# Heroku
alias deploy='git push heroku master'
alias papertrail='heroku addons:open papertrail'

# Git
alias ga='f() { git add $1 };f'
alias gaa='git add .'
alias gc='git commit'
alias gcm='f() { git commit -m $1 };f'
alias gd='f() { git diff $1 | cdiff -s };f'
alias gl='git log --oneline --decorate --color --graph'
alias gp='git push'
alias gs='git status'
