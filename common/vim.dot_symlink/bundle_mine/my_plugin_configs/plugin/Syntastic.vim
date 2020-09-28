let g:syntastic_enable_signs=1
let g:syntastic_aggregate_errors = 1

" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list = 2
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" eslintLocal.sh runs eslint in local node_modules and falls back to global install otherwise
let g:syntastic_javascript_eslint_exec = 'eslintLocal.sh'
let g:syntastic_javascript_eslint_args=['--cache'] "only check changed files
" let g:syntastic_javascript_checkers=['xo', 'eslint']
" let g:syntastic_javascript_checkers=['xo']
let g:syntastic_javascript_checkers=['eslint']

" eslintLocal.sh runs eslint in local node_modules and falls back to global install otherwise
let g:syntastic_typescript_eslint_exec = 'eslintLocal.sh'
let g:syntastic_typescript_eslint_args=['--cache'] "only check changed files
let g:syntastic_typescript_checkers = ["tsuquyomi","eslint"] " You shouldn't use 'tsc' checker.
" let g:syntastic_typescript_checkers = ["tsuquyomi", "xo", "eslint"] " You shouldn't use 'tsc' checker.
" let g:syntastic_typescript_checkers = ["tsuquyomi", "xo"] " You shouldn't use 'tsc' checker.

" sassLocal.sh runs node-sass (a wrapper of sassc) in local node_modules and falls back to 
" global install otherwise.
let g:syntastic_sass_sassc_exec = "sassLocal.sh"
let g:syntastic_scss_sassc_exec = "sassLocal.sh"
let g:syntastic_sass_checkers=["sassc"]
let g:syntastic_scss_checkers=["sassc"]

" See https://github.com/Quramy/tsuquyomi#integrate-with-syntastic
let g:tsuquyomi_disable_quickfix = 1
