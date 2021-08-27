#!/usr/bin/env bash
# Aliases specific to OS X

# which will look for aliases, functions and binaries
# if [[ ! $(declare -F which) ]]; then
#   function which { (alias; declare -f) | gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
#   export -f which
# fi

#Note: Can't use $(brew --prefix) because brew is not in path yet
#I know my brew prefix... so I am hard coding it for now
if [ -f /usr/local/etc/bash_completion ]; then
  # shellcheck disable=SC1091
  . /usr/local/etc/bash_completion
fi


if [ -x "$(command -v java)" ] && [ -z "$JAVA_HOME" ]; then
  if [ -x "/usr/libexec/java_home" ]; then
    JAVA_HOME="$(/usr/libexec/java_home)"
    export JAVA_HOME
  elif [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ]; then
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
  fi
fi

#MS Office Aliases
# shellcheck disable=SC1117
alias word="open -a Microsoft\ Word"
# shellcheck disable=SC1117
alias excel="open -a Microsoft\ Excel"
# shellcheck disable=SC1117
alias ppt="open -a Microsoft\ Powerpoint"

alias xcode="open -a Xcode.app"
alias itunes="open -a iTunes.app"
alias facetime="open -a facetime.app"

# shellcheck disable=SC1117
alias address="open -a Address\ Book"
# shellcheck disable=SC1117
alias activity="open -a Activity\ Monitor"
alias textedit="open -a TextEdit.app"

alias filezilla="open -a Filezilla"
# shellcheck disable=SC1117
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
