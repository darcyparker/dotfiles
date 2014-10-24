#Getting msys2
Installer: https://msys2.github.io/
See https://sourceforge.net/projects/msys2/

#Tips

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
