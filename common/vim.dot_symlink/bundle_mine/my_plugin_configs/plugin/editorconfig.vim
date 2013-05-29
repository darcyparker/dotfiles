if has('python')
  let g:EditorConfig_core_mode="python_builtin"
else
  "Use external python interpreter if vim is not compiled with python
  "Of course this assumes python is installed, but vim doesn't have python
  "support... This is probably rare.
  let g:EditorConfig_core_mode="python_external"
endif
