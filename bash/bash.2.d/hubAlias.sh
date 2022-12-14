#!/usr/bin/env bash
#See https://github.com/github/hub
if type hub &> /dev/null; then
  eval "$(hub alias -s)"
fi
