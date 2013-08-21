"Powerline installation instructions:
"------------------------------------
"#Install libgit2
"git clone https://github.com/libgit2/libgit2.git
"cd libgit2
"mkdir build && cd build
"cmake ..
"cmake --build .
"cmake --build . --target install

"#Install pygit2
"git clone git://github.com/libgit2/pygit2.git
"cd pygit2
"export LIBGIT2="/usr/local"
"export LDFLAGS="-Wl,-rpath='$LIBGIT2/lib',--enable-new-dtags $LDFLAGS"
"python setup.py build
"python setup.py install
"python setup.py test

"#Install Mercurial
"sudo apt-get install mercurial

"#Install psutil
"sudo apt-get install python-psutil

"#Install pip
"sudo apt-get install python-pip

"#Finally install powerline
"pip install --user git+git://github.com/Lokaltog/powerline
if has("python") && (isdirectory(expand("~")."/.local/lib/python2.7/site-packages/powerline") || isdirectory("/usr/local/lib/python2.7/site-packages/Powerline-beta-py2.7.egg/powerline"))
  python from powerline.vim import setup as powerline_setup
  python powerline_setup()
  python del powerline_setup

  if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=0
      au InsertLeave * set timeoutlen=1000
    augroup END
  endif

  " Hide the default mode text (e.g. -- INSERT -- below the statusline)
  " Because it is already in powerline status
  set noshowmode

  if &t_Co == 256 || has("gui_running")
    "Powerline options
    let g:Powerline_symbols="fancy"

    " Fix names shownn for each mode. Character 183 works better than the default
    " unicode character
    let g:Powerline_mode_V="V·LINE"
    let g:Powerline_mode_cv="V·BLOCK"
    let g:Powerline_mode_S="S·LINE"
    let g:Powerline_mode_cs="S·BLOCK"
  else
    "Powerline options
    let g:Powerline_symbols="compatible"
  endif
else
  set showmode
endif
