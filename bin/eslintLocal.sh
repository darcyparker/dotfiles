#!/usr/bin/env bash
main(){
  local _candidate
  _candidate="$(npm bin)/xo"
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin)/eslint"
  fi
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin -g)/xo"
  fi
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin -g)/eslint"
  fi
  if [ ! -x "$_candidate" ]; then
    return
  fi
  "$_candidate" "$@"
}
main "$@"
