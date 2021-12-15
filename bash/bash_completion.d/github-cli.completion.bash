#!/usr/bin/env bash
if command -v gh >/dev/null; then
  eval "$(gh completion --shell=bash)"
fi
