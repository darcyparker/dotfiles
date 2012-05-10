@echo off
:: For each git repo defined in the *.list files,
:: this batch file creates a cloned git repo if the repo does not exist
:: or updates the repo and checks out the branch defined in the current 
:: *.lst file
::
:: Notes: - The git command must be executed with 'call'
::          because it is a .cmd batch file on Windows
setlocal
set _currentcd=%CD%
set _updateBundlesDir=%~dp0
for /F "usebackq" %%i in (`dir /b %_updateBundlesDir%*.list`) DO call :_updateBundle %%~ni
goto :end

:: Method to updateBundle name passed as first argument
:_updateBundle
set _bundleName=%1
set _repofile=%_updateBundlesDir%%_bundleName%.list
set _bundle_dir=%_updateBundlesDir%%_bundleName%
echo Updating bundles defined in %_bundleName%.list
if NOT EXIST "%_bundle_dir%" mkdir "%_bundle_dir%"
if NOT EXIST "%_bundle_dir%" echo ERROR: Could not create folder "%_bundle_dir%" & goto :eof
for /F "eol=; tokens=1,2,3" %%i in (%_repofile%) DO (
  if exist "%_bundle_dir%\%%i" (
    echo.
    echo %%i Already Exists. Checking for updates
    cd /d "%_bundle_dir%\%%i"
    call git checkout %%j
    call git pull
  ) else (
    echo.
    echo %%i Does not Exist. Cloning git://github.com/%%k.git
    call git clone %%k "%_bundle_dir%\%%i"
    cd /d "%_bundle_dir%\%%i"
    call git checkout %%j
  )
)
echo.
echo Finished updating bundles defined in %_bundleName%.list
goto :eof :: end of _updateBundle method

:end
cd /d "%_currentcd%"
endlocal
