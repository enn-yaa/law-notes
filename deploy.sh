#!/usr/bin/env bash
set -euo pipefail

echo "🔍 检查 Git 状态..."

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
  echo "❌ Not a git repo"
  exit 1
}

branch=$(git branch --show-current)

if [ "$branch" != "main" ]; then
    echo "❌ 当前分支不是 main，而是 $branch"
    exit 1
fi


echo "🧱 构建 Hugo..."

hugo --cleanDestinationDir


echo "📦 提交修改..."

if [ -n "$(git status --porcelain)" ]; then

    git add -A

    git commit -m "update: $(date '+%F %T')"

else

    echo "✅ 无需提交"

fi


echo "📤 推送 GitHub..."

git push origin main


echo "🎉 完成"
