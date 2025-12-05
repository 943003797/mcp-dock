#!/bin/bash

# 配置 Chrome DevTools 端口转发规则
echo "配置 Chrome DevTools 端口转发规则..."

# 检查是否安装了 pfctl
if ! command -v pfctl &> /dev/null; then
    echo "错误: pfctl 未找到，请确保在 macOS 上运行"
    read -p "按任意键退出..."
    exit 1
fi

# 创建 PF 规则文件
sudo echo "rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 9223 -> 127.0.0.1 port 9222" > /etc/pf.anchors/chromedevtools

# 创建 PF 配置文件
sudo echo "anchor \"chromedevtools\"" > /etc/pf-chrome-devtools.conf
sudo echo "load anchor \"chromedevtools\" from \"/etc/pf.anchors/chromedevtools\"" >> /etc/pf-chrome-devtools.conf

# 启用 PF 规则
sudo pfctl -ef /etc/pf-chrome-devtools.conf

if [ $? -eq 0 ]; then
    echo "Chrome DevTools 端口转发配置已完成！"
    echo "已将本地 9223 端口转发到 127.0.0.1 的 9222 端口"
else
    echo "端口转发配置失败，请检查权限设置"
fi

echo "按任意键退出..."
read -n 1 -s