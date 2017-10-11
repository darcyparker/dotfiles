# See: https://github.com/dnschneid/crouton/wiki/crouton-in-a-Chromium-OS-window-(xiwi)#running-individual-applications-in-windows-and-tabs
# Wrap xiwi so that aliases work
# Modified original a bit to export xiwi() and not rewrite it if it exists

if ! declare -f xiwi &>/dev/null ; then
  xiwi() {
      local xiwiargs=''
      while [ "${1#-}" != "$1" ]; do
          xiwiargs="$xiwiargs $1"
          shift
      done
      local cmd="`alias "$1" 2>/dev/null`"
      if [ -z "$cmd" ]; then
          cmd="$1"
      else
          eval "cmd=${cmd#*=}"
          cmd="env $cmd"
      fi
      shift
      eval "/usr/local/bin/xiwi $xiwiargs $cmd \"\$@\""
  }
  export -f xiwi
fi
