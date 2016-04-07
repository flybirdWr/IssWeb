<%--
  Created by IntelliJ IDEA.
  User: WENKE
  Date: 2015/11/28
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <LINK rel=stylesheet href="/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/personCenter.css">
  <link rel="stylesheet" href="/css/qContent.css">
  <link rel="stylesheet" href="/css/questionshow.css">
  <link rel="stylesheet" href="/css/index.css">

  <script src="/js/jquery-2.1.3.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/register.js"></script>
  <script src="/js/login.js"></script>
  <title></title>
</head>
<%
  String aid = request.getParameter("aid");
  String referer = request.getHeader("Referer");
%>
<body>
<div class="" id="" tabindex="-2" role="" style="margin-top:30px; padding:0 30px;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" style="color: #565A55;font-family: fantasy;font-weight: 600;">关注*</h3>
      </div>
      <div class="modal-body">
        <!--关注的表单-->
        <form class="form-horizontal" role="form" style="font-size:0.8em;color:#333;margin-top:10px;" action="/servlet/AttentionServlet" method="post" >
          <div class="form-group">
            <label class="col-sm-3 control-label" style="font-size: 1.5em">
              回访期限：
            </label>
            <input type="hidden" name="aid" value="<%=aid%>"/>
            <input type="hidden" name="referer" value="<%=referer%>"/>
            <div class="col-sm-7">
              <select class="form-control" name="tianshu">
                <option value="0">不参与回访</option>
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
              <button type="submit" class="btn btn-success pull-right">确    定</button>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</body>
</html>
