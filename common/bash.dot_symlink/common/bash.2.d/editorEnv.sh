#!/usr/bin/env bash
if [ -z "$EDITOR" ]; then
  export EDITOR="$(which vim)"
fi
