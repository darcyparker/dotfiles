"For javascript files, tagbar should be paused... jsctags sometimes doesn't generate tags on the
"fly properly... either crashes or stalls
if exists('g:loaded_tagbar')
  call tagbar#PauseAutocommands()
endif
