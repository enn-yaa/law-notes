#!/bin/bash
# =====================================
# 🧭 Hugo law-notes 博客自动新建文章脚本
# 作者: xuufaa
# 更新时间: 2025-11-01
# =====================================

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LC_CTYPE=zh_CN.UTF-8

POSTS_DIR="content/posts"

echo "📂 请选择要写入的学科目录（输入序号）:"
select SUBJECT in $(ls -d $POSTS_DIR/*/ | xargs -n1 basename); do
  TARGET_DIR="$POSTS_DIR/$SUBJECT"
  break
done

read -e -p "📝 请输入文章标题（中文）: " TITLE
read -e -p "📚 请输入系列名称（如：李建伟系列，可留空）: " SERIES
read -e -p "🔖 请输入标签（多个用英文逗号分隔）: " TAGS

# ✅ 忽略无法转换的字符并静默处理
SLUG=$(echo "$TITLE" | LANG=C iconv -c -t ascii//TRANSLIT 2>/dev/null | sed 's/[[:space:]]\+/-/g' | sed 's/[^a-zA-Z0-9_-]//g' | tr 'A-Z' 'a-z')
[ -z "$SLUG" ] && SLUG="note"

# ✅ 文件名日期格式：2025-11-01-22-36
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M")
# ✅ Front Matter 时间格式：2025-11-01T22:36:00+08:00
DATE=$(date +"%Y-%m-%dT%H:%M:%S+08:00")

FILENAME="${TIMESTAMP}-${SUBJECT}-${SLUG}.md"
FULL_PATH="$TARGET_DIR/$FILENAME"

cat <<EOF > "$FULL_PATH"
---
title: "$TITLE"  # 文章标题
date: $DATE
draft: false
series: ["$SERIES"]
categories: ["$SUBJECT"]
tags: [$(echo $TAGS | sed 's/, */, "/g' | sed 's/^/"/' | sed 's/$/"/')]
description: "简短说明，如：${TITLE}精要整理"
---

## 📘 $TITLE

> 🗓 创建时间：$(date +"%Y年%m月%d日 %H:%M")  
> 📂 分类：$SUBJECT  
> ✍️ 系列：$SERIES  

---

### 一、导言 · 主要内容 · 重难点

（在这里撰写正文开头，可包含学习缘起、章节概览、老师观点等。）

---

### 二、主要内容摘录

（摘录或整理书中重点、案例、法条逻辑。）

- 示例：
  - 公司设立与法人资格
  - 股东出资与瑕疵责任
  - 董事职责与内部治理

---

### 三、个人理解与笔记

（写下你的理解、记忆方法、考点提炼、知识图谱思维。）

---

### 四、延伸阅读 / 参考资料

- 《中华人民共和国公司法（2024修订）》  

---

✅ **保存后执行以下命令以更新博客：**

\`\`\`bash
hugo --minify
git add .
git commit -m "add: $TITLE"
git push origin main
\`\`\`
EOF

echo "✅ 已创建: $FULL_PATH"
echo "🕒 时间戳: $DATE"
