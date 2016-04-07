<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.Tag" %>
<%@ page import="entity.article" %>
<%@ page import="util.KeyConst" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/27
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <LINK rel=stylesheet href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/personCenter.css">
    <link rel="stylesheet" href="/css/qContent.css">
    <link rel="stylesheet" href="/css/questionshow.css">
    <link rel="stylesheet" href="/css/index.css">

    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/register.js"></script>
    <script src="/js/login.js"></script>
    <title></title>
</head>
<body>
<%
    String aid = request.getParameter("aid");
    int childNo = BasicDao.count(article.class, "where parent_article='" + aid + "'");
    List<article> as = BasicDao.select("where article_id='" + aid + "'", article.class);
    if (as.isEmpty()) {
        response.sendRedirect("/errorpage/articleAlreadyDeleted.html");
        return;
    }
    article a = as.get(0);
    String tag_sql = "where tag_id in(select tag_id from articletag where article_id=" + aid + ")";
    List<Tag> tags = BasicDao.select(tag_sql, Tag.class);
%>
<div class="col-md-12">
    <div class="">
        <div class="" style="float:left;">
            <div class="summary" style="margin-top: 20px;">
                <p class="content">
                    <%=a.getText()%>
                </p>
                <%
                    for (Tag t : tags) {
                %>
                <span class="label label-success"><%=t.getTag_name()%></span>
                <%
                    }
                %>

                <ul class="author list-inline pull-right">
                    <li><a href="/admin/DeleteServlet?<%=KeyConst.ARTICLE_ID%>=<%=a.getArticle_id()%>">删除</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<ul type="dot">
    <%
        if (childNo > 0) {
            List<article> children = BasicDao.select("where parent_article='" + aid + "'", article.class);
            for (article child : children) {
    %>
    <li>
        <div class="">
            <jsp:include page="read_article.jsp">
                <jsp:param name="aid" value="<%=child.getArticle_id()%>"/>
            </jsp:include>
        </div>
    </li>
    <%
            }
        }
    %>
</ul>
</body>
</html>

<%-- 学软件要有人指路. 这个项目没人指路. 很难学到东西. 希望接手这个项目的人把眼界放长远 --%>
<%-- 这个项目的创意人的想法是好的. 但是ta犯了典型的"我有一个好idea就差一个程序猿了". ta不懂web开发. 跟一个不懂web开发的人搞web开发就是一个重大决策失误. --%>
<%-- 之后我们开发团队也有失误. 闭门造车, 不向专业人士请教, 导致项目重构n遍. --%>