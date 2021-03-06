bindkey '^[b' vi-backward-blank-word
bindkey '^[f' vi-forward-blank-word

bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line

# Control space to edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^@" edit-command-line

# Do not treat / and - as part of word
autoload -U select-word-style
select-word-style bash
