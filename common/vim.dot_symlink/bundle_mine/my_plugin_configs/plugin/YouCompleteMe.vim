if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_filetype_blacklist={'unite': 1}
" let g:ycm_tsserver_binary_path=substitute(system("npm bin") . "/tsc", '\n', '', 'g')
