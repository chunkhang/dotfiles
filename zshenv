# Variables

export EDITOR=nvim

export LANG=en_US.UTF-8

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home

export SCALA_HOME=/usr/local/opt/scala/idea

export ANDROID_HOME=$HOME/Library/Android/sdk

export GOPATH=$HOME/Workspace/go
export GOROOT=/usr/local/opt/go/libexec

export FLASK_ENV=development

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export LESS=-x4icWRM

export MANPAGER='nvim +Man!'

export HOMEBREW_CLEANUP_MAX_AGE_DAYS=0
export HOMEBREW_NO_ANALYTICS=1

export YDIFF_OPTIONS='--width=0 '

export FASTLANE_SKIP_UPDATE_CHECK=1

export RUBYOPT='-W0'

export RANGER_LOAD_DEFAULT_RC=FALSE

# Path

path+=(
  "${ANDROID_HOME}/emulator"
  "${ANDROID_HOME}/tools"
  "${ANDROID_HOME}/tools/bin"
  "${ANDROID_HOME}/platform-tools"
  "${GOPATH}/bin"
  "${GOROOT}/bin"
  "${HOME}/.texlive/2018/bin/x86_64-darwin"
  /Applications/Postgres.app/Contents/Versions/latest/bin
)

# Local configuration

if [[ -f "${HOME}/.zlocal" ]]; then
  source "${HOME}/.zlocal"
fi
