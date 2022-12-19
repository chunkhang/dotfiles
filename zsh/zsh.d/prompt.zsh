# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/prompt.md

setopt PROMPT_SUBST

RPROMPT_CONFIG_FILE=${RPROMPT_CONFIG_FILE:-~/.rprompt.json}

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

function _rprompt::set_config_file() {
  local value="$1"

  echo "$value" > "$RPROMPT_CONFIG_FILE"
}

function _rprompt::get_config_file() {
  # Init config file, if it does not exist
  if [[ ! -f "$RPROMPT_CONFIG_FILE" ]]; then
    _rprompt::set_config_file '{}'
  fi

  cat "$RPROMPT_CONFIG_FILE"
}

function _rprompt::set_config() {
  local key="$1"
  local value="$2"

  # Set new key and value to config
  local config=$(_rprompt::get_config_file | jq ". + { \"${key}\": ${value} }")
  _rprompt::set_config_file "$config"
}

function _rprompt::get_config() {
  local key="$1"
  local default_value="$2"

  local value=$(_rprompt::get_config_file | jq ".${key}")

  # Return default value, if key does not exist
  if [[ "$value" = "null" ]]; then
    echo "$default_value"
    return 0
  fi

  echo "$value"
}

# Cache for rprompt config
typeset -A _rprompt_config

# Set cache based on config file values
# Also use this as list of allowed config keys, and their default values
function _rprompt::cache_config() {
  _rprompt_config[kube]=$(_rprompt::get_config kube 0)
}
_rprompt::cache_config

function context() {
  # Update cache first, to show the current config
  _rprompt::cache_config

  # List rprompt config
  if [[ "$#" = 0 ]]; then
    for key in "${(@k)_rprompt_config}"; do
      echo -n "$key"
      if [[ "$_rprompt_config[$key]" = 1 ]]; then
        echo " (shown)"
      else
        echo " (hidden)"
      fi
    done
    return 0
  fi

  key="$1"

  # Validate key
  local value="$_rprompt_config[$key]"
  if [[ -z "$value" ]]; then
    echo "Invalid value: ${key}"
    return 1
  fi

  # Toggle rprompt config value
  # We update the config map, but also persist it to file
  if [[ "$_rprompt_config[$key]" = 0 ]]; then
    echo "Showing ${key} in rprompt..."
    _rprompt_config[$key]=1
    _rprompt::set_config "$key" 1
  else
    echo "Hiding ${key} in rprompt..."
    _rprompt_config[$key]=0
    _rprompt::set_config "$key" 0
  fi
}

function _rprompt() {
  # Show current Kubernetes context and namespace
  if [[ "$_rprompt_config[kube]" = 1 ]]; then
    local kube_context=$(kubectl config current-context 2>/dev/null)
    local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    if [[ -n "$kube_context" && -n "$kube_namespace" ]]; then
      echo -n "kube:${kube_context}/${kube_namespace}"
    fi
  fi
}

export PROMPT='$(_prompt)'
export RPROMPT='$(_rprompt)'
