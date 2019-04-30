#!/usr/bin/env bash
if [ -z "$EDITOR" ]; then
  EDITOR=$(which nvim)
  if [ -z "$EDITOR" ]; then
    EDITOR=$(which vim)
  else
    # shellcheck disable=SC2139
    alias vim="$EDITOR"
  fi
  export EDITOR
else
  # shellcheck disable=SC2139
  alias vim="$EDITOR"
fi
