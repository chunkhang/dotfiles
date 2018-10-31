# Local configuration
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# Completion
fpath=(~/.zsh/completion $fpath)

# Environment
source ~/.zsh/environment.zsh

# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

# Settings
source ~/.zsh/settings.zsh

# Plugins
source ~/.zsh/plugins.zsh
