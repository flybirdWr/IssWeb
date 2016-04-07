<%@ page import="DAO.BasicDao" %>
<%@ page import="DAO.pageDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="entity.article" %>
<%@ page import="entity.page" %>
<%@ page import="util.pageUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/16 0016
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<%--未回访分页--%>
<%
    int passid = 0;
    User u = (User) session.getAttribute("user");
    int id = u.getUid();

    int currentpage1 = 1;
    String cp1 = request.getParameter("currentpage1");
    if (cp1 != null && cp1.length() > 0) {
        currentpage1 = Integer.parseInt(cp1);
        if (currentpage1 < 1) {
            currentpage1 = 1;
        }
    } else {
        currentpage1 = 1;
    }
    int totalcount1 = BasicDao.count(UserFavoriteArticle.class, "where uid=" + id + " and due_time=start_date");
    page p1 = pageUtil.createPage(5, totalcount1, currentpage1);
    int totalpage1 = p1.getTotalPage();
    boolean hasnextpage1 = pageUtil.getHasNextPage(totalpage1, currentpage1);
%>
<body>
<%--2015 11 25 立碑纪念此蛋疼bug 前事不忘 后事之师 --%>
<%--<div class="row email table-responsive" style="display: block">--%>
<div class="row email table-responsive" style="display: block; margin-left:20px;">
    <table class="table table-hover table-striped">
        <thead>
        <TR>
            <th>标题</th>
            <th>查看</th>
            <th>是否关注</th>
            <th>发帖人</th>
            <th>发表时间</th>
        </TR>
        </thead>
        <tbody>
        <%
            List<UserFavoriteArticle> ufaNoReturn = pageDao.queryByPage("where uid=" + id + " and due_time=start_date order by due_time asc", UserFavoriteArticle.class, p1);
            if (ufaNoReturn.size() > 0) {

                for (UserFavoriteArticle ufa1 : ufaNoReturn) {
                    article a1 = ufa1.getA();
                    String title = a1.getTitle();
                    int aid = a1.getArticle_id();
                    passid = aid;
                    User u1 = ufa1.getU();
                    String name = u1.getUsername();
                    Date d1 = a1.getDate();
        %>

        <tr>
            <td align=""><%=title%>
            </td>
            <td align="">
                <a href="../main/question.jsp?aid=<%=aid%>">查看内容</a>
            </td>
            <td align="">
                <a href="/servlet/personalCenterServlet?operation=4&&aid=<%=aid%>">取消关注</a>
            </td>
            <td align=""><%=name%>
            </td>
            <td align=""><%=d1%>
            </td>
        </tr>
        <%
            }
        }else{
            String showMessage = "您还没有关注任何问题哟，快去看一看有没有你感兴趣的吧";
        %>
        <tr>
            <td colspan="8"><%=showMessage%></td>
        </tr>
        <%
            }
        %>

        </tbody>


        <tfoot>
        <tr>
            <td align="center" colspan="13">
                <!--不回访分页-->
                <nav>
                    <ul class="pagination" id="pagination">
                        <li>
                            <a href="../personalCenter/concern.jsp?currentpage1=<%=currentpage1-1%>"
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
                        <li class=""><a href="../personalCenter/concern.jsp?currentpage1=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {
                        %>
                        <%
                            if (page1 < 3 || page1 > totalpage1 - 2) {
                        %>
                        <li><a href="../personalCenter/concern.jsp?currentpage1=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {%>
                        <li>...</li>


                        <%
                                    }
                                }
                            }
                        %>
                        <li>
                            <%
                                if (hasnextpage1) {

                            %>
                            <a href="../personalCenter/concern.jsp?currentpage1=<%=currentpage1+1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%
                            } else {
                            %>
                            <a href="../personalCenter/concern.jsp?currentpage1=<%=currentpage1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%

                                }%>

                        </li>

                        <li>
                            <div  style="position:absolute;margin-top:2px;left:650px;">
                                <form class="form-inline" action="/personalCenter/concern.jsp" method="post">
                                    <input type="text" name="currentpage" style="width: 40px;height: 30px;border: 1px solid #949494;border-radius: 2px;">
                                    <input class="btn btn-primary" type="submit" value="跳至该页" style="padding: 3px 5px;">
                                </form>
                            </div>
                        </li>
                    </ul>
                </nav>
            </td>
        </tr>
        </tfoot>

    </table>
</div>
<script src="../js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript">
        $(function(){
            var reg = new RegExp("(^|&)"+ "currentpage1" +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if(r ==null){
                $("#pagination li").eq(1).addClass("active");
            }else{
                var currentPage1=unescape(r[2]);
                $("#pagination li").eq(currentPage1).addClass("active");
            }
                $("#pagination li").click(function (e){
                    var page = $.trim($(e.target).text());
                    $("#pagination").find("li").eq(page).addClass("active").siblings().removeClass("active");
                }) ;
        })

    </script>
</body>


</html>
