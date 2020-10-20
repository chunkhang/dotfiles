# =============================================================================
# VARIABLES
# =============================================================================

# Basic
export EDITOR=nvim
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

# Man
export MANPAGER='nvim +Man!'

# Homebrew
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=0

# Ydiff
export YDIFF_OPTIONS='--width=0 '

# Fastlane
export FASTLANE_SKIP_UPDATE_CHECK=1

# Ruby
export RUBYOPT='-W0'

# =============================================================================
# PATH
# https://superuser.com/a/598924
# =============================================================================

typeset -U path
path+=(
  /usr/local/lib/ruby/gems/2.6.0/bin
  $HOME/.texlive/2018/bin/x86_64-darwin
  /Applications/Postgres.app/Contents/Versions/latest/bin
  $HOME/.zsh/git-open
  $HOME/.dotfiles/bin
  /usr/local/sbin
  $HOME/.local/bin
  $path
)
export PATH

# =============================================================================
# LOCAL
# =============================================================================

if [[ -f "$HOME/.zlocal" ]]; then
  source "$HOME/.zlocal"
fi
