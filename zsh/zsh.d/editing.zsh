# Force emacs mode (do not assume vi mode)
bindkey -e

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^[b' vi-backward-blank-word
bindkey '^[f' vi-forward-blank-word

bindkey '^[^?' vi-backward-kill-word

# Control space to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^@" edit-command-line
