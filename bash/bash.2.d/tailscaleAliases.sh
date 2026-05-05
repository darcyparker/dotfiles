#!/usr/bin/env bash

if type tailscale &>/dev/null; then
  # Usage: sshRemote darcy-flex-desk [session_name]
  sshRemote() {
    local REMOTE_HOST=$1
    local REMOTE_SESSION=${2:-main}
    # We prefix with 'remote-' to trigger the tmux hook
    local LOCAL_NAME="remote-${REMOTE_HOST}-${REMOTE_SESSION}"

    tmux kill-session -t "$LOCAL_NAME" 2>/dev/null

    echo "Engaging linkage to $REMOTE_HOST..."

    env -u TMUX tmux new-session -d -s "$LOCAL_NAME" \
      "ssh -t $REMOTE_HOST \"export PROXY_IMPORT=true; tmux attach -t $REMOTE_SESSION || tmux new -s $REMOTE_SESSION\""

    sleep 0.5

    if tmux has-session -t "$LOCAL_NAME" 2>/dev/null; then
      tmux switch-client -t "$LOCAL_NAME"
    else
      echo "Mechanical Failure: Local portal session died."
    fi
  }
fi
