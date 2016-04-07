<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>望闻问切</title>

    <LINK rel=stylesheet href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/index.css">

    <link rel="stylesheet" href="/css/questionshow.css">

    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/register.js"></script>
    <script src="/js/login.js"></script>


    <META name=GENERATOR content="MSHTML 8.00.7601.18210">

    <meta name="viewport" content="width=device-width initial-scale=1">
</head>
<BODY style="background:#f2f1f1">
<!--导航栏-->

<jsp:include page="/module/navbar.jsp" flush="true"/>


<div class="container" style=" font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, STHeiti, 'Microsoft Yahei', sans-serif;margin-top: 70px;">

     <br><br>
    <%
        String keyword = request.getParameter("keyword");
            keyword = URLEncoder.encode(keyword, "UTF-8");
        %>
        <jsp:include page="/module/searchList.jsp" flush="true">
            <jsp:param name="keyword" value="<%=keyword%>"/>
        </jsp:include>
    

    <!--显示相关的问题-->
    <!--右边方块-->
    <div class="col-xs-12 col-md-3 hidden-sm hidden-xs">
        <jsp:include page="/module/rightpart.jsp"/>
    </div>



</div>
</div>


</div>
</BODY>
</html>