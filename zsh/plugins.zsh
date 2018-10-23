# Oh My Zsh
plugins=(osx sudo colored-man-pages zsh-nvm)
source $ZSH/oh-my-zsh.sh

# Z
source `brew --prefix`/etc/profile.d/z.sh

# Rbenv
# https://github.com/kadaan/zsh-rbenv-lazy/blob/master/rbenv-lazy.plugin.zsh
if type rbenv &> /dev/null; then
  local RBENV_SHIMS="${RBENV_ROOT:-${HOME}/.rbenv}/shims"
  export PATH="${RBENV_SHIMS}:${PATH}"
  source $(which rbenv)/../../completions/rbenv.zsh
  function rbenv() {
    unset -f rbenv > /dev/null 2>&1
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi

# Pyenv
# https://github.com/davidparsson/zsh-pyenv-lazy/blob/master/pyenv-lazy.plugin.zsh
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
if ! type pyenv > /dev/null && [ -f "${PYENV_ROOT}/bin/pyenv" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi
if type pyenv > /dev/null; then
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        pyenv $@
    }
fi

# Zmv
autoload zmv

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
