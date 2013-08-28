if has("python")
  let g:UltiSnipsExpandTrigger="<tab>"
  "Note, by default, most terminals don't pass c-tab
  "So the terminal must be configured to pass c-tab
  let g:UltiSnipsListSnippets="<c-tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  "Only load myUltiSnips
  let g:UltiSnipsSnippetDirectories=["myUltiSnips"]
endif
