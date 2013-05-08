# Darcy Parker's dotfiles

_Note: This is a work in progress.  My dotfiles are in flux right now and I intend to document
my configurations in more detail._

## Setup/Install

> My vim configuration is included.

### Notes on installing vim

* Windows: [gVim](http://www.vim.org/download.php#pc)
    * I install vim using [gvim73_46 on
      vim.org](http://www.vim.org/download.php#pc) because it installs all
      required files and integrates with windows explorer
        * Note: ootb, vim.exe does not have python support. (gvim.exe does
          but vim.exe doesn't).
        * I replace the `gvim.exe` and `vim.exe` with newer builds from
          [Yongwei](http://wyw.dcweb.cn/#download)
        * For python to work in vim, both vim and python must be built with
          the same target and the same compiler.
            * Nearly all python distributions are built with the MS compiler
              and in the python community many extensions are built with MS
              compiler.  So this constrains most vim installations to those
              built with MS Compiler.
            * Remember that if gvim.exe and vim.exe are 32 builds from MS
              compiler remember to install 32 bit python that was built with MS
              compiler. (I use chocolatey `cinst python.x86`)
            * Some gvim.exe and vim.exe are built with mingw (with 32 bit
              target) or mingw-w64 (target either 32bit or 64bit).  This is
              normally fine, but today it is rare to find a python installation
              that was built with these compilers. So stick with vim built
              against MS compiler.
    * Under cygwin, I build a custom vim

        ``` bash
        hg clone https://vim.googlecode.com/hg/ vim
        ./configure --enable-rubyinterp --enable-perlinterp --enable-pythoninterp --enable-gui=no --enable-multibyte --with-features=huge
        make
        make install
        ```

* Mac (OS X): I recommend installing via
  [Homebrew](http://mxcl.github.com/homebrew/)
    * `brew install macvim --override-system-vim`

2.  As well, you should have the various software required by vim plugins.

The following sections provide installation steps based on the OS type.

### Installation Unix type OSes
1. Run the `setup.sh` script
2. Finally install/update the vim bundles by running `$HOME\.vim\updateBundles.sh`

### Installation on Windows
1. Set `%HOME%` environment variable to `%USERPROFILE%`
    * Example: `setx HOME %USERPROFILE%`
2. As administrator, run `setup.bat`
    * Note this must be executed as adminstrator because it uses mklink.exe to link
      the `_vimrc` and `.vim` folder
3. Also install consolas for powerline font
    * https://github.com/eugeneching/consolas-powerline-vim
4. Finally install/update the vim bundles by running `%HOME%\.vim\updateBundles.bat`

### Installation on Windows with Cygwin
1. Set `%HOME%` environment variable to the path of your cygwin user's home directory
    *  Example: `setx HOME d:\cygwin\home\dparker`
2. As administrator, run `setup.bat`
    *  Note this must be executed as adminstrator because it uses `mklink.exe` to link
       the `_vimrc` and `.vim` folder to their source content in `my_dotfiles` repository.
3. Then as **adminstrator** run the `setup.sh` script from inside a cygwin bash shell.
4. Finally install/update the vim bundles by running `$HOME\.vim\updateBundles.sh`

### Notes about setup scripts:
* The setup scripts (`setup.bat` and `setup.sh`) create links or copy files from your
  clone of my dot files repo to applicable locations.

### Notes about prerequesite software required by vim plugins
* Install procedure will be different depending on OS.
    * `tidy` (HTMLTidy) _required to check html with syntastic in vim_
    * `node` and `npm`
        * After installing npm, I recommend installing these:
            * `npm install -g jslint`  _used to check javascript with syntastic_
            * `npm install -g jsonlint`  _required to check json with syntastic_
            * `npm install -g csslint`  _required to check css with syntastic_
            * `npm install -g jshint`  _An alternative for checking javascript with syntastic_
            * `npm install -g uglify-js`  _I find_ `uglify -b` _to be useful ! filter command in
              vim_
        * After installing `node`, install `jsdoctor`.
           * `jsdoctor` also known as (`jsctags`) is a better ctags for javascript because it
              understands javascript patterns such as the module pattern.
           * It works well with vim's tagbar.
           * Unfortunately it doesn't have an npm module. But the latest `makefile` will install it
             on unix systems.
           * On windows, see notes below.
    * `perl` and CPAN module for `ack`  (required for ack.vim)
    * Special notes for *windows* _(does not apply to unix-like systems)_:
        * Hopefully obvious, but make sure commands installed are in your `%PATH%` so they can be
          found by vim plugins.
            * The npm commands will be in `%APPDATA%/npm` which is then added to
              your `%PATH%` by the nodejs installation, but you will have to make sure
              `tidy.exe`, etc... is in a folder that's in your `%PATH%`.
        * For node and npm, I find the windows installer works best today. Ignore obsolete
          instructions about installing under cygwin. And ignore manual instructions involving the
          creation of environment variables and making folders etc... The latest windows installer
          works best now.
        * To install `jsdoctor` (`jsctags`) on windows,
            * See my [gist](https://gist.github.com/1438882) for tips about installing jsdoctor on
              windows.
            * Unfortunately there is not an npm package for `jsctags`. The `makefile` works nice
              for installing on unix systems, but for windows, I found I needed the workaround
              described in my gist.
        * Don't forget to install windows distribution of `git` which is required for fugitive.vim
          on gvim win32.

## Background of my objectives

Understanding some of my objectives may help explain why I have configured things the way I did.

* The usual objectives around having a single repository of configuration files for various
  unixy type software that I use.  I want to be able to make changes in one environment, commit
  the changes and then share them with other repositories via git pull/push.
* Support different OS environments
    * Windows
    * Cygwin on Windows
    * Different flavours of unix that I use
        * OS X
        * linux on different devices I use
* Support different flavours of vim
    * vim
    * gvim win32
    * gvim xwindows
    * macvim
* Support vim in different terminals
    * mintty on cygwin/windows
    * iterm2 (os x)
    * terminal (os x)
    * tmux (running in various terminals)
    * screen (running in various terminals)
    * putty

## File and Folder Naming

To do
