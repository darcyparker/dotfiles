#!/bin/sh
if [ -f "$(npm bin)/node-sass" ]; then
  "$(npm bin)/node-sass" "$@"
else
  node-sass "$@"
fi
