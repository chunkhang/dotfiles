# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib

unsetopt MENU_COMPLETE
unsetopt FLOWCONTROL
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Add style for selected entry in completion menu
zstyle ':completion:*:*:*:*:*' menu select

# Take advantage of $LS_COLORS for completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Support case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Shift tab to move backwards in completion menu
bindkey "${terminfo[kcbt]}" reverse-menu-complete

# Load completions
fpath+=(
  $HOME/.zsh/completions
  $HOMEBREW_HOME/share/zsh/site-functions
)
autoload -Uz compinit
# Restrict to checking completion cache once a day, to speed up startup
# https://gist.github.com/ctechols/ca1035271ad134841284
if [[ "$(find $HOME/.zcompdump -mmin +1)" ]]; then
  compinit
  touch -m $HOME/.zcompdump
fi
compinit -C

# Load bash-style completions
autoload bashcompinit
bashcompinit
complete -C /usr/local/bin/aws_completer aws
