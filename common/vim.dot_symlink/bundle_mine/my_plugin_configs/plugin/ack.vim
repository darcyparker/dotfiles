if executable('ag')
  "Use ag for Ack plugin
  let g:ackprg = 'ag --nogroup --column'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
else
  let g:ackprg = 'ack -H --nocolor --nogroup --column --smart-case --follow'
endif
