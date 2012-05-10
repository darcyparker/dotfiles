"Note: ConqueTerm on gui_win32 requires win32 version of python. If win64
"version of python is installed and in path, must explicitly point to the
"win32 version of python.exe
"if has("gui_win32")
  "let g:ConqueTerm_PyExe='d:\opt\Python27\python.exe'
"endif

let g:ConqueTerm_CloseOnEnd = 1 " close ConqueTerm buffer and delete it 
                                " when the program inside it exits
                                " if you don't set this, then you have to 
                                " manually :bw to wipe the buffer
let g:ConqueTerm_ReadUnfocused = 1 " Necessary if you want dynamic updates 
                                   " when you move to a new window
let g:ConqueTerm_ExecFileKey = '<F11>'
let g:ConqueTerm_SendFileKey = '<F10>'
let g:ConqueTerm_SendVisKey = '<F9>'
