"Rename symbols
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiQuickFix)
autocmd FileType typescript nmap <buffer> <Leader>i <Plug>(TsuquyomiImport)

autocmd FileType typescript setlocal completeopt+=menu
autocmd FileType typescript setlocal completeopt-=preview
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_completion_preview = 0

if has("ballooneval")
  set ballooneval
  autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
else
  autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
endif

let g:tsuquyomi_use_local_typescript = 1
let g:tsuquyomi_disable_quickfix = 1 "Using syntastic instead

let g:tsuquyomi_single_quote_import = 1

let g:tsuquyomi_javascript_support = 1
