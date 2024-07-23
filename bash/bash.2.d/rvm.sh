#!/usr/bin/env bash
#See https://rvm.io/
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  if ! declare -f rvm &>/dev/null ; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"

    # Load RVM into a shell session *as a function*
    # shellcheck disable=SC1090
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" > /dev/null 2>&1 # Load RVM into a shell session *as a function*
    rvm use default > /dev/null 2>&1
  fi
fi
if [ -z "$GEM_PATH" ]; then
    export GEM_PATH=~/.gem
fi
