# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/prompt.md

setopt PROMPT_SUBST

function _prompt() {
  # Current directory
  echo -n "%F{yellow}%~ "

  # Show git info if this is a git repository
  local info=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [[ -n "$info" ]]; then
    # Git branch / commit
    echo -n "%F{cyan}${info} "

    # Git clean / dirty
    if [[ -n "$(git status --short)" ]]; then
      echo -n "%F{red}"
    else
      echo -n "%F{green}"
    fi
    echo -n "● "

    # Git stash
    local count=$(git stash list | wc -l | xargs)
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
