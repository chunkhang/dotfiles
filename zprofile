source "$HOME/.zsh/plug.zsh"

plug use "davidparsson/zsh-pyenv-lazy" "pyenv-lazy.plugin.zsh"

plug use "chunkhang/zsh-rbenv-lazy" "rbenv-lazy.plugin.zsh"

plug use "lukechilds/zsh-nvm" "zsh-nvm.plugin.zsh"
export NVM_LAZY_LOAD=true

plug load
