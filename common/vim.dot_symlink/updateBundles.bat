@echo off
:: For each git repo defined in the *.list files,
:: this batch file creates a cloned git repo if the repo does not exist
:: or updates the repo and checks out the branch defined in the current
:: *.lst file
::
:: Notes: - The git command must be executed with 'call'
::          because it is a .cmd batch file on Windows
setlocal
set _START_DIR=%CD%
set _THIS_SCRIPT_DIR=%~dp0
:: For each repo in bundle list call _updateBundle method
for /F "usebackq" %%i in (`dir /b %_THIS_SCRIPT_DIR%*.list`) DO call :_updateBundle %%i
goto :end

:: Method to updateBundle. Bundle List Filename is first argument
:_updateBundle
set _BUNDLE_LIST_FILE=%1
set _BUNDLE_LIST_NAME=%~n1
set _BUNDLE_DIR=%_THIS_SCRIPT_DIR%%_BUNDLE_LIST_NAME%
echo Updating bundles defined in "%_BUNDLE_LIST_FILE%"
if NOT EXIST "%_BUNDLE_DIR%" mkdir "%_BUNDLE_DIR%"
if NOT EXIST "%_BUNDLE_DIR%" echo ERROR: Could not create folder "%_BUNDLE_DIR%" & goto :eof
:: Parse repos in bundle list file
for /F "eol=; tokens=1,2,3" %%i in (%_THIS_SCRIPT_DIR%%_BUNDLE_LIST_FILE%) DO (
  :: Notes on variables that can't be set inside this batch for loop
  REM Also note that REM comment is required here. It doesn't like :: why???
  REM %%i is _REPO_NAME
  REM %%j is _REPO_BRANCH
  REM %%k is _REPO_URL
  REM _REPO_DIR=%_BUNDLE_DIR%\%%i
  echo.
  if exist "%_BUNDLE_DIR%\%%i" (
    echo "%%i" already exists. Checking for updates...
    cd /d "%_BUNDLE_DIR%\%%i"
    call git checkout %%j
    call git pull
    call git submodule update --init --recursive
  ) else (
    echo "%%i" does not exist. Cloning %%k
    call git clone --recursive %%k "%_BUNDLE_DIR%\%%i"
    cd /d "%_BUNDLE_DIR%\%%i"
    call git checkout %%j
  )
)
echo.
echo Finished updating bundles defined in "%_BUNDLE_LIST_FILE%"
goto :eof :: end of _updateBundle method

:end
cd /d "%_START_DIR%"
endlocal
