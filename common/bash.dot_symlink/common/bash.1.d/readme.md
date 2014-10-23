#Notes about `~/.bash/common/bash.1.d`

* `256color.sh`

   `$TERM` must be set before `tmux` is started

   This script corrects the initialization of $TERM for many
   terminals such as gnome_terminal.

  `$TERM` must be `xterm-256color` when:
     1. `tmux` is started *AND*
     2. `tmux` sets its term to `screen-256color.`

  > `$TERM==screen-256color` doesn't work correctly under
  > when the parent terminal has `$TERM==xterm`.

* `setLang.sh`

  `$LANG` must be set correctly before starting `tmux`
  `en_US.UTF-8` or another *UTF-8* locale is best

  In Debian `apt-get install locales debconf; dpkg-reconfigure locales`

  Check locales available with `locale -a`

