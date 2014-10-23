#!/usr/bin/env bash
. $_utilitiesDir/time_func.sh

_lastDebugTime=$(date +"%H:%M:%S.%3N")

function _debugInitTime() {
  _lastDebugTime=$(date +"%H:%M:%S.%3N")
}

function _debug() {
  local _currentTime=$(date +"%H:%M:%S.%3N")
  local _startms=$(ts_get_msec $_lastDebugTime)
  local _endms=$(ts_get_msec $_currentTime)
  local _timediff=$((10#$_endms - 10#$_startms))ms
  if [ -n "$_debug" ]; then
    echo "${_currentTime}:timeDiff=${_timediff}: "$@""
  fi
  _lastDebugTime=$_currentTime
}
