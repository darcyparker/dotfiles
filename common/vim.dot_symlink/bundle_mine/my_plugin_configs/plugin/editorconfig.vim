if has('python') && !has('win32') && !has('win64') && !has('win16')
  let g:EditorConfig_core_mode="python_builtin"
else
  "Use external python interpreter if vim is NOT compiled with python
  "or windows
  let g:EditorConfig_core_mode="python_external"
endif
