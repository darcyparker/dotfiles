#!/usr/bin/env bash
if ! declare -f mcd &>/dev/null ; then
  function mcd { mkdir -p "$1" && cd "$1" || exit; }
  export -f mcd
fi
