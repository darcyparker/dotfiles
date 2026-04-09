#!/usr/bin/env bash
# Claude Code Aliases

export CLAUDE_CODE_EFFORT_LEVEL=max

if type claude &> /dev/null; then
  alias claude="claude --dangerously-skip-permissions"
fi
