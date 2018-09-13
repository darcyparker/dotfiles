"use roy syntax file when *.roy is open
autocmd BufNewFile,BufRead *.roy set filetype=roy

autocmd BufNewFile,BufRead .jshintrc,.jsbeautifyrc set filetype=json

autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" web.config file is xml filetype
autocmd BufNewFile,BufRead * if expand('%:t') == 'web.config' | set filetype=xml | endif

" files ending in .html.template are html too
autocmd BufNewFile,BufRead * if match(expand('%:t'), '\.html\.template$') > -1 | set filetype=html | endif
