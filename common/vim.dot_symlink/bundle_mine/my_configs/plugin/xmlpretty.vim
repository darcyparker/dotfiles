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

"`xmllint --format` whole file from normal mode
autocmd FileType xml,xslt,svg,graphml,xhtml nnoremap <buffer>  <leader>b :call <SID>Preserve("execute \"%!xmllint --format -\"")<cr>
