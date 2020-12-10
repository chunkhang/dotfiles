# Create plugins home directory if needed
_plug_home=$HOME/.zsh/plugins
if [[ ! -d "$_plug_home" ]]; then
  mkdir -p "$_plug_home"
fi

# Array of repo
typeset -a _plug_repos
# Map of repo to file
typeset -A _plug_files

# Array of loaded repos
typeset -a _plug_loaded

function _plug::help() {
  echo "usage:"
  echo "  plug use <repo> <file>     add new plugin usage"
  echo "  plug install               install missing plugins"
  echo "  plug list                  list all plugins"
  echo "  plug clean                 uninstall unused plugins"
  echo "  plug load                  load installed plugins"
  echo "  plug help                  show this help"
}

function _plug::use() {
  local repo="$1"
  local file="$2"
  _plug_repos+=("$repo")
  _plug_files+=(["$repo"]="$file")
}

function _plug::install() {
  local repo
  for repo in "${_plug_repos[@]}"; do
    local reponame=$(basename "$repo")
    local dirpath="${_plug_home}/${reponame}"
    if [[ ! -d "$dirpath" ]]; then
      echo -n "Installing \"${repo}\""
      git clone --depth 1 \
        "https://github.com/${repo}" "${_plug_home}/${reponame}" &>/dev/null
      if [[ "$?" = 0 ]]; then
        echo " (done)"
      else
        echo " (fail)"
      fi
    fi
  done
}

function _plug::list() {
  local repo
  for repo in "${_plug_repos[@]}"; do
    echo -n "$repo"
    local reponame=$(basename "$repo")
    local dirpath="${_plug_home}/${reponame}"
    if [[ -d "$dirpath" ]]; then
      echo " (installed)"
    else
      echo " (not installed)"
    fi
  done
}

function _plug::clean() {
  local dir
  for dir in "$_plug_home"/*(N); do
    local dirname=$(basename "$dir")
    local matched=0
    for repo in "${_plug_repos[@]}"; do
      local reponame=$(basename "$repo")
      if [[ "$reponame" = "$dirname" ]]; then
        matched=1
        break
      fi
    done
    if [[ "$matched" = 0 ]]; then
      rm -rf "$dir"
      echo "Uninstalled \"${dirname}\""
    fi
  done
}

function _plug::load() {
  local repo
  for repo in "${_plug_repos[@]}"; do
    # Ignore plugins that have been loaded already
    if [[ -n "${_plug_loaded[(r)${repo}]}" ]]; then
      continue
    fi
    local reponame=$(basename "$repo")
    local dirpath="${_plug_home}/${reponame}"
    local file="$_plug_files[${repo}]"
    local filepath="${dirpath}/${file}"
    if [[ -d "$dirpath" ]]; then
      if [[ -x "$filepath" ]]; then
        # Just make sure executable file is in path
        path+=($(dirname "$filepath"))
      else
        # Otherwise source the file
        source "$filepath"
      fi
    fi
    _plug_loaded+=("$repo")
  done
}

function plug() {
  if [[ "$#" = 0 ]]; then
    _plug::help
    return
  fi

  local cmd="$1"
  shift

  case "$cmd" in
    "use")
      _plug::use "$@"
      ;;
    "install")
      _plug::install "$@"
      ;;
    "list")
      _plug::list "$@"
      ;;
    "clean")
      _plug::clean "$@"
      ;;
    "load")
      _plug::load "$@"
      ;;
    "help")
      _plug::help "$@"
      ;;
    *)
      echo "unknown command: ${cmd}"
      _plug::help "$@"
      ;;
  esac
}
