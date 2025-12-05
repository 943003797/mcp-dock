# Chrome DevTools MCP 启动脚本
# 设置端口转发，允许外部访问本地的9222端口
Write-Host "正在设置端口转发..." -ForegroundColor Green
netsh interface portproxy add v4tov4 `
  listenport=9223 listenaddress=0.0.0.0 `
  connectport=9222 connectaddress=127.0.0.1

if ($LASTEXITCODE -eq 0) {
    Write-Host "端口转发设置成功" -ForegroundColor Green
} else {
    Write-Host "端口转发设置失败，可能是已经存在或者权限不足" -ForegroundColor Yellow
}

# 添加防火墙规则
Write-Host "正在添加防火墙规则..." -ForegroundColor Green
try {
    New-NetFirewallRule -DisplayName "ChromeDevTools-9223" `
      -Direction Inbound -Protocol TCP -LocalPort 9223 -Action Allow -ErrorAction Stop
    Write-Host "防火墙规则添加成功" -ForegroundColor Green
} catch {
    Write-Host "防火墙规则可能已经存在或者权限不足: $($_.Exception.Message)" -ForegroundColor Yellow
}

# 启动Chrome
Write-Host "正在启动Chrome..." -ForegroundColor Green
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
if (Test-Path $chromePath) {
    Start-Process -FilePath $chromePath `
      -ArgumentList "--remote-debugging-address=0.0.0.0","--remote-debugging-port=9222","--user-data-dir=$env:TEMP\chrome-profile-stable" `
      -NoNewWindow
    Write-Host "Chrome已启动，远程调试端口: 9222" -ForegroundColor Green
    Write-Host "外部访问端口: 9223 (通过端口转发)" -ForegroundColor Green
} else {
    Write-Host "未找到Chrome，请确认安装路径是否正确" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

# 保持窗口存在，显示状态信息
Write-Host "`n=============================================" -ForegroundColor Cyan
Write-Host "Chrome DevTools MCP 运行状态:" -ForegroundColor Cyan
Write-Host "- Chrome远程调试端口: 9222" -ForegroundColor White
Write-Host "- 外部访问端口: 9223" -ForegroundColor White
Write-Host "- 用户数据目录: $env:TEMP\chrome-profile-stable" -ForegroundColor White
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "`n按回车键关闭此窗口并清理端口转发..." -ForegroundColor Yellow

# 等待用户按键
$null = Read-Host

# 清理端口转发
Write-Host "正在清理端口转发..." -ForegroundColor Green
netsh interface portproxy delete v4tov4 listenport=9223 listenaddress=0.0.0.0

# 删除防火墙规则
Write-Host "正在删除防火墙规则..." -ForegroundColor Green
Remove-NetFirewallRule -DisplayName "ChromeDevTools-9223" -ErrorAction SilentlyContinue

Write-Host "清理完成，正在退出..." -ForegroundColor Green
Start-Sleep -Seconds 2