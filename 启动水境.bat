@echo off
chcp 65001 >nul
title 水境 Water Realm
:: ============================================
::  水境 (Water Realm) — Windows 启动器
::  双击即可启动，自动打开浏览器
:: ============================================

cd /d "%~dp0"

echo.
echo   🌊 正在启动水境...
echo.

:: 终止已占用的8080端口
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080.*LISTENING 2^>nul') do (
    taskkill /F /PID %%a >nul 2>&1
)

:: 尝试 python3 或 python
where python3 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    start "" /B python3 -m http.server 8080
) else (
    where python >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        start "" /B python -m http.server 8080
    ) else (
        echo   ❌ 未找到 Python！请先安装 Python：
        echo      https://www.python.org/downloads/
        echo      安装时请勾选 "Add Python to PATH"
        echo.
        pause
        exit /b 1
    )
)

:: 等待服务器就绪
timeout /t 2 /nobreak >nul

:: 打开浏览器
start http://localhost:8080/水境.html

echo   ✅ 水境已启动 → http://localhost:8080/水境.html
echo   按任意键可关闭服务器并退出...
echo.

pause >nul

:: 关闭服务器
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080.*LISTENING 2^>nul') do (
    taskkill /F /PID %%a >nul 2>&1
)
