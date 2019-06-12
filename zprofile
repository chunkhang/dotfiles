# Pyenv
export CFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
source $HOME/.zsh/zsh-pyenv-lazy/pyenv-lazy.plugin.zsh

# Rbenv
source $HOME/.zsh/zsh-rbenv-lazy/rbenv-lazy.plugin.zsh

# Nvm
export NVM_LAZY_LOAD=true
source $HOME/.zsh/zsh-nvm/zsh-nvm.plugin.zsh
