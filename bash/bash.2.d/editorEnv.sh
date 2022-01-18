#!/usr/bin/env bash
if [ -z "$EDITOR" ]; then
  if type nvim &> /dev/null; then
    EDITOR=nvim
  else
    EDITOR=vim
  fi
  export EDITOR
fi
if type nvim &> /dev/null; then
  alias vim=nvim
fi
