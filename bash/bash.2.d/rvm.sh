#!/usr/bin/env bash
#See https://rvm.io/
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  if ! declare -f rvm &>/dev/null ; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"

    # Load RVM into a shell session *as a function*
    # shellcheck disable=SC1090
    source "$HOME/.rvm/scripts/rvm" > /dev/null 2>&1
    rvm use default > /dev/null 2>&1
  fi
fi
