### 📖 八大学科

{{< rawhtml >}}
<style type="text/css">
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
  font-family: "Noto Sans SC","PingFang SC","Microsoft YaHei",sans-serif;
  letter-spacing: 0.4em;
  line-height: 2.2;
  padding: 0.7rem 0;
  border: 1px solid rgba(0,0,0,0.08);
  border-radius: 10px;
  background: rgba(255,255,255,0.3);
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
  background: rgba(0,0,0,0.05);
}
/* 📱 手机端优化 */
@media (max-width:768px){
  .subjects-container {
    grid-template-columns: repeat(2,1fr);
    gap: 0.6rem 1rem;
    margin-top: 1rem;
  }
  .subjects-container li {
    font-size: 1.1rem;
    padding: 0.45rem 0;
    letter-spacing: 0.38em;
    line-height: 1.7;
    border-radius: 8px;
  }
}
/* 📂 资料与其他 */
.posts-list li{margin-bottom:0.3rem;}
@media (max-width:768px){
  .posts-list li{margin-bottom:0.9rem;}
}
</style>
{{< /rawhtml >}}

<ul class="subjects-container">
  <li><a href="/posts/criminal/">刑　法</a></li>
  <li><a href="/posts/civil/">民　法</a></li>
  <li><a href="/posts/criminal-procedure/">刑　诉　法</a></li>
  <li><a href="/posts/civil-procedure/">民　诉　法</a></li>
  <li><a href="/posts/theory/">法　理　学</a></li>
  <li><a href="/posts/commercial/">商　经　知</a></li>
  <li><a href="/posts/admin/">行　政　法</a></li>
  <li><a href="/posts/international/">国　际　法</a></li>
</ul>