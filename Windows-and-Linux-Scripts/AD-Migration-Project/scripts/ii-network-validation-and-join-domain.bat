@echo off
setlocal EnableDelayedExpansion
pause

REM EDIT ME - Supply the domain name

ping synapse.com

REM Set DNS variable to 192.168.117.172
set "DNS=192.168.117.172"

REM Register DNS
echo Registering DNS...
ipconfig /registerdns
echo DNS registration completed.

REM Prompt user to confirm joining domain
set /p "confirmJoin=Do you want to join the domain? (Y/N): "
if /i "%confirmJoin%" neq "Y" (
    echo Domain join canceled. Exiting...
    pause
    exit /b 1
)

REM Get domain and local credentials
set /p "localUsername=Enter the local username to join the domain: "

REM Prompt for domain admin password using PowerShell's Get-Credential
powershell.exe -Command "$domainAdminCredential = Get-Credential 'administrator@synapse.com'; $localCredential = Get-Credential -UserName $env:USERNAME -Message 'Enter the password for the local user:'; Add-Computer -DomainName synapse.com -Credential $domainAdminCredential -LocalCredential $localCredential"

if %ERRORLEVEL% neq 0 (
    echo An error occurred during domain join. Exiting...
    pause
    exit /b %ERRORLEVEL%
)

echo Domain join completed successfully!

REM Release, renew, and register IP
echo Releasing IP...
ipconfig /release
echo.
echo Renewing IP...
ipconfig /renew
echo.
echo Registering DNS...
ipconfig /registerdns
echo.

pause