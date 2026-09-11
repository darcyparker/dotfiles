#!/usr/bin/env bash

# The Linux tailscale CLI and the Windows Tailscale client have separate local
# daemons and separate node identities. These helpers prefer the normal WSL
# path, but can use the Windows client's peer list when WSL DNS is unavailable.

_sshRemote_is_wsl() {
  [[ -n "${WSL_DISTRO_NAME:-}" || -r /proc/version ]] &&
    grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null
}

_sshRemote_windows_tailscale() {
  local candidate
  candidate=$(command -v tailscale.exe 2>/dev/null || true)
  if [[ -n "$candidate" && -x "$candidate" ]]; then
    printf '%s' "$candidate"
    return 0
  fi

  for candidate in \
    '/mnt/c/Program Files/Tailscale/tailscale.exe' \
    '/mnt/c/Program Files (x86)/Tailscale/tailscale.exe'; do
    if [[ -x "$candidate" ]]; then
      printf '%s' "$candidate"
      return 0
    fi
  done
  return 1
}

_sshRemote_peer_ip() {
  local tailscale_cli=$1 target_host=$2 status peer_ip
  command -v jq >/dev/null 2>&1 || return 1

  status=$("$tailscale_cli" status --json 2>/dev/null) || return 1
  peer_ip=$(jq -r --arg wanted "$target_host" '
    def clean: ascii_downcase | sub("\\.$"; "");
    ($wanted | clean) as $h |
    (.Peer // {} | to_entries[] | .value) as $peer |
    (($peer.HostName // "") | clean) as $short |
    (($peer.DNSName // "") | clean) as $dns |
    select($short == $h or $dns == $h or ($dns | startswith($h + "."))) |
    ($peer.TailscaleIPs[]? | select(test("^[0-9]+(\\.[0-9]+){3}$")))
  ' <<<"$status" | sed -n '1p')
  [[ -n "$peer_ip" ]] || return 1
  printf '%s\n' "$peer_ip"
}

_sshRemote_usage() {
  cat <<'EOF'
Usage: sshRemote [--check] [--direct] user@host [session_name]

  --check   Diagnose SSH/Tailscale name resolution without opening a session.
  --direct  Do not use the Windows Tailscale peer-IP fallback when WSL DNS fails.
EOF
}

_sshRemote_print_environment() {
  local platform linux_cli linux_status windows_cli windows_status
  if _sshRemote_is_wsl; then
    platform="WSL2 (${WSL_DISTRO_NAME:-unknown distro})"
  else
    platform='Linux'
  fi
  linux_cli=$(command -v tailscale 2>/dev/null || true)
  if [[ -n "$linux_cli" ]]; then
    if tailscale status --json >/dev/null 2>&1; then
      linux_status='reachable'
    else
      linux_status='unavailable'
    fi
  else
    linux_cli='not found'
    linux_status='not installed'
  fi
  printf 'sshRemote: environment=%s\n' "$platform"
  printf 'sshRemote: Linux Tailscale=%s (%s)\n' "$linux_cli" "$linux_status"

  if _sshRemote_is_wsl; then
    windows_cli=$(_sshRemote_windows_tailscale || true)
    if [[ -n "$windows_cli" ]]; then
      if "$windows_cli" status --json >/dev/null 2>&1; then
        windows_status='reachable'
      else
        windows_status='unavailable'
      fi
      printf 'sshRemote: Windows Tailscale=%s (%s)\n' "$windows_cli" "$windows_status"
    else
      printf 'sshRemote: Windows Tailscale=not found\n'
    fi
  fi
}

# Usage: sshRemote darcy@darcy-flex-desk [session_name]
sshRemote() {
  local check_only=0 direct=0
  while (($# > 0)); do
    case "$1" in
    --check) check_only=1 ;;
    --direct) direct=1 ;;
    -h | --help)
      _sshRemote_usage
      return 0
      ;;
    --*)
      printf 'sshRemote: unknown option: %s\n' "$1" >&2
      _sshRemote_usage >&2
      return 2
      ;;
    *) break ;;
    esac
    shift
  done

  if (($# < 1 || $# > 2)); then
    _sshRemote_usage >&2
    return 2
  fi

  local remote_spec=$1 remote_session=${2:-main}
  # Keep the target in the supported SSH host grammar. In particular, do not
  # let it become shell syntax in the tmux command constructed below.
  if [[ "$remote_spec" == -* || "$remote_spec" == *[!A-Za-z0-9_.@%:+,-]* ]]; then
    printf 'sshRemote: target contains unsupported characters: %s\n' "$remote_spec" >&2
    return 2
  fi
  if [[ "$remote_session" == -* || "$remote_session" == *[!A-Za-z0-9_.:-]* ]]; then
    printf 'sshRemote: session contains unsupported characters: %s\n' "$remote_session" >&2
    return 2
  fi

  command -v ssh >/dev/null 2>&1 || {
    printf 'sshRemote: ssh not found in PATH\n' >&2
    return 2
  }
  command -v tmux >/dev/null 2>&1 || {
    printf 'sshRemote: tmux not found in PATH\n' >&2
    return 2
  }

  local ssh_config effective_host effective_user
  if ssh_config=$(ssh -G "$remote_spec" 2>/dev/null); then
    effective_host=$(awk '$1 == "hostname" { print $2; exit }' <<<"$ssh_config")
    effective_user=$(awk '$1 == "user" { print $2; exit }' <<<"$ssh_config")
  else
    # A damaged system-wide SSH config should not hide the useful WSL/Tailscale
    # diagnosis. The real SSH invocation will still report the config failure.
    effective_host=${remote_spec##*@}
    effective_user=${remote_spec%@*}
    [[ "$effective_user" == "$remote_spec" ]] && effective_user=${USER:-darcy}
    printf 'sshRemote: warning: ssh -G failed; using target literally (%s)\n' "$effective_host" >&2
  fi
  [[ -n "$effective_host" ]] || {
    printf 'sshRemote: SSH did not produce an effective hostname for %s\n' "$remote_spec" >&2
    return 2
  }

  local connect_host=$effective_host host_key_alias='' windows_cli='' peer_ip=''
  local resolution='DNS'
  if ! getent ahosts "$effective_host" >/dev/null 2>&1; then
    resolution='unresolved'
    if ((direct == 0)) && _sshRemote_is_wsl; then
      windows_cli=$(_sshRemote_windows_tailscale || true)
      if [[ -n "$windows_cli" ]]; then
        peer_ip=$(_sshRemote_peer_ip "$windows_cli" "$effective_host" || true)
      fi
      if [[ -n "$peer_ip" ]]; then
        connect_host=$peer_ip
        host_key_alias=$effective_host
        resolution="Windows Tailscale peer IP $peer_ip"
      fi
    fi
  fi

  printf 'sshRemote: target=%s user=%s host=%s (%s)\n' \
    "$remote_spec" "$effective_user" "$effective_host" "$resolution"

  if [[ "$resolution" == unresolved ]]; then
    printf '%s\n' \
      'sshRemote: WSL cannot resolve this host and Windows Tailscale did not provide a peer IP.' \
      '  Check the Windows Tailscale app is connected, then retry.' \
      '  To inspect without launching tmux: sshRemote --check user@host' \
      '  To force the ordinary SSH path: sshRemote --direct user@host'
    return 1
  fi

  if ((check_only)); then
    _sshRemote_print_environment
    printf 'sshRemote: target preflight passed; no session started.\n'
    return 0
  fi

  # We prefix with "remote-" to trigger the tmux hook. The values were
  # restricted above, so this is a stable local session identifier.
  local local_name="remote-${remote_spec}-${remote_session}"
  tmux kill-session -t "$local_name" 2>/dev/null || true

  local remote_command quoted_remote_command tmux_command log_file
  printf -v quoted_remote_command '%q' "$remote_session"
  remote_command="export PROXY_IMPORT=true; tmux attach -t $quoted_remote_command || tmux new -s $quoted_remote_command"

  local -a ssh_args=(ssh -t -o ConnectTimeout=10 -o ConnectionAttempts=1)
  if [[ -n "$host_key_alias" ]]; then
    ssh_args+=(-o "HostName=$connect_host" -o "HostKeyAlias=$host_key_alias")
  fi
  log_file=$(mktemp "${TMPDIR:-/tmp}/sshRemote.XXXXXX") || {
    printf 'sshRemote: could not create an SSH diagnostic log\n' >&2
    return 2
  }
  ssh_args+=(-E "$log_file" "$remote_spec" "$remote_command")
  printf -v tmux_command '%q ' "${ssh_args[@]}"

  printf 'Engaging linkage to %s...\n' "$remote_spec"
  env -u TMUX tmux new-session -d -s "$local_name" "$tmux_command"

  sleep 0.5
  if tmux has-session -t "$local_name" 2>/dev/null; then
    tmux switch-client -t "$local_name"
    return $?
  fi

  printf 'sshRemote: local portal session exited before attaching.\n' >&2
  if [[ -s "$log_file" ]]; then
    printf 'SSH diagnostics (%s):\n' "$log_file" >&2
    tail -n 20 "$log_file" >&2
  else
    printf 'SSH diagnostic log: %s\n' "$log_file" >&2
  fi
  return 1
}
