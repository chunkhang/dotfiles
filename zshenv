# =============================================================================
# VARIABLES
# =============================================================================

# Basic
export EDITOR=vim
export LANG=en_US.UTF-8

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Scala
export SCALA_HOME=/usr/local/opt/scala/idea

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
path+=(
  $ANDROID_HOME/emulator
  $ANDROID_HOME/tools
  $ANDROID_HOME/tools/bin
  $ANDROID_HOME/platform-tools
)

# Go
export GOPATH=$HOME/Workspace/go
export GOROOT=/usr/local/opt/go/libexec
path+=(
  $GOPATH/bin
  $GOROOT/bin
)

# Flask
export FLASK_ENV=development

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Less
export LESS=-x4icWRM

# =============================================================================
# PLUGINS
# =============================================================================

# -----------------------------------------------------------------------------
# Pyenv
# -----------------------------------------------------------------------------
export CFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
source $HOME/.zsh/zsh-pyenv-lazy/pyenv-lazy.plugin.zsh

# -----------------------------------------------------------------------------
# Rbenv
# -----------------------------------------------------------------------------
source $HOME/.zsh/zsh-rbenv-lazy/rbenv-lazy.plugin.zsh

# -----------------------------------------------------------------------------
# Nvm
# -----------------------------------------------------------------------------
export NVM_LAZY_LOAD=true
source $HOME/.zsh/zsh-nvm/zsh-nvm.plugin.zsh

# =============================================================================
# PATH
# https://superuser.com/a/598924
# =============================================================================

typeset -U path
path+=(
  $HOME/.texlive/2018/bin/x86_64-darwin
  /Applications/Postgres.app/Contents/Versions/latest/bin
  $HOME/.zsh/git-open
  $HOME/.dotfiles/bin
  /usr/local/sbin
  $path
)
export PATH

# =============================================================================
# LOCAL
# =============================================================================

if [ -f $HOME/.zlocal ]; then
  source $HOME/.zlocal
fi
