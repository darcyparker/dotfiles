#!/usr/bin/env bash
# Colorized prompt, with different username colors for different systems.

#Note: This must be sourced every time because `/etc/.profile` often resets
#      prompt

###############
# Color codes #
###############
# - 0 Black
# - 1 Red
# - 2 Green
# - 3 Yellow
# - 4 Blue
# - 5 Purple
# - 6 Cyan
# - 7 White
#################
#tput commands: #
#################
# - setaf : foreground
# - setab : background
# - sgr0 : clear attributes
# - bold : Set bold mode
# - dim : turn on half-bright mode
# - smul : begin underline mode
# - rmul : exit underline mode
# - rev : Turn on reverse mode
# - smso : Enter standout mode (bold on rxvt)
# - rmso : Exit standout mode

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git verbose"

#Start of PS1
PS1="$(tput setaf 2)\#$(tput sgr0) $(tput setaf 7)\u$(tput setaf 1)@$(tput setaf 7)\h$(tput sgr0):$(tput setaf 6)\w$(tput setaf 3)"
if type git &> /dev/null; then
  . $_utilitiesDir/git-prompt.sh
  if type __git_ps1 &>/dev/null; then
    #Note: For some reason on mingw64 and mingw32, git-prompt.sh function `__git_ps1`
    #      only works if it is called with `__git_ps1`.
    #      $(__git_ps1) does not work.
    PS1=$PS1'`__git_ps1`'" "
  fi
fi
#Add end of PS1 and export
export PS1=$PS1$(tput sgr0)'\n\$ '
