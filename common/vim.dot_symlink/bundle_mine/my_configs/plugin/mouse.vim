" Note OS X terminal.app requires MouseTerm
" See https://bitheap.org/mouseterm/
set mouse=a " Use the mouse in all modes
if !has("win32")
  set ttymouse=xterm " mouse behaviour
endif
