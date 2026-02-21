#!/usr/bin/env bash
# `brew install coreutils` to install gdircolors
if command -v gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors ~/.dircolors/dircolors.256dark)"
# elif command -v dircolors >/dev/null 2>&1; then
#   eval "$(dircolors ~/.dircolors/dircolors.256dark)"
fi
