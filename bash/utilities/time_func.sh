#!/usr/bin/env bash

if ! declare -f getTimeStamp &>/dev/null ; then
  if date --version >/dev/null 2>&1 ; then
    #Has GNU Date
    #shellcheck disable=SC2154
    if [ -n "$_debug" ]; then
      echo Has GNU Date
    fi
    function getTimeStamp() {
      date +"%H:%M:%S.%3N"
    }
  else
    #Does not have GNU Date. (Likely BSD)
    if [ -n "$_debug" ]; then
      echo Does not have GNU Date
    fi
    function getTimeStamp() {
      #Note: BSD Date does not support %3N
      #      So measurement is not as good.
      date +"%H:%M:%S.000"
    }
  fi
  export -f getTimeStamp
fi

if ! declare -f ts_get_msec &>/dev/null ; then
  function ts_get_msec() {
    read -r h m s ms <<< "$(echo "$1" | tr '.:' ' ' )"
    echo $(((10#$h*3600000)+(10#$m*60000)+(10#$s*1000)+10#$ms))
  }
  export -f ts_get_msec
fi
