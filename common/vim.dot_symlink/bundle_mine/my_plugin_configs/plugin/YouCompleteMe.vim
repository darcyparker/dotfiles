if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['javascript'] = ['.']
let g:ycm_filetype_blacklist={'unite': 1}
" let g:ycm_tsserver_binary_path=substitute(system("npm bin") . "/tsc", '\n', '', 'g')

" Use homebrew's clangd
if has('macunix')
  let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
endif

let g:ycm_global_ycm_extra_conf='~/.vim/bundle_python_github/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_python_binary_path='/usr/local/bin/python3'
