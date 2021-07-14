# Force emacs mode (do not assume vi mode)
bindkey -e

# Load all zsh.d files

for zsh_file in "$HOME"/.zsh/zsh.d/*.zsh(N); do
  source "$zsh_file"
done

# Load fzf

FZF_TMUX_OPTS='-p'
FZF_DEFAULT_COMMAND='rg --files --color=never'
FZF_CTRL_R_OPTS='--exact'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_CTRL_T_OPTS='--select-1 --exit-0'
export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#282c34,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
source /usr/local/opt/fzf/shell/key-bindings.zsh
bindkey -r '\ec'

# Load plugins

if ! command -v plug &>/dev/null; then
  source "$HOME/.zsh/plug.zsh"
fi

plug use "rupa/z" "z.sh"

plug use "paulirish/git-open" "git-open"

plug use "hlissner/zsh-autopair" "autopair.zsh"

plug use "zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=60
zle_highlight+=(paste:none)

plug load

# Load hooks

function _nvm_use() {
  if [[ -f .nvmrc ]]; then
    nvm use
  fi
}

function _nvm_hook() {
  emulate -L zsh
  _nvm_use
}

_nvm_use
add-zsh-hook chpwd _nvm_hook
