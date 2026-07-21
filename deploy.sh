#!/usr/bin/env bash
set -euo pipefail

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "❌ Not a git repo"; exit 1; }
ROOT="$(git rev-parse --show-toplevel)"
[ "$(basename "$ROOT")" = "law-notes" ] || { echo "❌ Not in law-notes: $ROOT"; exit 1; }

STAMP="$(date +%s)"
STASH_LABEL="deploy-stash-$STAMP"

# 如在 detached HEAD，先保护现场
cur="$(git rev-parse --abbrev-ref HEAD || true)"
if [ "$cur" = "HEAD" ]; then
  echo "ℹ️ 检测到 detached HEAD，进行安全恢复..."
  git branch "tmp/recover-$STAMP" || true
  if [ -n "$(git status --porcelain)" ]; then
    git stash push -u -m "$STASH_LABEL"
  fi
fi

# 中止未完成操作，避免切不过去
git rebase --abort 2>/dev/null || true
git merge --abort 2>/dev/null || true
git cherry-pick --abort 2>/dev/null || true

git fetch origin
# 回到 main（强制切换确保不被工作区阻塞；我们已 stash 保护了改动）
git switch -f main 2>/dev/null || git switch -c main --track origin/main
git pull --rebase origin main || true

# 还原刚才 stash 的改动（如果有）
if git stash list | grep -q "$STASH_LABEL"; then
  git stash pop || true
fi

echo "🧱 构建 Hugo..."
hugo --cleanDestinationDir

# 提交并推送
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "chore(deploy): $(date '+%F %T %z')"
else
  echo "✅ 无需提交"
fi

echo "📤 推送到 origin/main"
git push -u origin main

echo "🎉 完成"
