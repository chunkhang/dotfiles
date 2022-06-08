# Variables

export EDITOR=nvim
export MANPAGER='nvim +Man!'

# https://superuser.com/questions/700406/zsh-not-recognizing-ls-colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLOR=1

export LESS=-x4icWRM
export YDIFF_OPTIONS='--width=0 '
export RANGER_LOAD_DEFAULT_RC=FALSE
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=1
export FASTLANE_SKIP_UPDATE_CHECK=1
export NEXT_TELEMETRY_DISABLED=1

# https://stackoverflow.com/a/52230415/13193129
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export HOMEBREW_HOME=/opt/homebrew
export HOMEBREW_PREFIX=$HOMEBREW_HOME
export HOMEBREW_CELLAR=$HOMEBREW_HOME/Cellar
export HOMEBREW_REPOSITORY=$HOMEBREW_HOME
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=0
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

export RUBYOPT='-W0'

typeset -U path
path=(
  $HOMEBREW_HOME/bin
  $HOMEBREW_HOME/sbin
  $HOME/.cargo/bin
  $HOME/.local/bin
  $HOME/.bin
  $path
)

typeset -U manpath
manpath=(
  $HOMEBREW_HOME/share/man
  $manpath
)

# Functions

function refresh() {
  echo "Refreshing shell..."
  exec "$SHELL" --login
}

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
source "$HOME/.fzf.zsh"
bindkey -r '\ec'

# Load plugins

if ! command -v plug &>/dev/null; then
  source "${HOME}/.zsh/plug.zsh"
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

# Local configuration

if [[ -f "${HOME}/.zlocal" ]]; then
  source "${HOME}/.zlocal"
fi
