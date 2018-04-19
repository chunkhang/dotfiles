# Oh My Zsh
plugins=(osx sudo colored-man-pages)
source $ZSH/oh-my-zsh.sh

# Z
source `brew --prefix`/etc/profile.d/z.sh

# Rbenv
eval "$(rbenv init -)"

# Pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Zmv
autoload zmv

# TheFuck
eval $(thefuck --alias)

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
