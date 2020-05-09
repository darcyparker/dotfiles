# Darcy Parker's dotfiles

## Setup/Install

1. Run the [`setup.sh`](./setup.sh) script

## Additional notes for Windows 10

1. Set environment variables:

   ```
   setx HOME %USERPROFILE%
   setx XDG_CONFIG_HOME "%USERPROFILE%\.config"
   ```
2. When installing [git scm](https://git-scm.com/) be sure to check the *'Enable symbolic links'* option.

3. When cloning [this repo](https://github.com/darcyparker/my_dotfiles):

   `git clone -c core.symlinks=true git@github.com:darcyparker/my_dotfiles.git`

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

### On older windows machines (prior to Windows 10)

Run `setup.bat` as administrator (because `mklink.exe` is needed to create
symbolic links to `_vimrc`, `.vim`, and `.config/nvim`.
