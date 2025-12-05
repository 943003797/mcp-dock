@echo off
powershell -NoProfile -Command "Start-Process powershell.exe -ArgumentList '-NoLogo -ExecutionPolicy Bypass -File \"%~dp0start-chrome.ps1\"' -Verb RunAs"