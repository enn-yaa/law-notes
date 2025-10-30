#!/bin/bash
# 一键 Hugo 构建 + 推送脚本
# 适用于 https://github.com/enn-yaa/law-notes

set -e

echo "🧹 清理旧的 public 文件夹..."
rm -rf public

echo "🏗️ 构建 Hugo 静态文件..."
hugo --cleanDestinationDir

echo "📤 提交更改..."
git add .
git commit -m "auto: 更新 Hugo 博客 $(date '+%Y-%m-%d %H:%M:%S')" || true

echo "🚀 推送到 GitHub..."
git push https://enn-yaa@github.com/enn-yaa/law-notes.git main

echo "✅ 已推送成功，可访问 👉 https://law.xuufaa.com/"
