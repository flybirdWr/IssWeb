<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.article" %>
<%@ page import="entity.message" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/21 0021
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<%

  User u=(User)session.getAttribute("user");
  String username=u.getUsername();
  String picture=u.getHead();
  int id=u.getUid();
  List<article> art= BasicDao.select("where author=" + id + " and tree_level=1", article.class);
  int count=(int)session.getAttribute("count");
  Date now=new Date();


%>
<body>

<%
  String senderName="";
  String replytext="";
  String articletext="";
  String articleTitle="";
  Date time=new Date();
  int aid1=0;
%>
<%--我的帖子--%>
<h1 align="center">我的帖子</h1>
<br>

<%


  List<message> mes= BasicDao.select("where relative=" + id + " ORDER BY date desc", message.class);
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
          <img src="../Icons/shanchu.png" width="15"><a> 删除</a>
        </li>
        <li class="">
          <img src="../Icons/jubao.png" width="15"><a> 举报</a>
        </li>
      </ul>
    </div>
  </div>
</div>

</body>
</html>