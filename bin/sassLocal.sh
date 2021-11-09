#!/usr/bin/env bash
main(){
  local _candidate
  _candidate="$(npm bin)/sass"
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin)/node-sass"
  fi
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin -g)/sass"
  fi
  if [ ! -x "$_candidate" ]; then
    _candidate="$(npm bin -g)/node-sass"
  fi
  if [ ! -x "$_candidate" ]; then
    return
  fi
  "$_candidate" "$@"
}
main "$@"
