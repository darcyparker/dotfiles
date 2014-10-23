#!/usr/bin/env bash
if [ -z $_lessEnv ]; then
  export _lessEnv=1
  export PAGER="less"

  #less default behaviour
  export LESS="ReMqXi~g"
  #R Raw color codes in output (don't remove color codes)
  #e exit the second time it reaches end of line
  #M verbose prompt
  #q quiet operation
  #X disables sending the termcap initialization/deinitialization strings
  #  ie prevents clear screen
  #i searches ignore case
  #~ - Don't show those weird ~ symbols on lines after EOF
  #g - Highlight results when searching with slash key (/)
fi
