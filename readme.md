# Darcy Parker's dotfiles

_Note: This is a work in progress.  My dotfiles are in flux right now and I intend to document
my configurations in more detail._

## To do
env on windows:
cygwin=ntsec codepage:oem tty binmode title nodosfilewarning

## Setup/Install

These instructions assume:
1. You have vim installed already.
    * Windows: [gVim](http://www.vim.org/download.php#pc)
    * Mac (OS X): I recommend installing via [Homebrew](http://mxcl.github.com/homebrew/)
        * brew install macvim --override-system-vim

2.  As well, you should have the various software required by vim plugins.

The following sections provide installation steps based on the OS type.

### Installation Unix type OSes
1. Run the `setup.sh` script

### Installation on Windows
1. Set `%HOME%` environment variable to `%USERPROFILE%`
    * Example: `setx HOME %USERPROFILE%`
2. As administrator, run `setup.bat`
    * Note this must be executed as adminstrator because it uses mklink.exe to link
      the `_vimrc` and `.vim` folder

### Installation on Windows with Cygwin
1. Set `%HOME%` environment variable to the path of your cygwin user's home directory
    *  Example: `setx HOME d:\cygwin\home\dparker`
2. As administrator, run `setup.bat`
    *  Note this must be executed as adminstrator because it uses `mklink.exe` to link
       the `_vimrc` and `.vim` folder to their source content in `my_dotfiles` repository.
3. Then run the `setup.sh` script from inside a cygwin bash shell.

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
