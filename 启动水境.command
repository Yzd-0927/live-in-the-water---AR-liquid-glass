#!/bin/bash
# ============================================
#  水境 (Water Realm) — macOS 启动器
#  双击即可启动，自动打开浏览器
# ============================================

cd "$(dirname "$0")"

# 终止已占用的端口
lsof -ti :8080 | xargs kill -9 2>/dev/null

# 启动服务器
python3 -m http.server 8080 &
SERVER_PID=$!

# 等待服务器就绪
sleep 1.5

# 打开浏览器
open "http://localhost:8080/水境.html"

echo ""
echo "  🌊  水境已启动 → http://localhost:8080/水境.html"
echo "  ⌨️   按 Ctrl+C 可停止服务器"
echo ""

# 保持终端打开
wait $SERVER_PID 2>/dev/null
