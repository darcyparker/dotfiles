#!/usr/bin/env bash

# Aliases specific to Linux
alias ls="ls --color -F"
eval `dircolors ~/.dircolors/dircolors.ansi-universal`

[ `which ack-grep 2> /dev/null` ] && alias ack="ack-grep"
alias open="xdg-open"

if [ -z $JAVA_HOME ]; then
  #Not: this assumes gnu readlink (darwin and perhaps others use BSD
  #readlink where -f has different meaning)
  #Sometimes java is pointing to JRE inside a JDK
  # - if so, JAVA_HOME is set to the JDK root folder
  # - otherwise, JAVA_HOME is just 2 folders up from java command
  export JAVA_HOME=`readlink -f $(which java) | sed 's:\(/jre\)\?/bin/java$::'`
fi

[ -r /etc/bash_completion ] && . /etc/bash_completion
[ -r /usr/share/doc/tmux/examples/bash_completion_tmux.sh ] && . /usr/share/doc/tmux/examples/bash_completion_tmux.sh
