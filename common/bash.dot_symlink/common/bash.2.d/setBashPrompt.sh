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

if [ $(which git 2> /dev/null) ]; then
  . $_utilitiesDir/git-prompt.sh
  export PS1="$(tput setaf 2)\#$(tput sgr0) $(tput setaf 7)\u$(tput setaf 1)@$(tput setaf 7)\h$(tput sgr0):$(tput setaf 6)\w$(tput setaf 3)\$(__git_ps1)$(tput sgr0) \n\\\$ "
else
  export PS1="$(tput setaf 2)\#$(tput sgr0) $(tput setaf 7)\u$(tput setaf 1)@$(tput setaf 7)\h$(tput sgr0):$(tput setaf 6)\w$(tput setaf 3)$(tput sgr0) \n\\\$ "
fi
