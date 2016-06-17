" REMEMBER to compile vim with lua support to make unite.vim faster
" See `:h unite-faq`

" Set prefix key for unite
nmap <space> [unite]
nnoremap [unite] <nop>

" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable=1
let g:unite_data_directory = "~/.unite"
let g:unite_winheight = 10
let g:unite_split_rule = "botright"
let g:unite_update_time = 200 " Shorten the default update date of 500ms
let g:unite_source_file_mru_limit = 1000
let g:unite_source_rec_max_cache_files = 99999
let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

" let g:unite_source_rec_async_command = [ 'ag', '-l', '-g', '', '--nocolor' ]

" Always assume I have agprg.sh which uses
" `git grep` if it is a git repo and `ag` otherwise
let g:unite_source_grep_command='agprg.sh'
let g:unite_source_grep_recursive_opt=''

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()

  " See `:h unite_default_key_mappings`
  " ===================================

  " Defaults normal mode
  " ====================
  " Q exit all
  " g? unite help

  " Defaults in insert mode
  " =======================
  " <C-d> delete action
  " <C-e> edit action
  " <C-t> tabopen action
  " <C-y> yank action
  " <C-o> open action

  " Defaults in normal and insert mode:
  " ===================================
  " <C-g> exit

  " Defaults in Normal, Insert and Visual:
  " ======================================
  " <Space>, toggle mark (& move up in normal/insert modes)

  "Navigate up and down
  "When in insert mode, leave and go back to normal mode
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  imap <buffer> <c-k> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)

  "Like i_CTRL-W (delete the word before cursor
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)

  "Quick match action
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)

  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)

  "split actions
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

  " " Using Ctrl-\ to trigger outline, so close it using the same keystroke
  " if unite.buffer_name =~# '^outline'
  "   imap <buffer> <C-\> <Plug>(unite_exit)
  " endif

  " " Using Ctrl-/ to trigger line, close it using same keystroke
  " if unite.buffer_name =~# '^search_file'
  "   imap <buffer> <C-_> <Plug>(unite_exit)
  " endif
endfunction

" General search
nnoremap <silent> [unite]<space> :<C-u>UniteWithProjectDir
      \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>

" Quickly change local directory
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=change-cwd -default-action=cd directory_mru directory_rec/async<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>UniteWithProjectDir -buffer-name=files file_rec/async file/new<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers file_mru buffer<CR>

" Quick grep from ProjectDir
nnoremap <silent> [unite]/ :<C-u>UniteWithProjectDir -buffer-name=grep grep:.<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick command history and commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history -default-action=edit history/command command<CR>

" Quick mappings
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mappings mapping<CR>

" Quick snippets
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets ultisnips<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quick help
nnoremap <silent> [unite]h  :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]gh :<C-u>UniteWithCursorWord -buffer-name=help help<CR>

" Quick line from word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" " Quick outline
" " https://github.com/Shougo/unite-outline
" nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" " Quick sessions (projects)
" " https://github.com/Shougo/unite-session
" nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" ===========
" Unite menus
" ===========
let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.git = {
    \ 'description' : '            Manage git repositories
        \                            ⌘ [unite]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt',
        \'normal ,gt'],
    \['▷ git status       (Fugitive)                                ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff         (Fugitive)                                ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit       (Fugitive)                                ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log          (Fugitive)                                ⌘ ,gl',
        \'exe "silent Glog | Unite quickfix"'],
    \['▷ git blame        (Fugitive)                                ⌘ ,gb',
        \'Gblame'],
    \['▷ git stage        (Fugitive)                                ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout     (Fugitive)                                ⌘ ,go',
        \'Gread'],
    \['▷ git rm           (Fugitive)                                ⌘ ,gr',
        \'Gremove'],
    \['▷ git mv           (Fugitive)                                ⌘ ,gm',
        \'exe "Gmove " input("destination: ")'],
    \['▷ git push         (Fugitive, output buffer)                 ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull         (Fugitive, output buffer)                 ⌘ ,gP',
        \'Git! pull'],
    \['▷ git prompt       (Fugitive, output buffer)                 ⌘ ,gi',
        \'exe "Git! " input("git command: ")'],
    \['▷ git cd           (Fugitive)',
        \'Gcd'],
    \]
nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>

" TODO: unite-outline
" https://github.com/Shougo/unite-outline
" nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" TODO: unite-tag
" https://github.com/Shougo/unite-help

" nnoremap <silent> [unite]s
"         \ :<C-u>Unite -buffer-name=files -no-split
"         \ jump_point file_point buffer_tab
"         \ file_rec:! file file/new<CR>

"Other grep tools to investigate
" Use hw (highway) https://github.com/tkengo/highway
" Use pt (the platinum searcher) https://github.com/monochromegane/the_platinum_searcher
" Use jvgrep https://github.com/mattn/jvgrep
