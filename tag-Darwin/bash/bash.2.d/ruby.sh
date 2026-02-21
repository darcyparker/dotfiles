#!/usr/bin/env bash
RUBY_BIN_PATH="$(brew --prefix ruby)/bin"
[[ -d "$RUBY_BIN_PATH" && "$PATH" != "$RUBY_BIN_PATH"* ]] && export PATH="$RUBY_BIN_PATH:$PATH"
