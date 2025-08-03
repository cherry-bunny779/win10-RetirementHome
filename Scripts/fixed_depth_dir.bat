@echo off
setlocal EnableDelayedExpansion

REM === Allow user to run a custom command ===
REM === Custom command loop ===
:custom_loop
echo.
echo Welcome to Fixed Depth File List!
echo.
echo Enter Commands Before Main Script
set /p USERCMD=Enter a command to run: (type 'e' to exit)

if /I "%USERCMD%"=="e" (
    echo.
    echo Exiting custom command mode...
    echo.
    goto main_body
)

if not "%USERCMD%"=="" (
    echo.
    echo Running: %USERCMD%
    cmd /c "%USERCMD%"
    echo.
)
goto custom_loop

REM === Main script body ===
:main_body

REM Prompts for Start Directory and Search Depth
set /p STARTDIR=Enter the start directory (leave blank for current directory): 
if "%STARTDIR%"=="" set "STARTDIR=%CD%"

set /p SEARCHDEPTH=Enter the search depth (number of levels to recurse): 

REM Count backslashes in Start Directory
call :CountBackslashes "%STARTDIR%" count

REM Compute Target Depth
set /a TARGETDEPTH=%count%+%SEARCHDEPTH%

echo Listing directory names under: %STARTDIR% up to depth %SEARCHDEPTH%
echo.

set totalCount=0

REM Recursive listing with depth check
for /D /R "%STARTDIR%" %%G in (*) do (
    call :CountBackslashes "%%G" ccount
    if !ccount! EQU %TARGETDEPTH% (
        echo %%~nxG
        set /a totalCount+=1
    )
)

echo.
echo Total items printed: %totalCount%
echo.
set /p CTNU=Continue? (type 'c' to continue...):
if /I "%CTNU%"=="c" (
    REM Go back to start of script
    goto custom_loop
)
echo Done.
pause
exit /b


REM =====================
REM Subroutine Definition
REM =====================
:CountBackslashes
setlocal EnableDelayedExpansion
set "str=%~1"
set "cnt=0"
:loop
if not "!str!"=="" (
    set "ch=!str:~0,1!"
    if "!ch!"=="\" set /a cnt+=1
    set "str=!str:~1!"
    goto loop
)
endlocal & set "%2=%cnt%"
exit /b
