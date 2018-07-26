" let g:indentLine_fileType=['javascript', 'html', 'css', 'scss', 'typescript']
let g:indentLine_fileTypeExclude=['help', 'nerdtree']
let g:indentLine_enabled=0 "off by default

let g:indentLine_color_term=239
let g:indentLine_color_gui='#A4E57E'
let g:indentLine_char='┊'

nnoremap <Leader>ig :IndentLinesToggle<CR>
