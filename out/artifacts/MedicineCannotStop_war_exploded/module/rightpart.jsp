<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="entity.article" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/16 0016
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

  <div class="xingqu-message row">
    <h1 class="title">
      <p style="font-weight:600;margin:30px 0 25px 10px;">你可能感兴趣:</p>
      <ul>
        <%
          ArrayList<Integer> numbers = BasicDao.getbigestNumbers(UserFavoriteArticle.class, "group by article_id order by count(article_id) desc", "article_id");
          for (int aid : numbers) {

            article a = BasicDao.selectById(aid, article.class);
            String aTitle = a.getTitle();
            String aText = a.getText();
            int argus = BasicDao.count(article.class, "where parent_article=" + aid);

        %>
        <li>
          <a href="/main/question.jsp?aid=<%=aid%>"><%=aTitle%>
          </a>
          <small style="display:inline-block;font-size:0.9em;color:#777">
            <%=argus%>评论
          </small>
        </li>
        <%
          }
        %>
      </ul>
    </h1>
  </div>


</body>
</html>
