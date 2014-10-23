#!/usr/bin/env bash
if [ -z $_rvmEnv ]; then
  export _rvmEnv=1
  #Load RVM into a shell session *as a function*
  #Loading RVM also adss $HOME/.rvm/bin to $PATH
  if [ -r $HOME/.rvm/scripts/rvm ]; then
    source $HOME/.rvm/scripts/rvm
  elif [ -r /usr/local/rvm/scripts/rvm ]; then
    source /usr/local/rvm/scripts/rvm
  fi
fi
