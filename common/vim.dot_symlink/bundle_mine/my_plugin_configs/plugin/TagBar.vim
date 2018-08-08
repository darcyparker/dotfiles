"Tagbar settings
nnoremap <leader>tb :TagbarToggle<CR>

" See https://github.com/majutsushi/tagbar/wiki#markdown
" Uses https://github.com/jszakmeister/markdown2ctags
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" CoffeeScript configuration comes from CoffeeTags vim plugin

"https://github.com/majutsushi/tagbar/wiki#css
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

" https://github.com/majutsushi/tagbar/wiki#typescript
" Using .ctags (not as good as tstags)
" let g:tagbar_type_typescript = {
"   \ 'ctagstype': 'typescript',
"   \ 'kinds': [
"     \ 'c:classes',
"     \ 'n:modules',
"     \ 'f:functions',
"     \ 'v:variables',
"     \ 'v:varlambdas',
"     \ 'm:members',
"     \ 'i:interfaces',
"     \ 'I:imports',
"     \ 't:types',
"     \ 'e:enums',
"   \ ]
" \ }
" Using tstags to get tstags
" Install tstags from https://github.com/Perlence/tstags
" npm install --global git+https://github.com/Perlence/tstags.git
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }

" https://github.com/majutsushi/tagbar/wiki#ultisnips
let g:tagbar_type_snippets = {
    \ 'ctagstype' : 'snippets',
    \ 'kinds' : [
        \ 's:snippets',
    \ ]
\ }

" https://github.com/majutsushi/tagbar/wiki#rust
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

" https://github.com/majutsushi/tagbar/wiki#makefile-targets
let g:tagbar_type_make = {
            \ 'kinds':[
                \ 'm:macros',
                \ 't:targets'
            \ ]
\}

let g:tagbar_type_xslt = {
\ 'ctagstype' : 'xslt',
\ 'ctagsbin'  : '/home/darcy/src/xsltctags/xsltctags',
\ 'ctagsargs' : '-f - -p xsltproc ',
\ 'sort' : 0,
\ 'kinds'     : [
\ 'S:Stylesheet',
\ 'r:Result Documents',
\ 'd:Saxon Doctypes',
\ 'i:Includes',
\ 'o:Imports',
\ 'p:Parameters',
\ 'v:Variables',
\ 'x:Saxon Assigns',
\ 'k:Keys',
\ 't:Attribute Sets',
\ 'h:Character Maps',
\ 's:Name Spaces',
\ 'e:Elements',
\ 'b:Attributes',
\ 'n:Named Templates',
\ 'm:Matched Templates',
\ 'f:Functions',
\ 'a:Applied Templates',
\ 'j:Applied Imports',
\ 'c:Called Templates',
\ 'l:Saxon Called Templates',
\ 'g:Processing Instructions'
\ ],
\ 'sro': '////',
\ 'kind2scope' : {
\ 'S' : 'stylesheet',
\ 'r' : 'resultDocument',
\ 'd' : 'saxonDocType',
\ 'i' : 'include',
\ 'o' : 'import',
\ 'p' : 'parameter',
\ 'v' : 'variable',
\ 'x' : 'saxonAssign',
\ 'k' : 'key',
\ 't' : 'attributeSet',
\ 'h' : 'characterMap',
\ 's' : 'nameSpace',
\ 'e' : 'element',
\ 'b' : 'attribute',
\ 'n' : 'namedTemplate',
\ 'm' : 'matchedTemplate',
\ 'f' : 'function',
\ 'a' : 'appliedTemplate',
\ 'j' : 'appliedImport',
\ 'c' : 'calledTemplate',
\ 'l' : 'saxonCalledTemplate',
\ 'g' : 'processingInstruction'
\ },
\ 'scope2kind' : {
\ 'stylesheet' : 'S',
\ 'resultDocument' : 'r',
\ 'saxonDocType' : 'd',
\ 'include' : 'i',
\ 'import' : 'o',
\ 'parameter' : 'p',
\ 'variable' : 'v',
\ 'saxonAssign' : 'x',
\ 'key' : 'k',
\ 'attributeSet' : 't',
\ 'characterMap' : 'h',
\ 'nameSpace' : 's',
\ 'element' : 'e',
\ 'attribute' : 'b',
\ 'namedTemplate' : 'n',
\ 'matchedTemplate' : 'm',
\ 'function' : 'f',
\ 'appliedTemplate' : 'a',
\ 'appliedImport' : 'j',
\ 'calledTemplate' : 'c',
\ 'saxonCalledTemplate' : 'l',
\ 'processingInstruction' : 'g'
\}
\}
