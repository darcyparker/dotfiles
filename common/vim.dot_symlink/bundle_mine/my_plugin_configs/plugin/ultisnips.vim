if has("python")
  let g:UltiSnipsUsePythonVersion = 2
elseif has("python3")
  let g:UltiSnipsUsePythonVersion = 3
endif
if has("python") || has('python3')
  let g:UltiSnipsExpandTrigger = "<c-l>"
  let g:UltiSnipsListSnippets="<c-h>"
  let g:UltiSnipsJumpForwardTrigger = "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

  "Only load myUltiSnips
  " let g:UltiSnipsSnippetDirectories=["myUltiSnips"]
endif
