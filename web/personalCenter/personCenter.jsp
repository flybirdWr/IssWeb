<%@ page import="entity.User" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>个人中心</title>
    <LINK rel=stylesheet href="/css/bootstrap.min.css">

    <link rel="stylesheet" href="../css/personCenter.css">
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/questionshow.css">


    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/register.js"></script>
    <script src="../js/login.js"></script>
</head>
<BODY style="background:rgb(236,235,235)">
<!--导航栏-->
<jsp:include page="/module/navbar.jsp" flush="true"/>

<%
    int passid = 0;
    User u = (User) session.getAttribute("user");
    String username = u.getUsername();
    String picture = u.getHead();

%>

<div class="container-fluid">
    <jsp:include page="/module/headerblock.jsp" flush="true"/>
    <div class="container">
        <!--左边方块-->
        <jsp:include page="/module/mypost.jsp"/>


        <!--右边方块-->

        <jsp:include page="/module/rightpart.jsp"/>
    </div>
</div>


</div>

<script>

    window.onload = function () {

        /*菜单栏的显示*/
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            if(i==1){
                navItems[i].className = "active";
            }else{
                navItems[i].className = "";
            }
        }

        /*个人中心页面子菜单显示*/
        var headBlock = document.getElementById('headBlockid');
        var headItems = headBlock.getElementsByTagName('li');
        for(var j=0; j<headItems.length; j++){
            if(j==0){
                headItems[j].className = "active";
            }else{
                headItems[j].className = "";
            }
        }

    }



</script>

</body>
</html>