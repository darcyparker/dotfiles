# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Check that we haven't already been sourced.
[ -z "$BASHRC_LOADED" ] || return

set -o vi

function _source_dir {
  local i
  local _pattern

  if [ -z "$2" ]; then
    _pattern="*.sh"
  else
    _pattern="$2"
  fi

  if [ -d "$1" ]; then
    for i in "$1"/$_pattern; do
      if [ -d "$i" ]; then
        _source_dir "$i"
      elif [ -r "$i" ]; then
        ##_debug is slow - even if it is off, so commenting out when not used
        #_debug "Sourcing \"$i\""
        # shellcheck source=/dev/null
        . "$i"
      fi
    done
  fi
}

function main {
  #local _debug=1
  #. $HOME/.bash/utilities/debug_func.sh
  #_debugInitTime
  #_debug "Loading \"~/.bashrc\""

  _source_dir "$HOME/.bash/" "bash.*.d"

  #_debug "Finished"

  if [ -x "$(command -v tmux)" ] && [ -z "$TMUX" ] && [ "$TERM" == "xterm-256color" ]; then
    tmux new
  fi
}

#Load bash_completion IF it appears they are not loaded.
# * Uses simple test for __git_complete
# * About bash_completion script:
# * Eagerly sources definitions in $compat_dir (ie /etc/bash_completion.d)
# * Eagerly sources $user_completion (ie $HOME/.bash_completion)
# * And sets up dynamic loading of completions in /usr/share/bash-completion/completions
# if ! compgen -c | grep -q __git_complete; then
if ! declare -f __git_complete &>/dev/null; then
  _bash_completion=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) ||
    _bash_completion='/usr/share/bash-completion/completions/'
  _bash_completion=$(dirname "$_bash_completion")/bash_completion
  if [ -f "$_bash_completion" ]; then
    # shellcheck disable=1090
    . "$_bash_completion"
  fi
  unset _bash_completion
fi

main
unset -f main
unset -f _source_dir

BASHRC_LOADED=1
