netsh interface portproxy add v4tov4 `
  listenport=9223 listenaddress=0.0.0.0 `
  connectport=9222 connectaddress=127.0.0.1
New-NetFirewallRule -DisplayName "ChromeDevTools-9223" `
  -Direction Inbound -Protocol TCP -LocalPort 9223 -Action Allow
"C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --user-data-dir="%TEMP%\chrome-profile-stable"
pause