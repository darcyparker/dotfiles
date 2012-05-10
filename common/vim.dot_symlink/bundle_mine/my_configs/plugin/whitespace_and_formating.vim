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
"strip all trailing white space
nnoremap <silent> <leader>ws  :call <SID>Preserve("%s/\\s\\+$//e")<CR>
"reformat the indentation of the whole file
nnoremap <silent> <leader>= :call <SID>Preserve("normal gg=G")<CR>
