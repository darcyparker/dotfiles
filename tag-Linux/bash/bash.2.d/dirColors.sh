#!/usr/bin/env bash
if [ ! -f "$HOME/.dcolors.sh" ]; then
  # If so, generate the script file. This only runs once.
  dircolors "$HOME/.dircolors/dircolors.256dark" >"$HOME/.dcolors.sh"
fi

source "$HOME/.dcolors.sh"
