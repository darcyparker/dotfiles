"See http://vimcasts.org/episodes/tidying-whitespace/
"Preserves/Saves the state, executes a command, and returns to the saved state
function! s:Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

"js-beautify of whole file from normal mode
autocmd FileType javascript,json nnoremap <buffer>  <leader>b :call <SID>Preserve("execute \"%!js-beautify -s 2 -f -\"")<cr>
"js-beautify of visual selection only
autocmd FileType javascript,json vnoremap <buffer>  <leader>b :call <SID>Preserve("execute \"silent '<,'>!js-beautify -s 2 -f -\"")<cr>

" for html
autocmd FileType html noremap <buffer> <leader>b :call <SID>Preserve('call HtmlBeautify()')<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>b :call <SID>Preserve('call CSSBeautify()')<cr>
