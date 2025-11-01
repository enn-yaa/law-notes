<style>
.subjects-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.6rem 3rem;
  margin-top: 1.6rem;
  list-style: none;
  padding-left: 0;
  text-align: center;
}

.subjects-container li {
  font-size: 1.15rem;
  font-family: "Noto Sans SC", "PingFang SC", "Microsoft YaHei", sans-serif;
  letter-spacing: 0.4em;
  line-height: 2.2;
  padding: 0.7rem 0;
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  user-select: none;
}

.subjects-container li a {
  text-decoration: none;
  color: inherit;
  width: 100%;
  display: block;
}

.subjects-container li:hover {
  background: rgba(0, 0, 0, 0.05);
}

/* 📱 手机端优化：缩小间距、减小卡片高度 */
@media (max-width: 768px) {
  .subjects-container {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem 1.5rem;   /* 原1.8rem 2rem → 更紧凑 */
  }
  .subjects-container li {
    font-size: 1.15rem; /* 保持可读 */
    padding: 0.6rem 0;  /* 原1rem → 更小 */
    letter-spacing: 0.45em;
    line-height: 1.9;   /* 让高度更紧凑 */
  }
}

/* 📂 资料与其他：电脑端正常，手机端/iPad 更宽松 */
.posts-list li {
  margin-bottom: 0.3rem;
}
@media (max-width: 768px) {
  .posts-list li {
    margin-bottom: 0.9rem;
  }
}
</style>