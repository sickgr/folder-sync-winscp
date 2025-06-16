@echo off
:: start.bat
:: Launches the PowerShell script to monitor the folder and trigger WinSCP sync

:: Change directory to the script location
cd /d "%~dp0"

:: Execute the PowerShell script without profile or execution policy restrictions
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0check_folder.ps1"

:: Keep the window open after execution
pause

