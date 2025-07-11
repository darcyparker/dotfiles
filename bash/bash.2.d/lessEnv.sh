#!/usr/bin/env bash

if type bat &>/dev/null; then
  export PAGER='bat'
else

  # Set less as the default pager for commands like 'man'
  export PAGER="less"

  # Set default options for less
  # -F : Quit if content fits on one screen.
  # -R : Output raw control characters (for colors).
  # -i : Case-insensitive searching.
  # -X : Do not clear the screen on exit.
  export LESS="-FRiX"
fi
