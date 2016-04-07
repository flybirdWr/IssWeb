<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="entity.article" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/19
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <LINK rel=stylesheet href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/index.css">

    <link rel="stylesheet" href="/css/questionshow.css">

    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/register.js"></script>
    <script src="/js/login.js"></script>
    <title></title>
</head>
<body>
<%
    User u = (User) session.getAttribute("user");
    int userid = u.getUid();
    int count = 0;
    List<UserFavoriteArticle> ufa = BasicDao.select("where uid=" + userid + " and IsChecked=0 and due_time<CURRENT_TIME and due_time>start_date", UserFavoriteArticle.class);
    Date now = new Date();                  //当前日期
    if (ufa.size() > 0 && ufa != null) {

        ArrayList<article> a1 = new ArrayList<>();
        for (UserFavoriteArticle uf : ufa) {
            if (uf.getDue_time().before(now)) {
                count++;
                a1.add(uf.getA());
            }
        }
    }
    session.setAttribute("count", count);
%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../main/index.jsp">
                <img src="/images/logo.png" height="40" style="margin-top:-10px;margin-left:-10px;">
            </a>
        </div>


        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <%--菜单选项列表--%>
            <ul class="nav navbar-nav" id="navSelectid">
                <li class="active"><a href="/main/index.jsp">首页<span class="sr-only">(current)</span></a></li>
                <li><a href="/personalCenter/personCenter.jsp">个人中心</a></li>
                <li><a href="/personalCenter/concern2.jsp">我的回访<span class="badge"><%=count%></span></a></li>
            </ul>
                <form action="/main/search.jsp" class="header-search pull-left hidden-sm hidden-xs">
                    <%--<input type="submit" class="btn btn-link" value="搜索"/>--%>
                       <button class="btn btn-link" type="submit">
                            <span class="sr-only">搜索</span>
                            <img src="../images/search-icon.png" width="25" style="margin-top: -3px;">
                        </button>
                    <input id="searchBox" name="keyword" type="text" placeholder="输入关键字搜索" class="form-control" value=""
                       style="width: 180px;">
                </form>


            <a href="../main/post.jsp">
                <button class="btn btn-primary" style="background-color: #0599C1;margin-top: 9px;">发帖</button>
            </a>

            <%--退出--%>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="/servlet/ExitServlet">
                        <img src="/Icons/tuichu.png" width="21" title="退出">
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script type="text/javascript">
    var count = <%=count%>;
    if(count==0){
        $(".badge").hide();
    }
</script>
</body>
</html>
