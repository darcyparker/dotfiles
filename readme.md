# Darcy Parker's dotfiles

_Note: This is a work in progress.  My dotfiles are in flux right now and I intend to document
my configurations in more detail._

I am sharing these on github as a way to backup my configurations and to have a central repository
to sync my configurations with.  It's also a good way to share my configurations with others so
they can learn.  And a way to maybe get feedback from others.  I always enjoy looking at other
people's dotfiles, and hope others will appreciate mine.

As most people advise:

* I don't recommend using these files verbatim.
* Instead, have a look at both my configurations and others. Then feel free to reuse what you
  like from mine and personalize your dot files to your own tastes.
* I also recommend trying out only a few things at a time.  Create a very simple set of
  configurations for yourself and try inserting a new set of configurations in a bit at a
  time so that you can experiment with and learn what they do.

## Setup/Install

1. Use the `setup.sh` script to install these dotfiles into your environment
   * Notes about `setup.sh`:
     * The `dot.*` files and folders will be symbolically linked to your `~` home folder
       if the files do not exist. Note: `setup.sh` should not overwrite anything that exists already.
     * The `template.*` files are used as templates to create the applicable file in your `~` folder.
       These files are intended to be edited by you. But because they are not linked to the repository,
       you won't be tracking changes to them.
       * I intend the `template.*` files to be boiler plate files to get started with.
         * Some of the files, like the `template.vimrc` file, are never intended to be edited after
           being copied to `.vimrc` and `_vimrc`. (Note, the reason it is `template.vimrc` and
           not `dot.vimrc` is explained below. But in short, it's because gvim win32 can't read
           symbolic links to `dot.vimrc`.  So I create explicit copies of `template.vimrc`)
         * Others like `template.gitconfig` will be updated with your personal information that
           shouldn't be tracked in a public repository. (ie github token and passwords...)
     * My `setup.sh` was inspired by a number of other scripts for setting up dotfiles including:
       * https://github.com/Lokaltog/sync
       * others... but I don't have my notes handy. Will udpate later.
     * My `setup.sh` works well for me, for now... but I fully intend to simplify some of it.
2. On windows machines, the configuration assumes
   * Environment variable `%HOME%` is set
     * This defines where to find `_vimrc` on windows
     * If using cygwin, I recommend using the same `$HOME` for cygwin as you do for `%HOME%`
       in your windows environment variables
3. Remember to init/update each submodule
   * git submodule init
   * git submodule update
4. And in the future to get the latest commits from other submodule authors:
   * git submodule foreach --recursive git pull

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

### Some challenges with these objectives

The following list highlights some of the issues I have encountered.

* I observed a common pattern people use is to keep their dotfiles in a
  seperate folder/repository and then symbolic link the files into the
  desired location.
  * On windows you can use cygwin to create symbolic links.  But windows
    applications such as gvim win32 do not recognize cygwin's conventions for
    symbolic links. So for configurations related to vim, I could not use symbolic
    links.
    * To use the same repository folder for gvim win32, and vim inside a mintty cygwin
      terminal and other OSes without changing the vim configuration files, I created
      a boiler plate `.vimrc` and `_vimrc` file that figures out
      1. Where my vim files are and loads my real `vimrc`.
      2. Creates a global environment variable that points to the vim folder in
         case I need to access it in my `vimrc`.
    * My intent is to _never_ edit the `.vimrc` or `_vimrc` files.
    * All of my edits will go in the `vimrc` file in the root of my `dot.vim` folder.
    * These boilerplate `.vimrc` and `_vimrc` files are created by copying `template.vimrc`.
    * This solution seems to work well for me. But I am interested in hearing how others have
      dealt with managing dot files across different environments where `ln -s` is not supported
      in some of the environments.
  * I am aware of `cyg-wrapper.sh` for cygwin.  It works great for resolving and transforming
    paths composed with symbolic links before passing them to a windows application. But once
    you're in a windows application like gvim win32, you can't continue to resolve/transform the
    paths with symbolic links if you didn't pass them in as arguments to cyg-wrapper.sh... so
    configuration files like a `vimrc` that point to folders with symbolic links don't work. This
    was painful for `&rtp` in vim for example... All vim configurations need to be in folders and
    or files that can be recognized in windows and unix flavours like cygwin.

## File and Folder Naming

* By convention, in `my_dotfiles` repository, I name all folders and filenames that begin with
  `.` using a `dot.` prefix.
  * I first saw, liked and borrowed this convention from https://github.com/Lokaltog/sync
  * The value of using this prefix is because by convention `.*` are hidden files in unix.
    Since the focus of this repository is for managing my standard configuration files,
    I don't like them to be hidden.
  * All `dot.*` files and folders are linked to a new `.*` name. For example: `dot.bashrc` is linked
    to `~\.bashrc` on unix platforms where `ln -s` is supported
* Some files are not intended to be linked with `ln -s`, so to differentiate these from `dot.` files
  and folders, I prefix these files with `template.`
  * Examples:
    * `template.gitconfig` has many of my ~/.gitconfig settings, but not settings that are
      private. (ie my github token).
    * `template.vimrc` is used to create `.vimrc` for unix-like platforms and `_vimrc` for gvim
       win32 and vim under cmd.exe or dos.
* `home_bin` is where I store shell scripts and binaries that I want to put in `~/bin`
  * Note, some shell scripts and binaries are OS specific.  By convention I store these in folders
    for each OS environment. The `setup.sh` used for installation takes care of only linking the
    appropriate scripts and binaries for the OS environment.
    * Examples:
      * `home_bin` is for scripts that apply to all platforms
      * `home_bin/cygwin` is for scripts and binaries that only apply to cygwin
      * `home_bin/darwin` is for scripts and binaries that only apply to OS X
* `dot.bash` folder contains multiple files that are used to compose my `bashrc` configuration on
  the fly.
  * `dot.bashrc` which will be linked to `~/.bashrc` simply sources `dot.bashrc/bashrc`
  * `bashrc` loads these files in the order listed:
    * `bash_prompt` which configures my bash prompt
    * `bash_common` which defines all settings that are common across all bash environments
    * Environment specific bash file (only one of these is actually sourced.)
      * `bash_cygwin` cygwin specific bash settings
      * `bash_darwin` mac os x specific bash settings
      * `bash_linux` linux specific bash settings
      * other platform specific files can be created as needed
  * Note: `pathed_cd` is a cool/useful for remembering the folder you were last in... but it caused
    me some problems.  When I have time, I will try to put it in a more clever/intelligent way.
  * Note: `saveMYIP` was a simple script to record my IP.  I am thinking about using this to have my
    computer call home and record it's current IP each time bash runs so that if my computer is ever
    stolen, I will know where to ssh to...
  * The final commands in my `bashrc` puts `~/bin` and `/usr/local/bin` in the front of my `$PATH`
    * If I install software to `/usr/local` and an executable is in both `/usr/local/bin` and other
      paths in my `$PATH`, then I want my `/usr/local/bin` commands to take precedence.  By putting
      moving these folders to the front, they take precedence. First found wins.)
    * Similarly I want `~/bin` files to take precedence.
