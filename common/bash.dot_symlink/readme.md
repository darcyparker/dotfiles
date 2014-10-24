#Bash files loaded

| ------------------------- | --------------------------- | --------------------------- |
|                           | interactive                 | non-interactive             |
| ------------------------- | --------------------------- | --------------------------- |
| login                     | 1. `/etc/profile`           | 1. `/etc/profile`           |
| * `bash --login`          | 2. `/etc/bash.bashrc`       | 2. First exist/readable of: |
| * remote `ssh` connection |    * > Note this is not     |    * `~/.bash_profile`      |
| * `tmux` window/pane      |      > documented in `man   |    * `~/.bash_login`        |
|                           |      > bash`, but rather    |    * `~/.profile`           |
|                           |      > something I observed |                             |
|                           | 3. First exist/readable of: |                             |
|                           |    * `~/.bash_profile`      |                             |
|                           |    * `~/.bash_login`        |                             |
|                           |    * `~/.profile`           |                             |
| ------------------------- | --------------------------- | --------------------------- |
| non-login                 |  1. `/etc/bashrc.bashrc`    | * Looks at `$BASH_ENV`      |
|  * after logging in       |  2. `~/.bashrc`             |   and if defined, sources   |
|                           |                             |   file it points to         |
| ------------------------- | --------------------------- | --------------------------- |

#Guidelines

## `~/.profile`

* Environment variables

## `~/.bashrc`

* aliases
* bash prompt
* functions

## `~/.bash_profile`

* Make sure things from `~/.profile` and `~/.bashrc` are loaded for login shells
