<%@ page import="DAO.BasicDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="entity.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page import="util.pageUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.pageDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>个人中心</title>
    <LINK rel=stylesheet href="../css/bootstrap.min.css">

    <link rel="stylesheet" href="../css/personCenter.css">
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/questionshow.css">



    <script src="../js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/register.js"></script>
    <script src="../js/login.js"></script>
</head>
<BODY style="background:rgb(236,235,235)">
<!--导航栏-->

        <%

            User u=(User)session.getAttribute("user");
            String username=u.getUsername();
            String picture=u.getHead();
            int id=u.getUid();
            List<article> art= BasicDao.select("where author=" + id + " and tree_level=1", article.class);
            int count=(int)session.getAttribute("count");
            Date now=new Date();


        %>
<jsp:include page="/module/navbar.jsp" flush="true"/>

<%--我的帖子分页--%>
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
    int totalcount = BasicDao.count(message.class, "");
    page p = pageUtil.createPage(10, totalcount, currentpage);
    int totalpage = p.getTotalPage();
    boolean hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
%>
<%--我的关注分页--%>
<%  int currentpage1 = 1;
    String cp1 = request.getParameter("currentpage1");
    if (cp1 != null && cp1.length() > 0) {
        currentpage1 = Integer.parseInt(cp1);
        if (currentpage1 < 1) {
            currentpage1 = 1;
        }
    } else {
        currentpage1 = 1;
    }
    int totalcount1 = BasicDao.count(message.class, "");
    page p1 = pageUtil.createPage(5, totalcount1, currentpage1);
    int totalpage1 = p1.getTotalPage();
    boolean hasnextpage1 = pageUtil.getHasNextPage(totalpage1, currentpage1);
%>

<body>
<div class="container-fluid">
<jsp:include page="/module/headerblock.jsp" flush="true"/>
    <div class="container">
        <div class="quesions">

            <%
                String senderName="";
                String replytext="";
                String articletext="";
                String articleTitle="";
                Date time=new Date();
                int aid1=0;
            %>
            <%--我的帖子--%>
            <h1 style="font-size: 26px;float: left;">我的帖子</h1>
            <br>
            <div class="quesions" style="min-height: 300px;">
                <%

                    ArrayList<UserFavoriteArticle> myCare=new ArrayList<>();
                    List<message> mes= pageDao.queryByPage("where relative=" + id + " ORDER BY date desc", message.class,p);
                    if(mes.size()>0){
                        for(message m:mes){

                            article a=m.getA();

                            aid1=a.getArticle_id();

                            List<article> ma11=BasicDao.select("where article_id="+aid1+" and author="+id,article.class);//先判定是自己的文章还是自己关注的文章
                            if(ma11.size()>0){



                                User relater=m.getU1();
                                User sender=m.getSender();
                                int uid1=sender.getUid();
                                article argus=new article();
                                articleTitle=a.getTitle();
                                senderName=sender.getUsername();
                                articletext=a.getText();
                                if(articletext.length()>50){
                                    articletext=articletext.substring(0,49)+"...";
                                }
                                time=m.getD();
                                List<article> aaa=BasicDao.select("where parent_article="+aid1+" and author="+uid1,article.class);
                                if(aaa.size()>0){

                                    //对自己文章的评论
                                    for(article a1:aaa){
                                        argus=a1;
                                    }


                                    replytext=argus.getText();




                %>

                <!-- 评论的消息-->
                <div class="about">
                    <div class="question" style="margin-top: 30px;padding: 10px 20px 10px 20px;border: 0px;background: #F1F1F1;">
                        <div class="author-message hidden-xs" style="float:left;width:50px;margin-left:0%;">
                            <img class="img-rounded" src="../images/Avatar.jpg" width="100%">
                        </div>
                        <p class="title">
                            <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                <%=senderName%>
                            </A>
                            <span style="color: #999;">评论</span>
                            ：<%=replytext%>
                        </p>
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <a>&nbsp&nbs<%=time%>&nbsp</a>
                                </li>
                            </ul>
                        </div>
                        <!-- 帖子的内容-->
                        <div class="about-box">
                            <!--<div class="author-message hidden-xs" style="float:left;width:10%;margin-left:0%;">-->
                            <!--<img class="img-rounded" src="../images/Avatar.jpg" width="100%">-->
                            <!--</div>-->


                            <div class="question-message" style="">
                                <div class="summary">

                                    <h1 class="title">
                                        <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                            <%=username%>：<%=articleTitle%>
                                        </A>
                                    </h1>

                                    <p class="content">
                                        <%=articletext%><a href="/main/question.jsp?aid=<%=aid1%>">查看详情</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!--评论-->
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <img src="../Icons/shanchu.png" width="15"><a href="/servlet/personalCenterServlet?operation=7&&aid=<%=aid1%>&&uid1=<%=uid1%>"> 删除</a>
                                </li>
                                <li class="">
                                    <img src="../Icons/jubao.png" width="15"><a> 举报</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>



                <%
                    //对自己文章的赞
                }else{
                %>
                <!-- 赞的消息-->


                <div class="about">
                    <div class="question" style="margin-top: 30px;padding: 10px 20px 10px 20px;border: 0px;background: #F1F1F1;">
                        <div class="author-message hidden-xs" style="float:left;width:50px;margin-left:0%;">
                            <img class="img-rounded" src="../images/Avatar.jpg" width="100%">
                        </div>
                        <p class="title">
                            <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                <%=senderName%>
                            </A>
                            <span style="color: #999;">赞了我</span>
                        </p>
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <a>&nbsp&nbsp<%=time%>&nbsp</a>
                                </li>
                            </ul>
                        </div>
                        <!-- 帖子的内容-->
                        <div class="about-box">
                            <!--<div class="author-message hidden-xs" style="float:left;width:10%;margin-left:0%;">-->
                            <!--<img class="img-rounded" src="../images/Avatar.jpg" width="100%">-->
                            <!--</div>-->


                            <div class="question-message" style="">
                                <div class="summary">

                                    <h1 class="title">
                                        <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                            <%=username%>：<%=articleTitle%>
                                        </A>
                                    </h1>

                                    <p class="content">
                                        <%=articletext%><a href="../main/question.jsp?aid=<%=aid1%>">查看详情</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!--评论-->
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <img src="../Icons/shanchu.png" width="15"><a href="/servlet/personalCenterServlet?operation=8&&aid=<%=aid1%>&&uid1=<%=uid1%>"> 删除</a>
                                </li>
                                <li class="">
                                    <img src="../Icons/jubao.png" width="15"><a> 举报</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%}%>


                <%
                            }else{
                    //获取我的关注
                    List<UserFavoriteArticle> ufaa=pageDao.queryByPage("where article_id=" + aid1 + " uid=" + id, UserFavoriteArticle.class,p1);
                    UserFavoriteArticle uu=new UserFavoriteArticle();
                    for(UserFavoriteArticle uu1:ufaa){
                        uu=uu1;
                    }
                    myCare.add(uu);

                }

                }}
                %>
                <!--我的帖子分页-->
                <nav>
                    <ul class="pagination">
                        <li>
                            <a href="message.jsp?currentpage=<%=currentpage-1%>"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <%
                            for (int page1 = 1; page1 <= totalpage; page1++) {
                        %>
                        <%
                            if (totalpage < 4) {
                        %>
                        <li class="active"><a href="message.jsp?currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {
                        %>
                        <%
                            if (page1 < 3 || page1 > totalpage - 2) {
                        %>
                        <li class="active"><a href="message.jsp?currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {%>
                        <li class="active">...</li>


                        <%
                                    }
                                }
                            }
                        %>
                        <li>
                            <%
                                if (hasnextpage) {

                            %>
                            <a href="message.jsp?currentpage=<%=currentpage+1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%
                            } else {
                            %>
                            <a href="message.jsp?currentpage=<%=currentpage%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%

                                }%>

                        </li>

                        <li>
                            <div  style="position:absolute;margin-top:2px;left:450px;">
                                <form class="form-inline" action="message.jsp" method="post">
                                    <input type="text" name="currentpage" style="width: 40px;height: 30px;border: 1px solid #949494;border-radius: 2px;">
                                    <input class="btn btn-primary" type="submit" value="跳至该页" style="padding: 3px 5px;">
                                </form>
                            </div>
                        </li>

                    </ul>
                </nav>
            </div>

            <%--这里开始是我的关注消息--%>
            <br>
            <h1 style="font-size: 26px;float: left;">我的关注</h1>
            <div class="quesions" style="min-height: 300px;">
                <%
                    for(UserFavoriteArticle ufa:myCare){
                        User u1=ufa.getU();
                        String name=u1.getUsername();
                        article aaa=ufa.getA();
                        aid1=aaa.getArticle_id();
                %>
                <div class="about">
                    <div class="question" style="margin-top: 30px;padding: 10px 20px 10px 20px;border: 0px;background: #F1F1F1;">
                        <div class="author-message hidden-xs" style="float:left;width:50px;margin-left:0%;">
                            <img class="img-rounded" src="../images/Avatar.jpg" width="100%">
                        </div>
                        <p class="title">
                            <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                <%=senderName%>
                            </A>
                            <span style="color: #999;">评论</span>
                            ：<%=replytext%>
                        </p>
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <a>&nbsp&nbs<%=time%>&nbsp</a>
                                </li>
                            </ul>
                        </div>
                        <!-- 帖子的内容-->
                        <div class="about-box">
                            <!--<div class="author-message hidden-xs" style="float:left;width:10%;margin-left:0%;">-->
                            <!--<img class="img-rounded" src="../images/Avatar.jpg" width="100%">-->
                            <!--</div>-->


                            <div class="question-message" style="">
                                <div class="summary">

                                    <h1 class="title">
                                        <A title="" href="../main/question.jsp?aid=<%=aid1%>" >
                                            <%=name%>：<%=articleTitle%>
                                        </A>
                                    </h1>

                                    <p class="content">
                                        <%=articletext%><a href="../main/question.jsp?aid=<%=aid1%>">查看详情</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!--评论-->
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="">
                                    <img src="../Icons/shanchu.png" width="15"><a> 删除</a>
                                </li>
                                <li class="">
                                    <img src="../Icons/jubao.png" width="15"><a> 举报</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>




                <%
                    }
                %>
                <nav>
                    <ul class="pagination">
                        <li>
                            <a href="message.jsp??currentpage1=<%=currentpage1-1%>"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <%
                            for (int page1 = 1; page1 <= totalpage1; page1++) {
                        %>
                        <%
                            if (totalpage1 < 4) {
                        %>
                        <li class="active"><a href="message.jsp??currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {
                        %>
                        <%
                            if (page1 < 3 || page1 > totalpage1 - 2) {
                        %>
                        <li class="active"><a href="message.jsp??currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {%>
                        <li class="active">...</li>


                        <%
                                    }
                                }
                            }
                        %>
                        <li>
                            <%
                                if (hasnextpage1) {

                            %>
                            <a href="message.jsp?currentpage=<%=currentpage1+1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%
                            } else {
                            %>
                            <a href="message.jsp??currentpage=<%=currentpage1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%

                                }%>

                        </li>
                        <li>
                            <div  style="position:absolute;margin-top:2px;left:450px;">
                                <form class="form-inline" action="message.jsp?" method="post">
                                    <input type="text" name="currentpage" style="width: 40px;height: 30px;border: 1px solid #949494;border-radius: 2px;">
                                    <input class="btn btn-primary" type="submit" value="跳至该页" style="padding: 3px 5px;">
                                </form>
                            </div>
                        </li>
                    </ul>
                </nav>
            </div>



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
            if(j==2){
                headItems[j].className = "active";
            }else{
                headItems[j].className = "";
            }
        }
    }



</script>
</body>
</html>