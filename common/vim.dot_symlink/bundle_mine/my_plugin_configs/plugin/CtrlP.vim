let g:ctrlp_cmd = 'CtrlPBuffer'

"Local working directory is:
"0 - don’t manage working directory.
"1 - the parent directory of the current file.
"2 - the nearest ancestor that contains one of these directories or files:
"    .git/ .hg/ .svn/ .bzr/ _darcs/ or your own marker_dir/ marker_file
let g:ctrlp_working_path_mode = 2

"Switch to buffer if it exists when opening a file
"1 - only jump to the buffer if it's opened in the current tab.
"2 - jump tab as well if the buffer's opened in another tab.
"0 - disable this feature.
let g:ctrlp_switch_buffer = 2

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }

if has("win16") || has("win32") || has("win64")
  "Be careful about setting wildignore.  See :h ctrlp-wildignore
  "set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*  " Windows ('noshellslash')
  let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
"  let g:ctrlp_user_command = {
        "\ 'types': {
        "\ 1: ['.git/', 'cd %s && git ls-files'],
        "\ 2: ['.hg/', 'hg --cwd %s locate -I .'],
        "\ },
        "\ 'fallback': 'dir %s /-n /b /s /a-d'
        "\ }
else
  "Be careful about setting wildignore.  See :h ctrlp-wildignore
  "set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
  let g:ctrlp_user_command = 'find %s -type f'
  "let g:ctrlp_user_command = {
        "\ 'types': {
        "\ 1: ['.git/', 'cd %s && git ls-files'],
        "\ 2: ['.hg/', 'hg --cwd %s locate -I .'],
        "\ },
        "\ 'fallback': 'find %s -type f'
        "\ }
endif
