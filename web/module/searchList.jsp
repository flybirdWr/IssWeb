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
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title></title>
</head>
<body>
<DIV class="col-xs-12 col-md-9">

    <%
        int currentpage;
        String cp = request.getParameter("currentpage");
        String keyword = request.getParameter("keyword");
        keyword = URLDecoder.decode(keyword, "UTF-8");
        page p;
        int totalpage;
        boolean hasnextpage;
        if (cp != null && cp.length() > 0) {
            currentpage = Integer.parseInt(cp);
            if (currentpage < 1) {
                currentpage = 1;
            }
        } else {
            currentpage = 1;
        }
        int totalcount = BasicDao.count(article.class, "where tree_level=1 and text like '%" + keyword + "%'");// 总记录数(totalCount)
        if(totalcount !=0){

            p = pageUtil.createPage(10, totalcount, currentpage);//每页显示10个记录
            totalpage = p.getTotalPage();                                       //总页数(totalPage)
            hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
        }
        else{
            totalcount = BasicDao.count(article.class, "where tree_level=1 and title like '%" + keyword + "%'");// 总记录数(totalCount)
            if(totalcount !=0){
                p = pageUtil.createPage(10, totalcount, currentpage);//每页显示10个记录
                totalpage = p.getTotalPage();                                       //总页数(totalPage)
                hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
            }else{
                totalcount = BasicDao.count(Tag.class, "where tag_name like '%" + keyword + "%'");// 总记录数(totalCount)
//                int article_id = BasicDao.count(articleTag.class, "where tag_id " + tag_id);
//                totalcount = BasicDao.count(article.class, "where tree_level=1 and article_id " + article_id);
                p = pageUtil.createPage(10, totalcount, currentpage);//每页显示10个记录
                totalpage = p.getTotalPage();                                       //总页数(totalPage)
                hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
            }
        }
//        else{
//            totalcount = BasicDao.count(article.class, "where tree_level=1 and title like '%" + keyword + "%'");// 总记录数(totalCount)
//            p = pageUtil.createPage(10, totalcount, currentpage);//每页显示10个记录
//            totalpage = p.getTotalPage();                                       //总页数(totalPage)
//            hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
//        }

    %>
    <p style="font-size:1.1em;">找到<strong><%=totalcount%>
    </strong>条搜索结果</p>
    <hr style="border-top: 1px solid #B9B7B7;margin-top: -8px;">
    <DIV class="col-xs-12 col-md-12">
        <div class="select col-md-12" id="select" style="margin-top: 0px;">

            <a class="pull-right" style="color: #F9F9F9;font-size: 1.2em;text-decoration: none;margin-top:10px;"
               href="/main/search.jsp?currentpage=<%=currentpage%>&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>">
                <img src="/Icons/shuaxin.png" width="18">刷新</a>

        </div>

        <div class="questions col-md-12">

            <%


                List<article> articles = pageDao.queryByPage("where tree_level=1 and text like '%" + keyword + "%'", article.class, p);//主题贴level为0，回复贴为1
                if(articles.size()==0){
                    articles = pageDao.queryByPage("where tree_level=1 and title like '%" + keyword + "%'", article.class, p);//主题贴level为0，回复贴
                    if(articles.size()==0){

                        List<Tag> tags = BasicDao.select("where tag_name like '%" + keyword + "%'", Tag.class);
                        for(Tag t :tags){

                            articleTag at = BasicDao.select("where tag_id=" +t.getTag_id(), articleTag.class).get(0);
                            articles.add(at.getA());
                          }

                    }
                }
                for (article a : articles) {
                    User u1 = a.getU();
                    String username = u1.getUsername();
                    String picture = u1.getHead();
                    String title = " ";
                    if (a.getTree_level() == 1) {
                        title = a.getTitle();
                    }
                    Date date = a.getDate();
                    String text = a.getText();
                    String atext;
                    if (text.length() <= 100) {
                        atext = text;
                    } else {
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
                                <a><%=username%>发表于&nbsp<%=date%>
                                </a>
                            </li>

                        </ul>
                        <p class="content">
                            <%=atext%><a href="/main/question.jsp?aid=<%=id%>">&nbsp点击查看</a>
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
                        <a href="/main/search.jsp?currentpage=<%=currentpage-1%>&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach var="page" begin="1" end="<%=totalpage%>">
                        <%
                            if (totalpage < 4) {
                        %>
                        <li class="active"><a
                                href="/main/search.jsp?currentpage=${page}&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>">${page}</a>
                        </li>
                        <%
                        } else {
                        %>
                        <c:if test="${page<3}">
                            <li class="active"><a
                                    href="/main/search.jsp?currentpage=${page}&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>">${page}">${page}</a>
                            </li>
                        </c:if>
                        <li class="active">...</li>

                        <%

                            if ((int) page > totalpage - 2) {
                        %>
                        <li class="active"><a
                                href="/main/search.jsp?currentpage=${page}&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>">${page}">${page}</a>
                        </li>

                        <%
                                }
                            }
                        %>
                    </c:forEach>
                    <li>
                        <c:choose>
                            <c:when test="<%=hasnextpage%>">
                                <a href="/main/search.jsp?currentpage=<%=currentpage+1%>&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="/main/search.jsp?currentpage=<%=currentpage%>&keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>

                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li>
                        <form action="/main/search.jsp?keyword=<%=URLEncoder.encode(keyword, "UTF-8")%>" method="post">
                            <input type="text" name="currentpage"/>&nbsp<input type="submit" value="→"/>
                        </form>
                    </li>
                </ul>
            </nav>
        </div>
    </DIV>
</DIV>
</body>
</html>
