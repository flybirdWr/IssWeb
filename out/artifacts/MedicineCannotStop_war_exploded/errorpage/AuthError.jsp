<%@ page import="util.KeyConst" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/31
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
  <h1>Authentication Error</h1>
  <h3><%=request.getParameter(KeyConst.REASON)%>></h3></h3>
</body>
</html>
