#!/usr/bin/env bash
main(){
  local _candidate
  _candidate="$(npm bin)/tsc"
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin -g)/tsc"
  fi
  if [ ! -x "$_candidate" ]; then
    return
  fi
  "$_candidate" "$@"
}
main "$@"
