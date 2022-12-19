# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/prompt.md

setopt PROMPT_SUBST

# Do not lock git
function _prompt::git() {
  GIT_OPTIONAL_LOCKS=0 git "$@"
}

function _prompt() {
  # Current directory
  echo -n "%F{yellow}%~ "

  # Show git info if this is a git repository
  local git_dir=$(_prompt::git rev-parse --git-dir 2>/dev/null | xargs -r realpath)
  if [[ -n "$git_dir" && ! "$PWD" =~ "^${git_dir}.*" ]]; then
    # Git branch / commit
    local info=$(_prompt::git symbolic-ref --short HEAD 2>/dev/null || _prompt::git rev-parse --short HEAD)
    echo -n "%F{cyan}${info} "

    # Git clean / dirty
    if [[ -n "$(_prompt::git status --short 2>/dev/null)" ]]; then
      echo -n "%F{red}"
    else
      echo -n "%F{green}"
    fi
    echo -n "● "

    # Git stash
    local count=$(_prompt::git stash list | wc -l | xargs)
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

# Map of rprompt component to show status (1 / 0)
typeset -A _rprompt_show
_rprompt_show[kube]=0

function context() {
  # List rprompt components and their show statuses
  if [[ "$#" = 0 ]]; then
    for key in "${(@k)_rprompt_show}"; do
      echo -n "$key"
      if [[ "$_rprompt_show[$key]" = 1 ]]; then
        echo " (showing)"
      else
        echo " (hiding)"
      fi
    done
    return 0
  fi

  component="$1"

  # Validate argument
  local show="$_rprompt_show[$component]"
  if [[ -z "$show" ]]; then
    echo "Invalid value: ${component}"
    return 1
  fi

  # Toggle show status for rprompt component
  if [[ "$_rprompt_show[$component]" = 0 ]]; then
    _rprompt_show[$component]=1
    echo "Showing ${component}..."
  else
    _rprompt_show[component]=0
    echo "Hiding ${component}..."
  fi
}

function _rprompt() {
  # Show current Kubernetes context and namespace
  if [[ "$_rprompt_show[kube]" = 1 ]]; then
    local kube_context=$(kubectl config current-context 2>/dev/null)
    local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    if [[ -n "$kube_context" && -n "$kube_namespace" ]]; then
      echo -n "kube:${kube_context}/${kube_namespace}"
    fi
  fi
}

export PROMPT='$(_prompt)'
export RPROMPT='$(_rprompt)'
