" Note OS X terminal.app requires MouseTerm
" See https://bitheap.org/mouseterm/
set mouse=a " Use the mouse in all modes
if !has("win32") && !has('nvim')
  set ttymouse=xterm2 " mouse behaviour
endif
