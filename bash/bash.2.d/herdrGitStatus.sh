# Live-update the herdr sidebar's $git segment for the current workspace on each prompt.
# Only active inside a herdr pane (HERDR_ENV=1). Backgrounded so it never slows the prompt.
# Don't want it? Delete this file (and remove the `$git` token from ~/.config/herdr/config.toml).
if [ "${HERDR_ENV:-}" = "1" ] && [ -n "${HERDR_WORKSPACE_ID:-}" ] && command -v herdr-git-status.sh >/dev/null 2>&1; then
  _herdr_git_status() { herdr-git-status.sh >/dev/null 2>&1 & }
  case "${PROMPT_COMMAND:-}" in
    *_herdr_git_status*) ;;
    *) PROMPT_COMMAND="_herdr_git_status${PROMPT_COMMAND:+; ${PROMPT_COMMAND}}" ;;
  esac
fi
