local current_dir='${PWD/#$HOME/~}'

local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="●"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}"

local git_stash_sign="·"
function _git_stash_info() {
  git symbolic-ref HEAD &>/dev/null || exit 0
  local count=$(git stash list | wc -l | xargs)
  repeat "$count" printf "$git_stash_sign"
}
local git_stash='$(_git_stash_info)'

local prompt_sign="$"

PROMPT="\
%{$fg[yellow]%}${current_dir} \
${git_info} \
%{$fg[white]%}${git_stash}
${prompt_sign} %{$reset_color%}"
