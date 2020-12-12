# Use emacs key bindings
bindkey -e

# Control space to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^@" edit-command-line
