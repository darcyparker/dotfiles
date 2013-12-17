if executable('ag')
  "Use ag for Ack plugin
  let g:ackprg = 'ag --nogroup --column'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
