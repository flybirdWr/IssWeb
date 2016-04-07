<%@ page import="util.pageUtil" %>
<%@ page import="DAO.BasicDao" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="DAO.pageDao" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/16 0016
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<%
  User u=(User)session.getAttribute("user");
  int id= u.getUid();

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
  int totalcount = BasicDao.count(article.class, "where tree_level=1 and author="+id);
  page p = pageUtil.createPage(10, totalcount, currentpage);
  int totalpage = p.getTotalPage();
  boolean hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);


  List<article> art= pageDao.queryByPage("where author=" + id + " and tree_level=1", article.class,p);
%>
<body>
<div class="col-md-9">
  <div class="quesions">
    <!--以下是问题列表-->
    <%
      if(art.size()>0){
        for(article a:art){

          String title =a.getTitle();
          Date d1=a.getDate();
          String text = a.getText();
          String atext="";
          if (text.length() <= 100) {
            atext = text;
          } else {
            atext = text.substring(0, 99) + "...";
          }
          int aid = a.getArticle_id();
          String sql = "where tag_id in(select tag_id from articletag where article_id=" + aid + ")";
          List<Tag> tags = BasicDao.select(sql, Tag.class);
          //取得赞和评论的数量
          String sql1 = "where article_id=" + aid + " and thumb_or_step =1";
          int thumb = BasicDao.count(articleJudgement.class, sql1);//赞数
          int step=BasicDao.count(articleJudgement.class, "where article_id=" + aid + " and thumb_or_step =-1");//踩数
          String sql2 = "where parent_article=" + aid;
          int argu = BasicDao.count(article.class, sql2);//评论数
          int care=BasicDao.count(UserFavoriteArticle.class,"where article_id="+aid);
    %>
    <div class="question">
      <div class="question-message" style="float:left;margin-left:3%;width:90%;">
        <p class="title">
          <A title="" href="/main/question.jsp?aid=<%=aid%>" >
            <%=title%>
          </A>
        </p>
        <div class="time">
          <ul class="author list-inline" style="margin-bottom:0px;">
            <li class="">
              <a><%=d1%></a>    //发表时间
            </li>
          <%--  <li class="">
              <img src="/Icons/liulan.png" width="15"><a> 浏览(???)</a>
            </li>--%>
            <li class="">
              <img src="/Icons/guanzhu.png" width="14"><a>关注(<%=care%>)</a>
            </li>
          </ul>
        </div>
        <p class="content">
          <%=atext%>
          <a href="/main/question.jsp?aid=<%=aid%>">点击查看</a>
        </p>

        <%
          for (Tag t : tags) {

        %>
        <span class="label label-success"><%=t.getTag_name()%></span>


        <%
          }
        %>

        <ul class="author list-inline pull-right">
          <li class="hidden-xs">
            <img src="/Icons/zancheng.png" width="15"><a> 赞(<%=thumb%>)</a>
          </li>
          <li class="">
            <img src="/Icons/fandui.png" width="15"><a> 踩(<%=step%>)</a>
          </li>
          <li class="">
            <img src="/Icons/pinglun.png" width="15"><a> 评论(<%=argu%>)</a>
          </li>
          <li class="">
            <img src="/Icons/shanchu.png" width="15"><a href="/servlet/personalCenterServlet?operation=5&&aid=<%=aid%>"> 删除</a>
          </li>
        </ul>
      </div>
    </div>
    <%}}%>
    <!--分页-->
    <nav>
      <ul class="pagination">
        <li>
          <a href="/personalCenter/personCenter.jsp?currentpage=<%=currentpage-1%>" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <c:forEach var="page" begin="1" end="<%=totalpage%>">
          <%
            if (totalpage < 4) {
          %>
          <li class="active"><a href="/personalCenter/personCenter.jsp?currentpage=${page}">${page}</a></li>
          <%
          } else {
          %>
          <c:if test="${page<3}">
            <li class="active"><a href="/personalCenter/personCenter.jsp?currentpage=${page}">${page}">${page}</a></li>
          </c:if>
          <li class="active">...</li>

          <%

            if ((int) page > totalpage - 2) {
          %>
          <li class="active"><a href="/personalCenter/personCenter.jsp?currentpage=${page}">${page}">${page}</a></li>

          <%
              }
            }
          %>
        </c:forEach>
        <li>
          <c:choose>
            <c:when test="<%=hasnextpage%>">
              <a href="/personalCenter/personCenter.jsp?currentpage=<%=currentpage+1%>" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
              </a>
            </c:when>
            <c:otherwise>
              <a href="/personalCenter/personCenter.jsp?currentpage=<%=currentpage%>" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>

              </a>
            </c:otherwise>
          </c:choose>



        </li>
        <li>
          <div  style="position:absolute;margin-top:2px;left:250px;">
            <form class="form-inline" action="/personalCenter/personCenter.jsp" method="post">
              <input type="text" name="currentpage" style="width: 40px;height: 30px;border: 1px solid #949494;border-radius: 2px;">
              <input class="btn btn-primary" type="submit" value="跳至该页" style="padding: 3px 5px;">
            </form>
          </div>
        </li>
      </ul>
    </nav>

  </div>
</div>
</body>
</html>
