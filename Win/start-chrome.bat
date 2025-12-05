@echo off
powershell -NoProfile -Command "Start-Process powershell.exe -ArgumentList '-NoLogo -ExecutionPolicy Bypass -File \"%~dp0chrome-port-config.ps1\"' -Verb RunAs"

"C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --user-data-dir="%TEMP%\chrome-profile-stable"
pause