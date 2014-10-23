#!/usr/bin/env bash
if [ -z $_historyEnv ]; then
  export _historyEnv=1
  # History
  shopt -s histappend                         # Append each(!) history entry from all terminals realtime(not after sesion ending)
  shopt -s cmdhist                            # store multiline commands as 1 line
  shopt -s cdspell                            # spelling error correction
  shopt -s checkwinsize                       # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
  # HISTCONTRL settings: "ignoreboth" is same as "ignorespace:ignoredups"
  # ignore commands that begin with space and ignore duplicate commmands
  export HISTCONTROL="ignoreboth"
  # Don't include simple commands in history
  # & supresses duplicate entries
  # ^[ \t]*.+$ supress commands beginning with whitespace (space or tab) followed by * (anything) (this is not a regex)
  # ?:?? - any 1 or 2 char commands including ls, fg, bg, etc..)
  # common commands like "history", "clear", "cls", "exit", "pwd", etc
  export HISTIGNORE="&:^[ \t]*.+$:?:??:clear:cls:exit:pwd:history*:"
  export HISTFILESIZE=5000                    # history file size
fi
