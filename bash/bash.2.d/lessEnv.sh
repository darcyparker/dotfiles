#!/usr/bin/env bash
if [ -z "$_lessEnv" ]; then
  export _lessEnv=1
  export PAGER="less"

  #less default behaviour
  #* -F -X Don't paginate if < 1 page
  export LESS="-F -X ReMqXi~g"


  #R Raw color codes in output (don't remove color codes)
  #e exit the second time it reaches end of line
  #M verbose prompt
  #q quiet operation
  #X disables sending the termcap initialization/deinitialization strings
  #  ie prevents clear screen
  #i searches ignore case
  #~ - Don't show those weird ~ symbols on lines after EOF
  #g - Highlight results when searching with slash key (/)

  # Colored man pages: http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
  # Less Colors for Man Pages
  export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'           # end mode
  export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  export LESS_TERMCAP_so=$'\E[38;5;016m\E[48;5;220m'    # begin standout-mode - info box
  export LESS_TERMCAP_ue=$'\E[0m'           # end underline
  export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
fi
