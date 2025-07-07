#!/usr/bin/env bash
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  # fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
fi
