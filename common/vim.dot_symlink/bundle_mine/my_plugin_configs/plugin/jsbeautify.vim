"See examples: https://github.com/maksimr/vim-jsbeautify#usage
"normal mode maps for different filetypes
autocmd FileType javascript noremap <buffer> <leader>b :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>b :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <leader>b :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>b :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>b :call CSSBeautify()<cr>

"visual mode maps
autocmd FileType javascript vnoremap <buffer> <leader>b :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <leader>b :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <leader>b :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>b :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>b :call RangeCSSBeautify()<cr>
