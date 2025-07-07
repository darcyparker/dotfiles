#!/usr/bin/env bash
#
# Safely upgrades the TERM variable to its 256-color variant if the
# terminal appears capable but is using a generic TERM setting.
######################################################################

# This script will only act if $TERM is a generic value. If it already
# contains "256color", "kitty", "alacritty", "wezterm", etc., this
# case statement will not match, and your correct TERM will be preserved.
case "$TERM" in
xterm | Eterm | vt220)
  # The $COLORTERM variable is a modern, de-facto standard for a
  # terminal to announce color capabilities (e.g., 'truecolor').
  # If it's set, we can be confident about upgrading TERM.
  if [ -n "$COLORTERM" ]; then
    export TERM=xterm-256color
  fi
  ;;

screen)
  # Also handle the 'screen' case, common inside multiplexers.
  if [ -n "$COLORTERM" ]; then
    export TERM=screen-256color
  fi
  ;;
esac

# Note: The legacy TERMCAP logic from the original script has been
# removed. It is an obsolete mechanism that is not needed today.
