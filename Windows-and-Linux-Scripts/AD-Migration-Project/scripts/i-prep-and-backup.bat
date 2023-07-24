@echo off
setlocal

REM Check if the script is running with administrator privileges
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ERROR: This script requires administrator privileges.
    echo Please run the script as an administrator.
    pause
    exit /b 1
)

REM Set the source and destination paths
set "localUsername=user3"
set "backupFolder=C:\LocalAccountBackup"

REM Set the logfile path and name
set "logFile=%~dp0backup_log.txt"

REM Step 1: Create the backup folder if it doesn't exist
mkdir "%backupFolder%" 2>nul

REM Step 2: Copy local user's home folder to the backup folder
echo Backup of %localUsername%'s home folder to %backupFolder% started... > "%logFile%"
robocopy "C:\Users\%localUsername%" "%backupFolder%" /E /XJ /XJD >> "%logFile%" 2>&1

echo Backup of %localUsername%'s home folder completed successfully! >> "%logFile%"

REM Step 3: Navigate to the user's home directory and list its contents
cd /d "%USERPROFILE%"
echo. >> "%logFile%"
echo Listing contents of the user's home directory: >> "%logFile%"
dir >> "%logFile%"

REM Step 4: Navigate to the backup directory and list its contents
cd /d "%backupFolder%"
echo. >> "%logFile%"
echo Listing contents of the backup directory: >> "%logFile%"
dir >> "%logFile%"

REM Step 5: Display the contents of the logfile
type "%logFile%"

pause
