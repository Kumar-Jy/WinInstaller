@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Run the actual command
powershell.exe -command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /Z-WindowsESUOffice"
pause
