#!/usr/bin/env bash
[ -d /usr/local/go/bin ] && [ "${PATH#*/usr/local/go/bin:}" == "$PATH" ] && export PATH="/usr/local/go/bin:$PATH"
[ -n "$GOPATH" ] && [ "${PATH#*$GOPATH/bin:}" == "$PATH" ] && export PATH="$GOPATH/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && [ "${PATH#*$HOME/.cargo/bin:}" == "$PATH" ] && export PATH="$HOME/.cargo/bin:$PATH"
[[ -n "$RUBY_BIN_PATH" && ":$PATH:" != *":$RUBY_BIN_PATH:"* ]] && export PATH="$RUBY_BIN_PATH:$PATH"
[ -d /usr/local/bin ] && [ "${PATH#*/usr/local/bin:}" == "$PATH" ] && export PATH="/usr/local/bin:$PATH"
[ -d /usr/local/sbin ] && [ "${PATH#*/usr/local/sbin:}" == "$PATH" ] && export PATH="/usr/local/sbin:$PATH"
[ -d "$HOME/.local/bin" ] && [ "${PATH#*$HOME/.local/bin:}" == "$PATH" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && [ "${PATH#*$HOME/bin:}" == "$PATH" ] && export PATH="$HOME/bin:$PATH"

# Ensure nvm's node takes precedence over any other node on PATH (Homebrew,
# system, etc.), however/whenever that got added on this platform. This is the
# last PATH-ordering file sourced, so moving nvm's bin to the front here wins.
# Prefer $NVM_BIN (exported by `nvm use`, incl. cdnvm's per-project .nvmrc switch);
# fall back to the default alias. No-op where nvm isn't in use (e.g. Cygwin/MSYS).
__nvm_bin="$NVM_BIN"
if [ ! -d "$__nvm_bin" ] && [ -n "$NVM_DIR" ] && declare -f nvm >/dev/null 2>&1; then
  __nvm_bin="$NVM_DIR/versions/node/$(nvm version default 2>/dev/null)/bin"
fi
if [ -d "$__nvm_bin" ]; then
  __p=":$PATH:"; __p="${__p//:$__nvm_bin:/:}"; __p="${__p#:}"; __p="${__p%:}"  # strip existing
  export PATH="$__nvm_bin:$__p"                                                # then move to front
fi
unset __nvm_bin __p
