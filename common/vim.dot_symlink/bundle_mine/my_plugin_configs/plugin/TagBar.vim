"Tagbar settings
nnoremap <leader>tb :TagbarToggle<CR>

let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }

let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

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
