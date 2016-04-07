<%@ page import="DAO.BasicDao" %>
<%@ page import="DAO.pageDao" %>
<%@ page import="entity.*" %>
<%@ page import="util.KeyConst" %>
<%@ page import="util.PathConst" %>
<%@ page import="util.pageUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>望闻问切</title>

    <LINK rel=stylesheet href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/personCenter.css">
    <link rel="stylesheet" href="../css/qContent.css">
    <link rel="stylesheet" href="../css/questionshow.css">
    <link rel="stylesheet" href="../css/index.css">
    <style type="text/css">
        a{
            text-decoration: none;
        }
    </style>
    <script src="../js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/register.js"></script>
    <script src="../js/login.js"></script>
    <!--检查回访到期-->

    <%
        User u=(User)session.getAttribute("user");
        int userId = u.getUid();
    %>
    <META name=GENERATOR content="MSHTML 8.00.7601.18210">

    <meta name="viewport" content="width=device-width initial-scale=1">

</head>
<BODY>
<!--导航栏-->

<jsp:include page="/module/navbar.jsp" flush="true"/>


<%
    String headTitle;
    int aid=Integer.parseInt(request.getParameter("aid"));   //帖子的id
    List<article> as= BasicDao.select("where article_id="+aid+" order by date desc",article.class); //从数据库得到帖子
    article a=new article();
    for(article a1:as){
        a=a1;
    }
    String title=a.getTitle();
    User u1=a.getU();
    int autherId = u1.getUid();
    int treeLevel = a.getTree_level();
    if(treeLevel == 1){
        headTitle = "问题详情：";
    }else{
        headTitle = "答案详情：";
//        title = "reply to "+a.getParentArticle().getTitle();
    }
    String username=u1.getUsername().startsWith("Passenger:")?"游客":u1.getUsername();
    String picture=u1.getHead();
    Date date=a.getDate();
    int care=BasicDao.count(UserFavoriteArticle.class, "where article_id =" + aid);
    String text=a.getText();
    String sql="where tag_id in(select tag_id from articletag where article_id="+aid+")";
    List<Tag> tags= BasicDao.select(sql, Tag.class);

    String sql1="where article_id="+aid+" and thumb_or_step =1";
    int thumb=BasicDao.count(articleJudgement.class,sql1);//赞数
    String sql2="where parent_article="+aid;
    int argu=BasicDao.count(article.class,sql2);//评论数
    int step=BasicDao.count(articleJudgement.class,"where article_id="+aid+" and thumb_or_step =-1");
%>

<div class="container-fluid" style=" font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, STHeiti, 'Microsoft Yahei', sans-serif;margin-top: 50px;padding:0;">

    <!--题目-->
    <div style=" width:100%;min-height:130px;background:#f2f1f1">
        <div  class="container" style="">
            <div class="col-md-9">
                <!-- 位置信息-->
                <div class="current-position" style="margin-top: 10px;margin-bottom:20px;">

                    <a style="text-decoration:none;">
                        <EM>
                            <%=headTitle%>
                        </EM>
                        <I>&gt;&nbsp;</I>
                    </a>
                </div>
                <p class="title">
                    <A title="" href="/main/question.jsp?aid=<%=aid%>" >
                        <%=title%>
                    </A>
                </p>
                <div class="time">
                    <ul class="author list-inline" style="margin-bottom:0px;">
                        <li class="">
                            <img src="/user_data/<%=picture%>" width="30">
                            <%=username%>
                        </li>
                        <li class="">
                            <a style="text-decoration:none;"><%=date%>&nbsp发布</a>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="col-md-3">
                <p  style="margin-top:60px;">
                    <button class="btn btn-success" id="concern" onclick="javascript:window.location.href='/main/favourite.jsp?aid=<%=aid%>'">+  关&nbsp注</button>
                    <span>&nbsp共<strong>&nbsp<%=care%>&nbsp</strong>关注</span>
                </p>
            </div>

        </div>

    </div>

    <div  class="container" style="">
        <!--//左边方块-->
        <div class="col-xs-12 col-md-9">
            <%

                int currentpage=1;
                String cp=request.getParameter("currentpage");
                if(cp!=null&&cp.length()>0){
                    currentpage=Integer.parseInt(cp);
                    if(currentpage<1){
                        currentpage=1;
                    }
                }
                else{
                    currentpage=1;
                }
                int totalcount=BasicDao.count(article.class, "where parent_article="+aid);
                page p= pageUtil.createPage(5, totalcount, currentpage);
                int totalpage=p.getTotalPage();
                boolean hasnextpage= pageUtil.getHasNextPage(totalpage, currentpage);
            %>

            <!--问题详情-->
            <div class="col-md-12">
                <div class="current-question">
                    <div class="question-message" style="float:left;width: 100%;">
                        <div class="summary" style="margin-top: 20px;">
                            <p class="content" style="margin-top:30px;">
                                <%=text%>
                            </p>
                            <%
                                for(Tag t:tags){
                            %>
                            <span class="label label-success"><%=t.getTag_name()%></span>
                            <%
                                }
                            %>

                            <ul class="author list-inline pull-right">
                                <li class="">
                                    <img src="../Icons/zancheng.png" width="15"> <a href="/main/ThumbServlet?<%=KeyConst.ARTICLE_ID%>=<%=aid%>"style="text-decoration:none;">赞(<%=thumb%>)</a>
                                </li>
                                <li class="">
                                    <img src="../Icons/fandui.png" width="15"> <a href="/main/StepServlet?<%=KeyConst.ARTICLE_ID%>=<%=aid%>" style="text-decoration:none;">踩(<%=step%>)</a>
                                </li>
                              <%--  <li class="">
                                    <img src="../Icons/jubao.png" width="15"> <a>举报</a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 我的回答-->
            <div class="col-md-12">

                <ul class="nav nav-tabs" style="margin-top:25px;">
                    <li>
                        <p style="font-size: 1.2em;padding:0;">
                            我的回答
                        </p>
                    </li>
                </ul>
                <form action="/main/ReplyServlet?parent_id=<%=aid%>"  method="post" style="margin-top:15px;">
                    <div class="form-group">
                        <textarea class="form-control" id="" placeholder="请输入您的答案……" name="<%=KeyConst.TEXT%>"></textarea>
                        <div class="post" style="background: #D6D6D6">
                            <div class="pull-left">
                                <a><img src="../Icons/exp.png" width="25" style="margin:10px 5px;"></a>
                                <a><img src="../Icons/pic.png" width="22" style="margin:10px 5px;"></a>
                            </div>
                            <div class="pull-right">
                                <INPUT class="btn btn-primary" style="background-color: #0599C1;margin: 5px;border-color: #06A6D2;" value="发布答案" type="submit"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>


            <!-- 所有答案 -->
            <div class="col-md-12">

                <div class="answers" style="margin-top:25px;">
                    <ul class="nav nav-tabs">
                        <li>
                            <p style="font-size: 1.2em;padding:0;"style="text-decoration:none;">
                                共<I><%=argu%></I>个回答
                            </p>
                        </li>
                    </ul>
                    <!--显示单个回答内容-->
                    <%

                        List<article> at1=pageDao.queryByPage("where parent_article=" + aid+" order by date desc", article.class, p);
                        for(article a1:at1){
                            User u2=a1.getU();
                            String name=u2.getUsername();
                            int uid=u2.getUid();
                            Date d=a1.getDate();
                            String atext= a1.getText();
                            int childid=a1.getArticle_id();
                            String sql3="where article_id="+childid+" and thumb_or_step =1";
                            int thumb1=BasicDao.count(articleJudgement.class,sql3);//赞数
                            String sql4="where parent_article="+childid;
                            int argu1=BasicDao.count(article.class,sql4);//评论数
                            int step1=BasicDao.count(articleJudgement.class,"where article_id="+childid+" and thumb_or_step =-1");
                    %>

                    <div class="question_list answerBox" style="padding:20px 10px 30px 10px;">
                        <div class="summary">
                            <ul class="author list-inline">
                                <li>
                                    <A href="" rel=nofollow>
                                        <IMG class="img-circle" src="/user_data/<%=u2.getHead()%>" width=30>
                                    </A>
                                    <a style="text-decoration:none;">
                                        <span><%=name%></span>
                                    </A>
                                    <span>&nbsp</span>
                                    <a style="text-decoration:none;">
                                        <span><%=d%></span>
                                        &nbsp回答
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div style="padding:10px 10px;">
                            <p>
                                <%=atext%>
                            </p>
                        </div>
                        <div class="time">
                            <ul class="author list-inline" style="margin-bottom:0px;">
                                <li class="huifubox">
                                    <img src="/Icons/huifu.png" width="15"><a> 回复(<%=argu1%>)</a>
                                </li>
                                <li class="">
                                    <img src="/Icons/zancheng.png" width="15"><a href="/main/ThumbServlet?<%=KeyConst.ARTICLE_ID%>=<%=childid%>"> 赞(<%=thumb1%>)</a>
                                </li>
                                <li class="">
                                    <img src="/Icons/fandui.png" width="15"><a href="/main/StepServlet?<%=KeyConst.ARTICLE_ID%>=<%=childid%>"> 踩(<%=step1%>)</a>
                                </li>
                                <li class="">
                                    <img src="/Icons/shanchu.png" width="15"><a href="<%=PathConst.ServletPath.delete_servlet%>?<%=KeyConst.ARTICLE_ID%>=<%=childid%>" class="delete"> 删除</a>
                                </li>
                               <%-- <li class="">
                                    <img src="/Icons/jubao.png" width="15"><a> 举报</a>
                                </li>--%>
                            </ul>
                        </div>
                        <div class="comment commentbox" style="display:none;">
                            <i class="icon icon-spike zm-comment-bubble" style="display: inline;"></i>
                        <%
                            List<article> lv3=BasicDao.select("where parent_article="+childid,article.class);
                            for(article cchild:lv3){
                                int ccid=cchild.getArticle_id();
                                User u3=cchild.getU();
                                String name1=u3.getUsername();
                                String head=u3.getHead();
                                String text1=cchild.getText();
                                Date d1=cchild.getDate();

                        %>

                            <div class="pinglun">
                                <div class="chil-touxiang">
                                    <img src="/user_data/<%=u3.getHead()%>" width="30">
                                </div>
                                <p>
                                    <strong><%=name1%></strong>: <%=text1%>
                                </p>
                                <div class="time">
                                    <ul class="author list-inline" style="margin-bottom:0px;">
                                        <li class="">
                                            <a>&nbsp&nbsp<%=d1%>&nbsp</a>
                                        </li>
                                        <li class="">
                                            <img src="/Icons/huifu.png" width="15"><a> 回复</a>
                                        </li>
                                        <li class="">
                                            <img src="/Icons/shanchu.png" width="15"><a class="delete"> 删除</a>
                                        </li>
                                       <%-- <li class="">
                                            <img src="/Icons/jubao.png" width="15"><a> 举报</a>
                                        </li>--%>
                                    </ul>
                                </div>
                            </div>

                            <%
                                boolean hasnext=true;
                                int id=ccid;
                                while(hasnext){
                                    List<article> reply=BasicDao.select("where parent_article="+id,article.class);
                                    hasnext=(reply.size()>0);
                                    if(hasnext){
                                        article parent=BasicDao.selectById(id,article.class);
                                        User u5=parent.getU();
                                        for(article res:reply){
                                            User u4=res.getU();
                                            int rid=u4.getUid();

                                            String aname=u4.getUsername();
                                            String bname=u5.getUsername();
                                            String ctext=res.getText();
                                            Date d2=res.getDate();
                                            id=res.getArticle_id();

                            %>
                            <div class="pinglun">
                                <div class="chil-touxiang">
                                    <img src="/user_data/<%=u4.getHead()%>" width="30">
                                </div>
                                <p>
                                    <strong><%=aname%></strong>回复<strong><%=bname%></strong>:<%=ctext%>
                                </p>
                                <div class="time">
                                    <ul class="author list-inline" style="margin-bottom:0px;">
                                        <li class="">
                                            <a>&nbsp&nbsp<%=d2%>&nbsp</a>
                                        </li>
                                        <li class="">
                                            <img src="/Icons/huifu.png" width="15"><a> 回复</a>
                                        </li>
                                        <li class="">
                                            <img src="/Icons/shanchu.png" width="15"><a class="delete"> 删除</a>
                                        </li>
                                       <%-- <li class="">
                                            <img src="/Icons/jubao.png" width="15"><a> 举报</a>
                                        </li>--%>
                                    </ul>
                                </div>
                            </div>
                            <%
                                            }
                                        }
                                    }}
                            %>



                            <form method="post" action="/main/ReplyServlet?parent_id=<%=childid%>" style="margin-top:15px;">
                            <div class="form-group">
                            <textarea name="text" class="form-control" id="myAnswer" placeholder="请输入您的答案……" name="<%=KeyConst.TEXT%>"></textarea>
                            <div class="post" style="background: #D6D6D6">
                            <div class="pull-left">
                            <a><img src="../Icons/exp.png" width="25" style="margin:10px 5px;"></a>
                            <a><img src="../Icons/pic.png" width="22" style="margin:10px 5px;"></a>
                            </div>
                            <div class="pull-right">
                            <INPUT class="btn btn-primary" style="background-color: #0599C1;margin: 5px;border-color: #06A6D2;" value="发表回复" type="submit"/>
                            </div>
                            </div>
                            </div>
                            </form>
                        </div>
                    </div>
                    <hr>


                    <%
                        }
                    %>
                    <!--显示单个回答内容-->

                    <!--分页-->
                    <nav>
                        <ul class="pagination">
                            <li>
                                <a href="question.jsp?currentpage=<%=currentpage-1%>&&aid=<%=aid%>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <%
                                for(int page1=1;page1<=totalpage;page1++){
                            %>
                            <%
                                if(totalpage<4){
                            %>
                            <li class="active"><a href="question.jsp?currentpage=<%=page1%>&&aid=<%=aid%>"><%=page1%></a></li>
                            <%
                            }else{
                            %>
                            <%
                                if(page1<3 || page1>totalpage-2){
                            %>
                            <li class="active"><a href="question.jsp?currentpage=<%=page1%>&&aid=<%=aid%>"><%=page1%></a></li>
                            <%
                            }else{%>
                            <li class="active">...</li>


                            <%
                                        }}}
                            %>
                            <li>
                                <%
                                    if(hasnextpage){

                                %>
                                <a href="question.jsp?currentpage=<%=currentpage+1%>&&aid=<%=aid%>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                                <%
                                }else{
                                %>
                                <a href="question.jsp?currentpage=<%=currentpage%>&&aid=<%=aid%>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                    </a>
                                        <%

                                        }%>

                            </li>
                            <li>
                                <div  style="position:absolute;margin-top:2px;left:250px;">
                                    <form class="form-inline" action="question.jsp?aid=<%=aid%>" method="post">
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



        <!--右边方块-->
        <jsp:include page="/module/rightpart.jsp"/>

    </div>


</div>
</div>

<script type="text/javascript" language="javascript">



        $(".huifubox").click(function(){
            $(this).parent().parent().next().slideToggle();
        });
</script>

<script>
    window.onload = function(){
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            navItems[i].className = "";
        }
        var userId =  <%=userId%>;
        var autherId = <%=autherId%>;
        if(userId != autherId){
            $(".delete").click(function(){
                alert("您没有删除的权限，因为这不是您的帖子！");
                return false;
            });
        }
    }
</script>

</div>
</BODY>
</html>
