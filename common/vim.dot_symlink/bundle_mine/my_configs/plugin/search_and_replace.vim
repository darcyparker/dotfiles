" searching/matching options
set ignorecase " Ignore case when searching
set smartcase  " Smart-case search mode
"set gdefault   " Applies subsitutions globally on lines
               " instead of :%s/foo/bar/g you just type :%s/foo/bar/
if &t_Co > 2 || has("gui_running")
 set hlsearch " Highlight matching search result

 " map to toggle highlight of matching search result
 nnoremap <silent> <leader><space> :set hlsearch!<cr>
 "nnoremap <silent> <leader><space> :noh<cr>
 "nnoremap <silent> <esc> :noh<return><esc>

 set incsearch  " Start to search as typing starts
endif

"clear the last search pattern
nnoremap <silent> <leader>/ :let @/ = ""<cr>

" Search and replace word under cursor (,;)
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <leader>srw :%s/\<<C-r><C-w>\>//<Left>
" Search and replace all. Type "pattern/replace" after mapkey.
nnoremap <Leader>sra :%s//<Left>
" Search and replace inside visual selection. Type "pattern/replace" after mapkey.
vnoremap <Leader>sra :s//<Left>
" Search and replace with confirm. (normal and visual modes)  Type "pattern/replace" after mapkey.
nnoremap <Leader>src :%s//c<Left><Left>
vnoremap <Leader>src :s//c<Left><Left>

" search for the visually selected text
vnoremap g/ y/<C-R>"<CR>

" See
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
" The first two lines fix Vim's horribly broken default regex handling
" by automatically inserting a \v before any string you search for. This
" turns off Vim's crazy default regex characters and makes searches use
" normal regexes.
nnoremap / /\v
vnoremap / /\v

" tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

"`<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
" Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
" work.
cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'


" An alternative to <c-r>{register_char} that escapse the content it pastes
" <c-x>{register_char} - paste register into search field, escaping sensitive chars
" http://stackoverflow.com/questions/7400743/
cnoremap <c-x> <c-r>=<SID>PasteEscaped()<cr>
function! s:PasteEscaped()
  echo "\\".getcmdline()."\""
  let char = getchar()
  if char == "\<esc>"
    return ''
  else
    let register_content = getreg(nr2char(char))
    let escaped_register = escape(register_content, '\'.getcmdtype())
    let escaped_register2 = substitute(escaped_register,'[','\\[','g')
    let escaped_register3 = substitute(escaped_register2,']','\\]','g')
    return substitute(escaped_register3, '\n', '\\n', 'g')
  endif
endfunction

