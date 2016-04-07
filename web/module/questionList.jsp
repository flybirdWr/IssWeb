<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/15 0015
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page import="DAO.BasicDao" %>
<%@ page import="DAO.pageDao" %>
<%@ page import="entity.*" %>
<%@ page import="util.pageUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title></title>
</head>
<body>
<%--左边方块--%>
<DIV class="col-xs-12 col-md-9">

  <%
    int currentpage;
    String cp = request.getParameter("currentpage");
    if (cp != null && cp.length() > 0) {
      currentpage = Integer.parseInt(cp);
      if (currentpage < 1) {
        currentpage = 1;
      }
    } else {
      currentpage = 1;
    }
    int totalcount = BasicDao.count(article.class, "where tree_level=1");
    page p = pageUtil.createPage(10, totalcount, currentpage);
    int totalpage = p.getTotalPage();
    boolean hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
  %>

  <DIV class="col-xs-12 col-md-12">
    <div class="select col-md-12" id="select">

      <a class="pull-right" style="color: #F9F9F9;font-size: 1.2em;text-decoration: none;margin-top:10px;"
         href="/main/index.jsp?currentpage=<%=currentpage%>">
        <img src="/Icons/shuaxin.png" width="18">刷新</a>

    </div>

    <div class="questions col-md-12" style="margin-top: 0px;">

      <%


        List<article> articles = pageDao.queryByPage("where tree_level=1"+" order by date desc", article.class, p);
        for (article a : articles) {
          User u1 = a.getU();
          String username = u1.getUsername();
          username = username.startsWith("Passenger:")?"游客":username;
          String picture = u1.getHead();
          String title = " ";
          String message = "";
          if (a.getTree_level() == 1) {
            title = a.getTitle();
          }
          title = title.startsWith("Passenger:")?"匿名用户":title;
          Date date = a.getDate();
          String text = a.getText();
          String atext;
          if (text.length() <= 100) {
            atext = text;
          } else {
            message = "&nbsp点击查看";
            atext = text.substring(0, 99) + "...";
          }
          int id = a.getArticle_id();
          String sql = "where tag_id in(select tag_id from articletag where article_id=" + id + ")";
          List<Tag> tags = BasicDao.select(sql, Tag.class);
          //取得赞和评论的数量
          String sql1 = "where article_id=" + id + " and thumb_or_step =1";
          int thumb = BasicDao.count(articleJudgement.class, sql1);//赞数
          String sql2 = "where parent_article=" + id;
          int argu = BasicDao.count(article.class, sql2);//评论数

      %>

      <!--以下是问题列表-->
      <div class="question">
        <div class="author-message hidden-xs" style="float:left;width:10%;">
          <img class="img-rounded" src="/user_data/<%=u1.getHead()%>" width="100%">
          <p style="text-align: center;margin-top:2px;font-size:1em;"><a
                  style="font-weight:600"><%=username%></a></p>

        </div>


        <div class="question-message">
          <div class="summary">

            <h1 class="title">
              <A title="" href="/main/question.jsp?aid=<%=id%>">
                <%=title%>
              </A>
            </h1>

            <div class="time hidden-lg hidden-md hidden-sm">
              <ul class="author list-inline" style="margin-bottom:0px;">
                <li class="">
                  <a><%=username%>
                  </a>
                </li>
                <li class="">
                  <a>&nbsp&nbsp2015-9-22&nbsp10:32&nbsp</a>
                </li>
              </ul>
            </div>
            <ul class="author list-inline pull-right">

              <li class="hidden-xs">
                <a>发表于&nbsp<%=date%>
                </a>
              </li>

            </ul>
            <p class="content">
              <%=atext%><a href="../main/question.jsp?aid=<%=id%>"><%=message%></a>
            </p>
            <%
              for (Tag t : tags) {

            %>
            <span class="label label-success"><%=t.getTag_name()%></span>
            <%--<span class="label label-success">程序员</span>--%>
            <%--<span class="label label-success">标签</span>--%>

            <%
              }
            %>
            <ul class="author list-inline pull-right">
             <%-- <li class="hidden-xs">
                <img src="/Icons/liulan.png" width="15"> <a>浏览(TODO:浏览数)</a>
              </li>--%>
              <li class="">
                <img src="/Icons/zancheng.png" width="15"> <a
                      href="/main/ThumbServlet?article_id=<%=id%>">赞(<%=thumb%>)</a>
              </li>
              <li class="">
                <img src="/Icons/pinglun.png" width="15"> <a>评论(<%=argu%>)</a>
              </li>
            </ul>

          </div>
        </div>
      </div>

      <%
        }
      %>

      <!--分页-->
        <nav>
          <ul class="pagination">
            <li>
              <a href="/main/index.jsp?currentpage=<%=currentpage-1%>" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
              </a>
            </li>
            <c:forEach var="page" begin="1" end="<%=totalpage%>">
              <%
                if (totalpage < 4) {
              %>
              <li class=""><a href="/main/index.jsp?currentpage=${page}">${page}</a></li>
              <%
              } else {
              %>
              <c:if test="${page<3}">
                <li class=""><a href="/main/index.jsp?currentpage=${page}">${page}">${page}</a></li>
              </c:if>
              <li class="">...</li>

              <%

                if ((int) page > totalpage - 2) {
              %>
              <li class=""><a href="../main/index.jsp?currentpage=${page}">${page}">${page}</a></li>

              <%
                  }
                }
              %>
            </c:forEach>
            <li>
              <c:choose>
                <c:when test="<%=hasnextpage%>">
                  <a href="/main/index.jsp?currentpage=<%=currentpage+1%>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="/main/index.jsp?currentpage=<%=currentpage%>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>

                  </a>
                </c:otherwise>
              </c:choose>
            </li>
            <li>
              <div  style="position:absolute;margin-top:2px;left:250px;">
                <form class="form-inline" action="/main/index.jsp" method="post">
                  <input type="text" name="currentpage" style="width: 40px;height: 30px;border: 1px solid #949494;border-radius: 2px;">
                  <input class="btn btn-primary" type="submit" value="跳至该页" style="padding: 3px 5px;">
                </form>
              </div>
            </li>
          </ul>
        </nav>



    </div>
  </DIV>
</DIV>
</body>
</html>
