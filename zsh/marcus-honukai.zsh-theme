# Mostly inspired by:
# https://github.com/oskarkrawczyk/honukai-iterm-zsh/blob/master/honukai.zsh-theme

# Directory info
local current_dir='${PWD/#$HOME/~}'

# git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="● "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}"

# pyenv-virtualenv info
local pyenv_virtualenv_info='$((){
   if [[ $PYENV_VIRTUAL_ENV != "" ]]; then
      echo "[`basename $PYENV_VIRTUAL_ENV`]"
   else
      echo ""
   fi
})'

# Prompt
PROMPT="\
%{$fg[blue]%}◆ \
%{$fg[yellow]%}${current_dir} \
${git_info}\
%{$fg[white]%}${pyenv_virtualenv_info}
%{$fg[red]%}► %{$reset_color%}"
