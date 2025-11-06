#!/usr/bin/env bash
set -euo pipefail

# 确保在 law-notes 仓库
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "❌ Not a git repo"; exit 1; }
ROOT="$(git rev-parse --show-toplevel)"
[ "$(basename "$ROOT")" = "law-notes" ] || { echo "❌ Not in law-notes: $ROOT"; exit 1; }

STAMP="$(date +%s)"
REC="tmp/recover-$STAMP"
STASH_LABEL="deploy-stash-$STAMP"

cur="$(git rev-parse --abbrev-ref HEAD || true)"
if [ "$cur" = "HEAD" ]; then
  echo "ℹ️ 检测到 detached HEAD，进行安全恢复..."
  # 锚住当前提交（即使没有未提交更改，也防丢指针）
  git branch "$REC" || true

  # 有未提交改动则先存入 stash（含未跟踪文件）
  if [ -n "$(git status --porcelain)" ]; then
    git stash push -u -m "$STASH_LABEL"
  fi

  git fetch origin
  git switch main 2>/dev/null || git switch -c main --track origin/main
  git pull --rebase origin main || true

  # 合并临时分支（如果它不在 main 的祖先上）
  if ! git merge-base --is-ancestor "$REC" HEAD; then
    git merge --no-ff "$REC" -m "merge: recover detached work $REC" || true
  fi

  # 还原 stash（如果刚才存过）
  if git stash list | grep -q "$STASH_LABEL"; then
    git stash pop || true
  fi

  # 清理临时分支（可选）
  git branch -D "$REC" >/dev/null 2>&1 || true
fi

# 再次确认在 main
branch="$(git rev-parse --abbrev-ref HEAD)"
[ "$branch" = "main" ] || { echo "❌ 当前分支不是 main，而是 $branch"; exit 1; }

echo "🧱 构建 Hugo..."
hugo --cleanDestinationDir

echo "🔃 同步远端..."
git fetch origin
git pull --rebase origin main || true

# 提交新内容
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "chore(deploy): $(date '+%F %T %z')"
else
  echo "✅ 无需提交"
fi

echo "📤 推送到 origin/main"
git push -u origin main

echo "🎉 完成"
