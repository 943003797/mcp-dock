#!/bin/bash

# 首先配置端口转发
echo "正在配置端口转发..."
./chrome-port-config.sh

# 启动 Chrome 浏览器并启用远程调试
echo "正在启动 Chrome 浏览器..."
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222 \
  --user-data-dir="/tmp/chrome-profile-stable" &

echo "Chrome 浏览器已在远程调试模式下启动"
echo "调试地址: http://localhost:9222"
echo "转发地址: http://localhost:9223"
echo "按任意键退出..."
read -n 1 -s