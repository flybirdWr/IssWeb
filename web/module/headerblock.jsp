<%@ page import="entity.User" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/21
  Time: 12:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <LINK rel=stylesheet href="../css/bootstrap.min.css">

  <link rel="stylesheet" href="../css/personCenter.css">
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/questionshow.css">


  <script src="../js/jquery-2.1.3.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
  <script src="../js/register.js"></script>
    <title></title>
</head>
<body>
<%
  User u=(User)session.getAttribute("user");
  String username = u.getUsername();
//  username = username.startsWith("Passenger:")?"游客":username;
%>
<div class="message">
  <div class="personal-message">
    <div class="box-img">
      <img src="/user_data/<%=u.getHead()%>" width="130">
    </div>
    <div class="jianjie">
      <h3><%=u.getUsername()%></h3>
      <p>个性签名：</p>
      <p class="gexingqian"><%=(u.getSignature()==null || u.getSignature().equals(""))?"主人比较懒, 还没写动态签名~":u.getSignature()%></p>
    </div>

  </div>
  <div class="nav-child">
    <div class="container">
      <ul id="headBlockid">
        <li class="active">
          <a href="/personalCenter/personCenter.jsp">
            我的帖子
          </a>
        </li>
        <li>
          <a href="/personalCenter/concern.jsp">
            我的关注
          </a>
        </li>
        <%--<li>--%>
          <%--&lt;%&ndash;<a href="/personalCenter/message.jsp">&ndash;%&gt;--%>
            <%--&lt;%&ndash;与我相关&ndash;%&gt;--%>
          <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
        <%--</li>--%>
        <li>
          <a href="javascript:return false;" class="setting">
            设置
          </a>
        </li>
      </ul>
    </div>
  </div>
</div>

<script src="../js/jquery-2.1.3.min.js"></script>
<script type="text/javascript">
  $(function(){
      var username = "";
      username = '<%=username%>';
      $("#headBlockid .setting").click(function (){
        var Start = username.indexOf("Passenger:");
        if(Start == 0) {
          if(confirm("是否先注册？")){
            window.location.href = "../register.html";
          }else{
            window.location.href="/personalCenter/setZiliao.jsp";
          }
        }else{
          window.location.href="/personalCenter/setZiliao.jsp";
        }
      }) ;
  })
</script>
</body>
</html>
