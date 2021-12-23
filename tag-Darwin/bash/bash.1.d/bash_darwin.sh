#!/usr/bin/env bash

#https://support.apple.com/kb/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

#Note: Can't use $(brew --prefix) because brew is not in path yet
#I know my brew prefix... so I am hard coding it for now
if [ -f /usr/local/etc/bash_completion ]; then
  # shellcheck disable=SC1091
  . /usr/local/etc/bash_completion
fi

#TODO
#if [ -x "$(command -v java)" ] && [ -z "$JAVA_HOME" ]; then
#  if [ -x "/usr/libexec/java_home" ]; then
#    JAVA_HOME="$(/usr/libexec/java_home)"
#    export JAVA_HOME
#  elif [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ]; then
#    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
#  fi
#fi

#TODO: Find better home
# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

#TODO: Find better home
alias python="python3.7"
alias pip="pip3.7"

# shellcheck disable=SC1117
alias chrome="open -a Google\ Chrome"
alias desktop="cd ~/Desktop"
alias freecad="open -a freeCAD"

#copy the working directory into the clipboard
alias cwd="pwd | pbcopy"

# Terminal shortcuts
alias .t="~/bin/terminal --new-tab"
alias .w="~/bin/terminal --new-window"

alias gvim="mvim"

#Set colors for OS X (BSD)
export CLICOLOR=1
#export LSCOLORS="CxgxexexFxexexFxFxcxcx"
# Colors
#   a     black
#   b     red
#   c     green
#   d     brown
#   e     blue
#   f     magenta
#   g     cyan
#   h     light grey
#   A     bold black, usually shows up as dark grey
#   B     bold red
#   C     bold green
#   D     bold brown, usually shows up as yellow
#   E     bold blue
#   F     bold magenta
#   G     bold cyan
#   H     bold light grey; looks like bright white
#   x     default foreground or background
# Order of colors in LSCOLORS, specified in pairs (foreground/background) (22 chars)
#   1. directory
#   2. symbolic link
#   3. socket
#   4. pipe
#   5. executable
#   6. block special
#   7. character special
#   8. executable with setuid bit set
#   9. executable with setgid bit set
#   10. directory writable to others, with sticky bit
#   11. directory writable to others, without sticky bit#
