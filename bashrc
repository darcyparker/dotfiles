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

  #Mac M1 arch installs brew to /opt/homebrew/bin and not /usr/local
  if [ -s /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  _source_dir "$HOME/.bash/" "bash.*.d"

  if [ -e "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
  fi

  #_debug "Finished"

  if [[ -x "$(command -v tmux)" && -z "$TMUX" && -z "$SSH_CLIENT" && "$TERM" =~ ^xterm ]]; then
    tmux attach || tmux new
  fi
}

#Load bash_completion IF it appears they are not loaded.
if [ -z "$BASH_COMPLETION" ]; then
  if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    #Typically Darwin
    . "/usr/local/etc/profile.d/bash_completion.sh"
  else
    #Typically linux
    # * About `bash_completion` script
    # * Eagerly sources definitions in $compat_dir (ie /etc/bash_completion.d)
    # * Eagerly sources $user_completion (ie $HOME/.bash_completion)
    # * And sets up dynamic loading of completions in /usr/share/bash-completion/completions
    _bash_completion=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) ||
      _bash_completion='/usr/share/bash-completion/completions/'
    _bash_completion=$(dirname "$_bash_completion")/bash_completion
    if [ -f "$_bash_completion" ]; then
      # shellcheck disable=1090
      . "$_bash_completion"
    fi
    unset _bash_completion
  fi
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

#If WSL2? set $DISPLAY for xserver
if [ -f "/etc/wsl.conf" ]; then
  export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
  # Direct rendering: LIBGL_ALWAYS_INDIRECT=0
  # * Supports whatever version of OpenGL the graphics driver supports, which could be up to OpenGL 4.x or higher if OpenGL ever releases a new version.
  # * Requires the environment variable LIBGL_ALWAYS_INDIRECT to be unset.
  # * Sends all OpenGL commands using dynamic loading to the symbols available in libGL.so (with the appropriate version on the end, like libGL.so.1, etc.) -- these are native function calls.
  # * The X server does not directly "see" the OpenGL rendering commands. All it sees is a rectangular region that it sets aside in the frame buffer for the graphics driver to render into. It doesn't know what is rendered, only where.
  # * Is not network-transparent, meaning it only works locally on the same computer.
  export LIBGL_ALWAYS_INDIRECT=0
fi

main
unset -f main
unset -f _source_dir

BASHRC_LOADED=1
