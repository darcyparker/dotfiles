" call jspretmpl#register_tag('gql', 'graphql')
" autocmd FileType javascript JsPreTmpl html
autocmd FileType javascript JsPreTmpl
autocmd FileType javascript.jsx JsPreTmpl
autocmd FileType typescript JsPreTmpl
" autocmd FileType typescript JsPreTmpl markdown
autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only. Please see #1 for details.
