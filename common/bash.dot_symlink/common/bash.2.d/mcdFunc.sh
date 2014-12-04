#!/usr/bin/env bash
if ! declare -f mcd &>/dev/null ; then
  echo Defining mcd
  function mcd { mkdir -p $1 && cd $1; }
  export -f mcd
fi
