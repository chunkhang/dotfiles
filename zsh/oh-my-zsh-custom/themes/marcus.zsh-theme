# Directory
local current_dir='${PWD/#$HOME/~}'

# Git
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="●"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}"

# Pyenv-virtualenv
local pyenv_virtualenv_info='$((){
    if [[ $PYENV_VIRTUAL_ENV != "" ]]; then
        echo "[`basename $PYENV_VIRTUAL_ENV`] "
    else
        echo ""
    fi
})'

# Prompt
local prompt_sign="$"

PROMPT="\
%{$fg[yellow]%}${current_dir} \
${git_info} \
%{$fg[white]%}${pyenv_virtualenv_info}
%{$fg[white]%}${prompt_sign} %{$reset_color%}"
