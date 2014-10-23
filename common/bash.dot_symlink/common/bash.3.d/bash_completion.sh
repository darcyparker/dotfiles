#!/usr/bin/env bash
if [ -z $_loadedBashCompletion ]; then
  export _loadedBashCompletion=1
  [ -r /etc/bash_completion ] && . /etc/bash_completion
  . "$HOME/.bash/common/completion.d/bash_completion_tmux.sh"
fi
