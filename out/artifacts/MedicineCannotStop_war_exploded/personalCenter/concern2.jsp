<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>个人中心</title>
    <LINK rel=stylesheet href="../css/bootstrap.min.css">

    <link rel="stylesheet" href="../css/personCenter.css">
    <link rel="stylesheet" href="../css/questionshow.css">
    <link rel="stylesheet" href="../css/index.css">


    <script src="../js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>
<BODY style="background:rgb(236,235,235)">
<!--导航栏-->
<jsp:include page="/module/navbar.jsp" flush="true"/>

<%
    int passid=0;
    User u=(User)session.getAttribute("user");
    String username=u.getUsername();
    String picture=u.getHead();
    int id=u.getUid();
    List<UserFavoriteArticle> ufa=BasicDao.select("where uid=" + id + " and due_time<>start_date order by due_time asc", UserFavoriteArticle.class);

    Date now=new Date();
%>

<div class="container-fluid">
    <div class="container">
        <!--左边方块-->
        <div class="col-md-9">
            <div class="quesions">
                <div class="tab-title" id="tab-title">
                    <ul class="nav nav-tabs nav-tabs-zen">
                        <li class="active">
                            <A>参与回访</A>
                        </li>
                        <li>
                            <A>不回访</A>
                        </li>
                    </ul>
                </div>

                <div class="tab-content" id="tab-content">
                    <!--设置资料-->
                    <div class="row feedback table-responsive" style="display:block">

                        <jsp:include page="/module/myconcern_feedback.jsp"/>
                    </div>
                    <div class="row feedback table-responsive" style="display: none">

                        <jsp:include page="/module/myconcern_nofeedback.jsp"/>

                    </div>
                </div>
            </div>
        </div>

        <!--右边方块-->
        <div class="col-xs-12 col-md-3 hidden-sm hidden-xs">

            <div class="xingqu-message row">
                <h1 class="title">
                    <p style="font-weight:600;margin:30px 0 25px 10px;">你可能感兴趣>></p>
                    <ul>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病啦啦啦啦啦啦？</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 已悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病？？？喵呜</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 未悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病啦啦啦啦啦啦？</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 已悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病？？？喵呜</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 未悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病啦啦啦啦啦啦？</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 已悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病？？？喵呜</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 未悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病啦啦啦啦啦啦？</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 已悬赏
                            </small>
                        </li>
                        <li>
                            <a href="../main/question.html">程序员如何预防颈椎病啦啦啦啦啦啦？</a>
                            <small style="display:inline-block;font-size:0.9em;color:#777">
                                11评论 | 已悬赏
                            </small>
                        </li>

                    </ul>
                </h1>
            </div>

        </div>
    </div>

</div>
<div class="modal fade" id="huifangModal" tabindex="-2" role="dialog" data-show="true" style="margin-top:30px; padding:0 30px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" style="color: #565A55;font-family: fantasy;font-weight: 600;">设为回访*</h3>
            </div>
            <div class="modal-body">
                <!--关注的表单-->
                <form class="form-horizontal" role="form" style="font-size:0.8em;color:#333;margin-top:10px;"
                      action="/servlet/personalCenterServlet?aid=<%=passid%>" onsubmit="return checkform()"
                      method="post">
                    <div class="form-group">-
                        <label class="col-sm-3 control-label">
                            回访期限：
                        </label>

                        <div class="col-sm-7">
                            <select name="tianshu">
                                <option value="1">一天</option>
                                <option value="3">三天</option>
                                <option value="7">一星期</option>
                                <option value="30">一个月</option>
                                <option value="90">三个月</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label></label>

                        <div class="col-md-7 col-md-offset-3">
                            <button type="submit" class="btn btn-success">确 定</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<script>

    window.onload = function () {
        var titleName = document.getElementById("tab-title").getElementsByTagName("li");
        var tabContent = document.getElementById("tab-content").getElementsByClassName("feedback");
        if (titleName.length != tabContent.length) {
            return;
        }
        for (var i = 0; i < titleName.length; i++) {
            titleName[i].id = i;
            titleName[i].onclick = function () {
                for (var j = 0; j < titleName.length; j++) {
                    titleName[j].className = "";
                    tabContent[j].style.display = "none";
                }
                this.className = "active";
                tabContent[this.id].style.display = "block";
            }
        }


        /*菜单栏的显示*/
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            if(i==2){
                navItems[i].className = "active";
            }else{
                navItems[i].className = "";
            }
        }

        /*个人中心页面子菜单显示*/
        var headBlock = document.getElementById('headBlockid');
        var headItems = headBlock.getElementsByTagName('li');
        for(var j=0; j<headItems.length; j++){
            if(j==1){
                headItems[j].className = "active";
            }else{
                headItems[j].className = "";
            }
        }

    }



</script>

</body>

</html>