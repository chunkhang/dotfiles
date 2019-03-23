# Path
export PATH=~/.texlive/2018/bin/x86_64-darwin:/Applications/Postgres.app/Contents/Versions/latest/bin:~/.zsh/git-open:~/.dotfiles/bin:/usr/local/sbin:$PATH

# Oh My Zsh
export ZSH=~/.zsh/oh-my-zsh

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Scala
export SCALA_HOME=/usr/local/opt/scala/idea

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Go
export GOPATH=~/Workspace/go
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Pyenv
export CFLAGS='-I/usr/local/opt/openssl/include'
export LDFLAGS='-L/usr/local/opt/openssl/lib'
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Nvm
export NVM_LAZY_LOAD=true

# Flask
export FLASK_ENV='development'

# Editor
export EDITOR='vim'

# Locale
export LANG=en_US.UTF-8
