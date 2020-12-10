# unsetopt menu_complete   # do not autoselect the first completion entry
# unsetopt flowcontrol
# setopt auto_menu         # show completion menu on successive tab press
# setopt complete_in_word
# setopt always_to_end

# TODO: Shift tab completion binding

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


fpath+=($HOME/.zsh/completions)
autoload -Uz compinit
compinit
