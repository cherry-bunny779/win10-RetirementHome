REM If the drive containing the Captures Folder is removed or the Folder is deleted
REM The Captures save directory is automatically set to the User Temp Folder
REM located at C:\Users\username\AppData\Local\Temp
REM This script allows an easy way for the user to set a new Captures Folder path
@echo off
setlocal enabledelayedexpansion

set "REG_PATH=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
set "REG_VALUE={EDC0FE71-98D8-4F4A-B920-C8DC133CB165}"

echo.
echo Fix Xbox Game Bar Captures Folder Path
echo Reading current value of:
echo   %REG_PATH%\%REG_VALUE%
echo.

:: Read current value
for /f "tokens=2,*" %%A in ('reg query "%REG_PATH%" /v "%REG_VALUE%" 2^>nul') do (
    set "currentValue=%%B"
)

if defined currentValue (
    echo Current value: !currentValue!
) else (
    echo Failed to read current value.
    pause
    exit /b 1
)

echo.
set /p "newValue=Enter new value: "

if "%newValue%"=="" (
    echo No value entered. Exiting.
    pause
    exit /b 1
)

echo.
echo Setting new value...
reg add "%REG_PATH%" /v "%REG_VALUE%" /t REG_EXPAND_SZ /d "%newValue%" /f

if %errorlevel% equ 0 (
    echo Successfully updated the registry.
) else (
    echo Failed to update the registry.
)

pause
