if exists('g:powerline_loaded')

  if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=0
      au InsertLeave * set timeoutlen=1000
    augroup END
  endif

  " Hide the default mode text (e.g. -- INSERT -- below the statusline)
  " Because it is already in powerline status
  set noshowmode

  if &t_Co == 256 || has("gui_running")
    "Powerline options
    let g:Powerline_symbols="fancy"

    " Fix names shownn for each mode. Character 183 works better than the default
    " unicode character
    let g:Powerline_mode_V="V·LINE"
    let g:Powerline_mode_cv="V·BLOCK"
    let g:Powerline_mode_S="S·LINE"
    let g:Powerline_mode_cs="S·BLOCK"
  else
    "Powerline options
    let g:Powerline_symbols="compatible"
  endif
endif
