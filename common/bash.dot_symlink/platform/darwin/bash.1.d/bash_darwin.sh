#!/usr/bin/env bash
_debug loading ~/.bash/bash_darwin
# Aliases specific to OS X

# which will look for aliases, functions and binaries
if [[ ! `declare -F which` ]]; then
  which () { (alias; declare -f) | gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
  export -f which
fi

#Note: Can't use $(brew --prefix) because brew is not in path yet
#I know my brew prefix... so I am hard coding it for now
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -z $JAVA_HOME ]; then
  if [ -x "/usr/libexec/java_home" ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
  elif [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ]; then
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
  fi
fi

alias ls="ls -F"

#MS Office Aliases
alias word="open -a Microsoft\ Word"
alias excel="open -a Microsoft\ Excel"
alias ppt="open -a Microsoft\ Powerpoint"

alias xcode="open -a Xcode.app"
alias itunes="open -a iTunes.app"
alias facetime="open -a facetime.app"

alias address="open -a Address\ Book"
alias activity="open -a Activity\ Monitor"
alias textedit="open -a TextEdit.app"

alias filezilla="open -a Filezilla"
alias chrome="open -a Google\ Chrome"
alias firefox="open -a Firefox"
alias mu="open -a muCommander"
alias yed="open -a yEd"

alias desktop="cd ~/Desktop"

#copy the working directory into the clipboard
alias cwd="pwd | pbcopy"

# Terminal shortcuts
alias .t="~/bin/terminal --new-tab"
alias .w="~/bin/terminal --new-window"

alias gvim="mvim"

export EDITOR="vim"
export GIT_EDITOR="vim -f"

#Set colors for OS X (BSD)
export CLICOLOR=1
export LSCOLORS="CxgxexexFxexexFxFxcxcx"
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
