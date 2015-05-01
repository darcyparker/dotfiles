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

if [ -z "$savePS1" ]; then
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWCOLORHINTS=1
  export GIT_PS1_DESCRIBE_STYLE="branch"
  export GIT_PS1_SHOWUPSTREAM="auto git verbose"

  PS1="$(tput setaf 2)\#$(tput sgr0) $(tput setaf 7)\u$(tput setaf 1)@$(tput setaf 7)\h$(tput sgr0):$(tput setaf 6)\w$(tput setaf 3)"

  #Start of PS1
  if type git &> /dev/null; then
    if ! declare -f __git_ps1 &>/dev/null ; then
      . "$_utilitiesDir/git-prompt.sh"
      export -f __gitdir
      export -f __git_ps1_show_upstream
      export -f __git_ps1
    fi
    #Note: For some reason on mingw64 and mingw32, git-prompt.sh function `__git_ps1`
    #      only works if it is called with `__git_ps1`.
    #      $(__git_ps1) does not work.
    PS1=$PS1'`__git_ps1`'" "
  fi
  #Add end of PS1 and export
  export PS1=$PS1$(tput sgr0)'\n\$ '
  export savePS1=$PS1
else
  #For some reason on cygwin, $PS1 gets overwritten because
  #/etc/profile and /etc/bash.bashrc are re-executed. So I reuse $savePS1
  #if it exists. This improves performance because each `tput` takes a fair amount
  #of time to run
  export PS1=$savePS1
fi
