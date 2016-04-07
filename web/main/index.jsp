<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.Tag" %>
<%@ page import="entity.User" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="entity.article" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>望闻问切</title>

    <LINK rel=stylesheet href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/index.css">

    <link rel="stylesheet" href="../css/questionshow.css">

    <script src="../js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/register.js"></script>
    <script src="../js/login.js"></script>

    <%
        User u = (User) session.getAttribute("user");//取得Session的User
        int userid=u.getUid();
    %>
    <META name=GENERATOR content="MSHTML 8.00.7601.18210">

    <meta name="viewport" content="width=device-width initial-scale=1">

</head>
<BODY style="background:#f2f1f1">

<jsp:include page="/module/navbar.jsp" flush="true"/>

<div class="container" style="margin-top: 70px;">

    <!--左边方块-->
    <jsp:include page="/module/questionList.jsp"/>


    <!--右边方块-->
    <div class="col-xs-12 col-md-3 hidden-sm hidden-xs">
        <%
            if (u != null) {
                int uid = u.getUid();
                String nickname = u.getUsername();
                String picture = u.getHead();
                int care = BasicDao.count(UserFavoriteArticle.class, "where uid =" + uid);//关注帖子数
                int post = BasicDao.count(article.class, "where author=" + uid + " and tree_level=1");
        %>
        <div class="user-message row">
            <div class="">
                <div class="user-bg">
                    <div class="col-md-6 col-md-offset-3">
                        <img src="/user_data/<%=u.getHead()%>" class="img-circle" width="90%">
                    </div>
                    <div class="col-md-12">

                        <p style="text-align: center;margin-top:2px;font-size:1.2em;font-weight:500"><%=nickname%>
                            &nbsp</p>
                        <!--<hr style="border-top: 1px solid #bdb8b8;margin-top:-10px;width:80%;margin-left:10%;">-->
                    </div>
                </div>
                <div class="col-md-12 user">
                    <ul>
                        <li>
                            <a>
                                帖子
                                <small><%=post%>
                                </small>
                            </a>
                        </li>
                        <li>
                            <a>
                                关注
                                <small><%=care%>
                                </small>
                            </a>
                        </li>
                        <li>
                            <a>
                                到期回访
                                <small><%=session.getAttribute("count")%>
                                </small>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <%
        } else {
        %>

        <div class="user-message row">
            <div class="">
                <div class="user-bg">
                    <div class="col-md-6 col-md-offset-3">
                        <img src="/user_data/<%=u.getHead()%>" class="img-circle" width="90%">
                    </div>
                    <div class="col-md-12">

                        <p style="text-align: center;margin-top:2px;font-size:1.2em;font-weight:500">游客&nbsp<a
                                style="font-weight:600">LV0</a></p>
                        <!--<hr style="border-top: 1px solid #bdb8b8;margin-top:-10px;width:80%;margin-left:10%;">-->
                    </div>
                </div>
            </div>
        </div>

        <%
            }
        %>

        <!-- <hr style="border-top: 1px solid #C1C0C0">-->
        <jsp:include page="/module/rightpart.jsp"/>

    </div>
</div>
</div>


</div>
<script>
    function $(id) {
        return typeof id == "string" ? document.getElementById(id) : id;
    }
    window.onload = function () {
        /*问题排序列表的显示*/
        var titleName = $("select").getElementsByTagName("li");
        for (var i = 0; i < titleName.length; i++) {
            titleName[i].id = i;
            titleName[i].onclick = function () {
                for (var j = 0; j < titleName.length; j++) {
                    titleName[j].className = "";
                }
                this.className = "active";
            }
        }


        /*菜单栏的显示*/
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            if(i==0){
                navItems[i].className = "active";
            }else{
                navItems[i].className = "";
            }
        }

    }
</script>
<script src="../js/jquery-2.1.3.min.js"></script>
<script type="text/javascript">
    $(function(){
        $(function(){
            var reg = new RegExp("(^|&)"+ "currentpage" +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if(r ==null){
                $(".pagination li").eq(1).addClass("active");
            }else{
                var currentPage1=unescape(r[2]);
                $(".pagination li").eq(currentPage1).addClass("active");
            }
            $(".pagination li").click(function (e){
                var page = $.trim($(e.target).text());
                $(".pagination").find("li").eq(page).addClass("active").siblings().removeClass("active");
            }) ;
        })
    })


</script>
</BODY>

</html>