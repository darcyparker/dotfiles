#!/bin/sh
if [ -f "$(npm bin)/eslint" ]; then
  "$(npm bin)/eslint" "$@"
else
  eslint "$@"
fi
