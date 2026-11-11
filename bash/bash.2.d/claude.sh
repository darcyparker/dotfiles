#!/usr/bin/env bash
# Claude Code wrapper: session defaults for interactive runs, bare passthrough for subcommands.
# Remote Control for every session: /config → "Enable Remote Control for all sessions".

# export CLAUDE_CODE_EFFORT_LEVEL=max

if type -P claude &>/dev/null; then
  unalias claude 2>/dev/null
  claude() {
    case "${1-}" in
      rc | remote-control)
        shift
        command claude remote-control --permission-mode bypassPermissions "$@"
        ;;
      agents | attach | auth | auto-mode | doctor | gateway | import | install | logs | mcp | \
        plugin | plugins | purge | respawn | rm | setup-token | stop | kill | ultrareview | \
        update | upgrade | -h | --help | -v | --version)
        command claude "$@"
        ;;
      *)
        command claude --dangerously-skip-permissions \
          --mcp-config="$HOME/src/dotfiles/claude/mcp.json" "$@"
        ;;
    esac
  }
fi
