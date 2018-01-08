# Local configuration
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local
fi

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
