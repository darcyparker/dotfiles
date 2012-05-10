@echo off
REM This script creates standard links in my %HOME% folder
REM Note: This script must be run as an administrator
REM Note: This script does not create all links that I may need
REM       if using cygwin or mingw32.  To create links for cygwin or mingw32
REM       use the setup.sh script inside a bash shell in cygwin.
REM Note: Before running this script, set %HOME%=%USERPROFILE%.
REM       or set %HOME%=PATH_TO_CYGWIN_USER_HOME
REM       (If you have setx.exe installed, use the command: `setx HOME %USERPROFILE%`)

IF NOT DEFINED HOME goto :ERROR_NO_HOME

echo Linking d:\work folder to %HOME%\work
if NOT EXIST "%HOME%\work" (
  mklink /d "%HOME%\work" "d:\work"
) else (
  echo   No link created. "%HOME%\work" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking %USERPROFILE%\Downloads folder to %HOME%\Downloads
if NOT EXIST "%HOME%\Downloads" (
  mklink /d "%HOME%\Downloads" "%USERPROFILE%\Downloads"
) else (
  echo   No link created. "%HOME%\Downloads" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking %USERPROFILE%\Desktop folder to %HOME%\Desktop
if NOT EXIST "%HOME%\Desktop" (
  mklink /d "%HOME%\Desktop" "%USERPROFILE%\Desktop"
) else (
  echo   No link created. "%HOME%\Desktop" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking %USERPROFILE%\Documents folder to %HOME%\Documents
if NOT EXIST "%HOME%\Documents" (
  mklink /d "%HOME%\Documents" "%USERPROFILE%\Documents"
) else (
  echo   No link created. "%HOME%\Documents" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking %USERPROFILE%\Dropbox folder to %HOME%\Dropbox
if NOT EXIST "%HOME%\Dropbox" (
  mklink /d "%HOME%\Dropbox" "%USERPROFILE%\Dropbox"
) else (
  echo   No link created. "%HOME%\Dropbox" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking common\vim.dot_symlink folder to %HOME%\.vim
if NOT EXIST "%HOME%\.vim" (
  mklink "%HOME%\.vim" "%~dp0\common\vim.dot_symlink"
) else (
  echo   No link created. "%HOME%\.vim" already exists.
  echo   If you want to replace the link, manually remove this folder
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking common\vimrc.dot_symlink to "%HOME%\_vimrc"
if NOT EXIST "%HOME%\_vimrc" (
  ::creates a hard link so that it can be edited from either location
  mklink "%HOME%\_vimrc" "%~dp0\common\vimrc.dot_symlink"
) else (
  echo   No link created. "%HOME%\_vimrc" already exists.
  echo   If you want to replace the link, manually delete this file
  echo   and re-run setup.bat to create the link.
)
echo.

echo Linking common\vimrc.dot_symlink to "%HOME%\.vimrc"
if NOT EXIST "%HOME%\.vimrc" (
  ::creates a hard link so that it can be edited from either location
  mklink "%HOME%\.vimrc" "%~dp0\common\vimrc.dot_symlink"
) else (
  echo   No link created. "%HOME%\_vimrc" already exists.
  echo   If you want to replace the link, manually delete this file
  echo   and re-run setup.bat to create the link.
)

goto :END

:ERROR_NO_HOME
REM Note that %HOME% and %USERPROFILE% are escaped below
echo Error: ^%%HOME^%% is undefined.
echo        Example: If not using cygwin and/or mingw32
echo          setx HOME ^%%USERPROFILE^%%
echo        Example: If using cygwin and/or mingw32
echo          setx HOME d:\cygwin\home\dparker
goto :END

:END
