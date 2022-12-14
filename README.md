# Darcy Parker's dotfiles

## Dependencies

* [rcm: management suite for dotfiles](https://github.com/thoughtbot/rcm#rcm)
  * See [rcm#installation](https://github.com/thoughtbot/rcm#installation)
  * See [Blog post introducing rcm](https://thoughtbot.com/blog/rcm-for-rc-files-in-dotfiles-repos)

## Setup/Install

```bash
./setup
```

## Additional notes for Windows 10

1. Set environment variables:

   ```
   setx HOME %USERPROFILE%
   setx XDG_CONFIG_HOME "%USERPROFILE%\.config"
   ```
2. When installing [git scm](https://git-scm.com/) be sure to check the *'Enable symbolic links'* option.

3. When cloning [this repo](https://github.com/darcyparker/dotfiles):

   `git clone -c core.symlinks=true git@github.com:darcyparker/dotfiles.git`

   > If you don't have the [privilege to create symbolic links](https://github.com/git-for-windows/git/wiki/Symbolic-Links#allowing-non-administrators-to-create-symbolic-links)
   > then you will need to run `cmd.exe`, `powershell` or `bash` as `administrator` so that symbolic links
   > are created when cloning.

4. **Recommended:**

   If you don't have [privilege to create symbolic links](https://github.com/git-for-windows/git/wiki/Symbolic-Links#allowing-non-administrators-to-create-symbolic-links),
   using [cygwin](https://www.cygwin.com/) to run [`setup.sh`](./setup.sh) is recommended because
   it will use `cygstart` to call `mklink` as administrator for each link that needs to be created.

### Additional notes for `cygwin`

Setup `cygwin` to mount `/home` to `$USERPROFILE`:

```bash
mount -f "$USERPROFILE" ~
mount -m > /etc/fstab
```

### Additional notes for `MSYS2` on windows

Installer: https://msys2.github.io/
See https://sourceforge.net/projects/msys2/

See: http://stackoverflow.com/questions/24099179/msys2-does-not-source-profile/26554978#26554978

`/etc/fstab` needs to be edited in order for `~/.bash_profile` to be sourced
after `~/etc/profile`.

Example:
```
$ cat /etc/fstab
# For a description of the file format, see the Users Guide
# http://cygwin.com/cygwin-ug-net/using.html#mount-table

# DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
none / cygdrive binary,posix=0,noacl,user 0 0

d:/Users/dparker /home/dparker ntfs binary,posix=0,user 0 0
```
### On older windows machines (prior to Windows 10)

Run `setup.bat` as administrator (because `mklink.exe` is needed to create
symbolic links to `_vimrc`, `.vim`, and `.config/nvim`.

