#!/usr/bin/env bash
# Use gh (GitHub CLI) alongside git
# Makes 'git' a superset: git commands + GitHub commands
# See: https://cli.github.com/

if type gh &> /dev/null && [[ $(type -t git) != "function" ]]; then
  git() {
    case "$1" in
      # GitHub-specific commands → gh
      pr|issue|repo|gist|release|workflow|run|codespace|cs|browse|api|auth|ssh-key|gpg-key|secret|variable|cache|attestation|ruleset|label|org|project|search|extension|ext)
        command gh "$@" ;;
      # Access gh's versions of commands that overlap with git
      ghstatus) shift; command gh status "$@" ;;
      ghconfig) shift; command gh config "$@" ;;
      # gh aliases - add here when adding to ~/.config/gh/config.yml
      # prl|ic)
      #   command gh "$@" ;;
      # Everything else → git
      *)
        command git "$@" ;;
    esac
  }
fi
