setopt AUTO_CD

# Load zmv
autoload -U zmv

# Use ctrl-p for switching directory
function _ctrl_p() {
  local dir=$( \
    # List top directories with z
    z -l | tac | head -n 100 | awk '{print $2}'| \
    # Exclude current directory from list
    grep --invert-match --line-regexp --fixed-strings "$(pwd)" | \
    sed "s,${HOME},~," | \
    fzf --reverse --tiebreak=end,index --exact --height 40% | \
    sed "s,~,${HOME}," \
  )
  if [[ -d "$dir" ]]; then
    cd "$dir"
  fi
  zle fzf-redraw-prompt
}
zle -N _ctrl_p
bindkey '^P' _ctrl_p
