#!/usr/bin/env bash
# Sync personal MCP servers into ~/.claude.json at USER scope, so they load
# everywhere (terminal + the VS Code extension).
# Source of truth: ~/src/dotfiles/claude/mcp.json
#
# Idempotent — safe to re-run.
# IMPORTANT: run with NO active Claude Code session open. A live session can
# rewrite ~/.claude.json on exit and clobber these changes.
set -euo pipefail

command -v jq >/dev/null || { echo "error: jq is required but not installed" >&2; exit 1; }

mcp_file="$HOME/src/dotfiles/claude/mcp.json"

for name in $(jq -r '.mcpServers // {} | keys[]' "$mcp_file"); do
  cfg="$(jq -c --arg n "$name" '.mcpServers[$n]' "$mcp_file")"
  claude mcp remove "$name" --scope user >/dev/null 2>&1 || true
  claude mcp add-json "$name" "$cfg" --scope user
  echo "synced (user scope): $name"
done

echo "Done. Verify with: claude mcp list"
