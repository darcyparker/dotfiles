#!/usr/bin/env bash
if type nvim &> /dev/null; then
  ulimit -n 4096 #May increase in future.
  EDITOR=nvim
  alias vim=nvim
else
  EDITOR=vim
fi
export EDITOR
