# TODO: Shift tab completion binding

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


fpath+=($HOME/.zsh/completions)
autoload -Uz compinit
compinit
