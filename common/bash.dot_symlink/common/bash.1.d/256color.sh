#!/usr/bin/env bash
#See https://fedoraproject.org/wiki/Features/256_Color_Terminals#Scope
######################################################################
# Enable 256 color capabilities for appropriate terminals

# Set this variable in your local shell config if you want remote
# xterms connecting to this system, to be sent 256 colors.
# This can be done in /etc/csh.cshrc, or in an earlier profile.d script.
#   SEND_256_COLORS_TO_REMOTE=1

# Terminals with any of the following set, support 256 colors (and are local)
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION$VTE_VERSION"

#As well, mintty.exe supports 256 colors
#Test for mintty.exe is added below

if [ -n "$local256" ] || \
  [ -n "$SEND_256_COLORS_TO_REMOTE" ] || \
  [ -n "$MSYSCON" ] && [ "$MSYSCON" == "mintty.exe" ]; then

  case "$TERM" in
    'xterm') TERM=xterm-256color;;
    'screen') TERM=screen-256color;;
    'Eterm') TERM=Eterm-256color;;
  esac
  export TERM

  if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
    #shellcheck disable=SC2001
    TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    export TERMCAP
  fi
fi

unset local256
