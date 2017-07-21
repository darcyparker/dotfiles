"Rename symbols
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)

" tooltip
if has("ballooneval")
  set ballooneval
  autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
  autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
endif

let g:tsuquyomi_use_local_typescript = 1
