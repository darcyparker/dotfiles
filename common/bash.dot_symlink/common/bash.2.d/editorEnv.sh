#!/usr/bin/env bash
if [ -z "$EDITOR" ]; then
  EDITOR=$(which vim)
  export EDITOR
fi
