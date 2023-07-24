@echo off
setlocal EnableDelayedExpansion

REM Check if the script is running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run it as an administrator.
    pause
    exit /b 1
)

REM Prompt the user to enter their username
set /p "currentUser=Enter your username: "

REM Check if the entered username is not empty
if not defined currentUser (
    echo Username cannot be empty. Exiting...
    pause
    exit /b 1
)

REM Define the source and destination folders
set "sourceFolder=C:\LocalAccountBackup"
set "destinationFolder=C:\Users\%currentUser%"

REM Check if the source folder exists
if not exist "%sourceFolder%" (
    echo Source folder does not exist. Exiting...
    pause
    exit /b 1
)

REM Check if the destination folder exists
if not exist "%destinationFolder%" (
    echo Destination folder does not exist. Exiting...
    pause
    exit /b 1
)

REM Copy the contents of the source folder to the destination folder using xcopy
echo Merging contents from %sourceFolder% to %destinationFolder%...
xcopy "%sourceFolder%\*" "%destinationFolder%\" /E /C /I /H /R /K /O /Y

REM Merge completed successfully
echo.
echo Merge completed successfully!
pause
