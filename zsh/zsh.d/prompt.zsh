# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/prompt.md

setopt PROMPT_SUBST

function _prompt() {
  # Current directory
  echo -n "%F{yellow}%~ "

  # Do not lock git
  function _git() {
    GIT_OPTIONAL_LOCKS=0 git "$@"
  }

  # Show git info if this is a git repository
  local git_dir=$(_git rev-parse --git-dir 2>/dev/null | xargs --no-run-if-empty realpath)
  if [[ -n "$git_dir" && ! "$PWD" =~ "^${git_dir}.*" ]]; then
    # Git branch / commit
    local info=$(_git symbolic-ref --short HEAD 2>/dev/null || _git rev-parse --short HEAD)
    echo -n "%F{cyan}${info} "

    # Git clean / dirty
    if [[ -n "$(_git status --short 2>/dev/null)" ]]; then
      echo -n "%F{red}"
    else
      echo -n "%F{green}"
    fi
    echo -n "● "

    # Git stash
    local count=$(_git stash list | wc -l | xargs)
    if [[ "$count" != 0 ]]; then
      echo -n "%F{default}"
      for i in {1.."$count"}; do
        echo -n "·"
      done
    fi
  fi

  # Prompt sign
  echo
  echo -n "%F{default}$ "
}

export PROMPT='$(_prompt)'
