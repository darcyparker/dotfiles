#!/usr/bin/env bash
#shellcheck disable=SC2154 disable=SC1090
. "$_utilitiesDir/time_func.sh"

if ! declare -f _debug &>/dev/null ; then
  function _debugInitTime() {
    _lastDebugTime=$(getTimeStamp)
    if [ -n "$_debug" ]; then
      echo "${_lastDebugTime}:StartTime"
    fi
  }

  function _debug() {
    local _currentTime
    local _startms
    local _endms
    local _timediff
    _currentTime=$(date +"%H:%M:%S.%3N")
    _startms=$(ts_get_msec "$_lastDebugTime")
    _endms=$(ts_get_msec "$_currentTime")
    _timediff=$((10#$_endms - 10#$_startms))ms
    if [ -n "$_debug" ]; then
      echo "${_currentTime}:timeDiff=${_timediff}: " "$@"
    fi
    _lastDebugTime=$_currentTime
  }
  export -f _debugInitTime
  export -f _debug
fi
