<%@ page import="util.KeyConst" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/24
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<h1>Database Error</h1>
<h3><%=request.getParameter(KeyConst.REASON)%>></h3>
</body>
</html>
