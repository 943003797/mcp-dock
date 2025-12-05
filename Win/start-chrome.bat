@echo off
title Chrome DevTools MCP - 管理员权限运行
color 0A

echo ==============================================
echo Chrome DevTools MCP 启动器
echo ==============================================
echo.
echo 正在请求管理员权限...
echo.

:: 检查是否已有管理员权限
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [√] 已获得管理员权限
    echo.
    goto :run_script
) else (
    echo [×] 需要管理员权限，正在重新启动...
    echo.
    goto :get_admin
)

:: 请求管理员权限
:get_admin
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs" >nul 2>&1
del "%temp%\getadmin.vbs" >nul 2>&1
exit /b

:: 运行PowerShell脚本
:run_script
echo [i] 正在运行 PowerShell 脚本...
echo [i] 脚本路径: %~dp0start-chrome.ps1
echo.

:: 设置执行策略并运行脚本
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
powershell -ExecutionPolicy RemoteSigned -File "%~dp0start-chrome.ps1"

:: 检查脚本执行结果
if %errorLevel% == 0 (
    echo.
    echo [√] 脚本执行完成
) else (
    echo.
    echo [×] 脚本执行出错，错误码: %errorLevel%
)

echo.
echo 按任意键退出...
pause >nul