"Open markdown files in Chrome. Assumes Markdown Preview Extension is
"installed
"See https://chrome.google.com/webstore/detail/markdown-preview/jmchmkecamhbiokiopfpnfgbidieafmd
"To do: Rewrite this to be more general. Shouldn't hardcode path.
noremap <F12> :!start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %:p<CR>
