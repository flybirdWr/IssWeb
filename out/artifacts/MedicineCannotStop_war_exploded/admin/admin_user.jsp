<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.article" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>望闻问切</title>

    <LINK rel=stylesheet href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/index.css">


    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/register.js"></script>
    <script src="js/login.js"></script>


    <META name=GENERATOR content="MSHTML 8.00.7601.18210">

    <meta name="viewport" content="width=device-width initial-scale=1">
</head>
<BODY style="background:#f2f1f1">
<form action="admin_user.jsp" method="post">


    <input name="keyword" type="text" placeholder="输入关键字搜索" value=""
           style="width: 180px;"/>
    <input type="submit" value="搜索"/>
    <br>
    <input type="radio" value="1" name="content"/>按用户名&nbsp;&nbsp;


</form>
<br>
<br>
<%
    boolean result=false;
    List<User> users=new ArrayList<User>() ;
    String content=request.getParameter("content");
    String search=request.getParameter("keyword");
    String keyword;
    if(search==null||search.length()<1){  keyword="\'%%\'";}else{
        keyword="\'%"+search+"%\'";}


    if(content==null||content.length()<1){
        users= BasicDao.select("where username like "+keyword+" or uid like "+keyword+" or email like "+keyword+" or phone like "+keyword,User.class);
        result=true;
    }else{

       users= BasicDao.select("where username like "+keyword,User.class);
                result=true;

    }
%>
<br>
<div class="container" style=" font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, STHeiti, 'Microsoft Yahei', sans-serif;margin-top: 70px;">
    <ul class="nav nav-pills">
        <li role="presentation"><a href="admin_index.jsp">帖子管理</a></li>
        <li role="presentation" class="active"><a href="admin_user.jsp">用户管理</a></li>
    </ul>

    <div class="">
        <div class="content" style="border-radius: 2px;border: 1px solid #D6D3D3;height: 100%;padding: 40px 20px;">
            <br><br>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <TR >
                        <th>编号</th>
                        <th>用户名</th>
                        <th>密码</th>
                        <th>邮箱</th>
                        <th>问题数</th>
                        <th>用户状态</th>
                        <th>锁定用户</th>
                        <th>删除用户</th>
                    </TR>
                    </thead>

                    <tbody>
                    <%
                        if(!result){
                         users = BasicDao.select("", User.class);}
                        for (User user : users) {
                            int questionNo = BasicDao.count(article.class, "where author='" + user.getUid() + "'");
                    %>
                    <tr>
                        <td align="center"><%=user.getUid()%>
                        </td>
                        <td align="center"><%=user.getUsername()%>
                        </td>
                        <td align="center"><%=user.getPassword()%>
                        </td>
                        <td align="center"><%=user.getEmail()%>
                        </td>
                        <td align="center"><%=questionNo%>></td>
                        <td align="center"><%
                            switch (user.getStatus()) {
                                case User.FROZEN:
                                    out.print("冻结");
                                    break;
                                case User.ANONYMOUS:
                                    out.print("匿名");
                                    break;
                                case User.NORMAL:
                                    out.print("普通");
                                    break;
                                default:
                                    out.print("其他");
                                    break;
                            }
                        %></td>
                        <td align="center">
                            <%
                                if (user.getStatus() != User.FROZEN) {
                            %>
                            <a href="/admin/LockUserServlet?command=freeze&uid=<%=user.getUid()%>">锁定用户</a>
                            <%
                            } else {
                            %>
                            <a href="/admin/LockUserServlet?command=recover&uid=<%=user.getUid()%>">解除锁定</a>
                            <%
                                }
                            %>
                        </td>
                        <td align="center">
                            <a href="/admin/LockUserServlet?command=delete&uid=<%=user.getUid()%>">删除用户</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>

                </table>
            </div>

        </div>
    </div>
</div>
</div>


</div>
</BODY>
</html>