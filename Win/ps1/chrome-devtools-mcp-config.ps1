# 配置 Chrome DevTools 端口转发和防火墙规则

# 添加端口转发规则：将本地 9223 端口转发到 9222 端口
netsh interface portproxy add v4tov4 `
  listenport=9223 listenaddress=0.0.0.0 `
  connectport=9222 connectaddress=127.0.0.1

# 添加防火墙入站规则以允许 9223 端口的 TCP 连接
New-NetFirewallRule -DisplayName "ChromeDevTools-9223" `
  -Direction Inbound -Protocol TCP -LocalPort 9223 -Action Allow

Write-Host "Chrome DevTools 端口配置已完成！" -ForegroundColor Green
Write-Host "按任意键退出..." -ForegroundColor Yellow
Pause

# 执行完成后关闭 PowerShell 窗口
exit