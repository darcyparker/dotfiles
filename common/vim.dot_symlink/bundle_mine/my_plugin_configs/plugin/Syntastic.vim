let g:syntastic_enable_signs=1
let g:syntastic_aggregate_errors = 1

let g:syntastic_check_on_wq=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_javascript_checkers=["jshint","eslint"]
let g:syntastic_typescript_checkers = ["tsuquyomi","tslint"] " You shouldn't use 'tsc' checker.

let g:syntastic_sass_checkers=["sassc"]
let g:syntastic_scss_checkers=["sassc"]

" See https://github.com/Quramy/tsuquyomi#integrate-with-syntastic
let g:tsuquyomi_disable_quickfix = 1
