#!/usr/bin/env bash
if ! type mcd &>/dev/null; then
  mcd () { mkdir -p $1 && cd $1; }
fi
