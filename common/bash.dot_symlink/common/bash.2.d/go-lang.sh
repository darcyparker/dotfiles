#!/usr/bin/env bash
if [ -z $GOPATH ]; then
  if type go &>/dev/null; then
    export GOPATH=~/src/gocode
  fi
fi
