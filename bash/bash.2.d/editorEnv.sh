#!/usr/bin/env bash
if [ -z "$EDITOR" ]; then
  #if type nvim &> /dev/null; then
  #  EDITOR=nvim
  #  alias vim=nvim
  #else
  #  EDITOR=vim
  #fi
  EDITOR=vim
  export EDITOR
#else
#  if type nvim &> /dev/null; then
#    alias vim=nvim
#  fi
fi
