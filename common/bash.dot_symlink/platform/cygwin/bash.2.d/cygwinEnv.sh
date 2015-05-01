#!/usr/bin/env bash
if [ -z "$_cygwinEnv" ]; then
  export _cygwinEnv=1
  #See http://www.cygwin.com/cygwin-ug-net/using-cygwinenv.html
  # Note: Not using obsolete options
  export CYGWIN="nodosfilewarning"
  unset PYTHONHOME
fi
