"Rename symbols
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiQuickFix)
autocmd FileType typescript nmap <buffer> <Leader>i <Plug>(TsuquyomiImport)
autocmd FileType typescript setlocal completeopt+=menu
autocmd FileType typescript setlocal completeopt-=preview

autocmd FileType javascript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType javascript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType javascript nmap <buffer> <Leader>f <Plug>(TsuquyomiQuickFix)
autocmd FileType javascript nmap <buffer> <Leader>i <Plug>(TsuquyomiImport)
autocmd FileType javascript setlocal completeopt+=menu
autocmd FileType javascript setlocal completeopt-=preview

let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_completion_preview = 0

if has("ballooneval")
  set ballooneval
  autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
  autocmd FileType javascript setlocal balloonexpr=tsuquyomi#balloonexpr()
else
  autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
  autocmd FileType javascript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
endif

"First serach the rood directory (with package.json) then search node_modules for 
"typescript/bin/tsserver.js
let g:tsuquyomi_use_local_typescript = 1
"Then use global installed tsserver command
let g:tsuquyomi_use_dev_node_module = 0

let g:tsuquyomi_disable_quickfix = 1 "Using syntastic instead

let g:tsuquyomi_single_quote_import = 1

let g:tsuquyomi_javascript_support = 1
