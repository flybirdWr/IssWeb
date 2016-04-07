<%@ page import="DAO.BasicDao" %>
<%@ page import="DAO.pageDao" %>
<%@ page import="entity.User" %>
<%@ page import="entity.UserFavoriteArticle" %>
<%@ page import="entity.article" %>
<%@ page import="entity.page" %>
<%@ page import="util.pageUtil" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lazier
  Date: 2015/11/16 0016
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<%--回访分页--%>
<%
    User u = (User) session.getAttribute("user");
    int id = u.getUid();


    int currentpage = 1;
    String cp = request.getParameter("currentpage");
    if (cp != null && cp.length() > 0) {
        currentpage = Integer.parseInt(cp);
        if (currentpage < 1) {
            currentpage = 1;
        }
    } else {
        currentpage = 1;
    }
    int totalcount = BasicDao.count(UserFavoriteArticle.class, "where uid=" + id + " and due_time<>start_date");
    page p = pageUtil.createPage(5, totalcount, currentpage);
    int totalpage = p.getTotalPage();
    boolean hasnextpage = pageUtil.getHasNextPage(totalpage, currentpage);
%>

<body>

<div class="row ziliao table-responsive" style="display:block;margin-left:20px;">
    <table class="table table-hover table-striped">
        <thead>
        <TR>
            <th>标题</th>
            <th>回访期限</th>
            <th>状态</th>
            <th>查看</th>
            <th>是否回访</th>
            <th>是否关注</th>
            <th>发帖人</th>
            <th>发表时间</th>
        </TR>
        </thead>
        <tbody>
        <%

            Date now = new Date();
            List<UserFavoriteArticle> ufa = pageDao.queryByPage("where uid=" + id + " and due_time<>start_date order by due_time asc", UserFavoriteArticle.class, p);

            if (ufa.size() > 0 && ufa != null) {


                for (UserFavoriteArticle uf : ufa) {

                    article a = uf.getA();
                    String title = a.getTitle();
//                                            Date  sdate=uf.getStart_date();
//                                            Date edate=uf.getDue_time();
//                                            Calendar rightNow = Calendar.getInstance();
//                                            rightNow.setTime(sdate);
//                                            Long st1= rightNow.getTimeInMillis();
//                                            rightNow.setTime(edate);
//                                            Long et1=rightNow.getTimeInMillis();
//                                        Long day1=et1-st1;
//
//                                            int days=(day1.intValue())/7;
                    Date sdate = uf.getStart_date();
                    Date edate = uf.getDue_time();
                    Calendar rightNow = Calendar.getInstance();
                    rightNow.setTime(sdate);
                    Long st1 = rightNow.getTimeInMillis() / (1000 * 60 * 60 * 24);
                    rightNow.setTime(edate);
                    Long et1 = rightNow.getTimeInMillis() / (1000 * 60 * 60 * 24);
                    Long day1 = et1 - st1;

                    int days = day1.intValue();
                    String day = days + "天";
                    if (days > 30) {
                        days = days / 30;
                        day = days + "月";
                    }
                    boolean ischeck = uf.getIsChecked();
                    String back = "";
                    if (uf.getDue_time().before(now)) {

                        if (!ischeck) {
                            back = "已到期/未查看";
                        } else {
                            back = "已到期/已查看";
                        }
                    } else {
                        back = "未到期";
                    }
                    int aid = a.getArticle_id();

                    User u1 = a.getU();
                    String name = u1.getUsername();
                    Date d1 = a.getDate();


        %>
        <tr>
            <td align=""><%=title%>
            </td>

            <td align=""><%=days%>
            </td>

            <td align=""><%=back%>
            </td>
            <td align="">
                <a href="/servlet/personalCenterServlet?operation=6&&aid=<%=aid%>">查看内容</a>
            </td>
            <td align="">
                <a href="/servlet/personalCenterServlet?operation=1&&aid=<%=aid%>">取消回访</a>
            </td>
            <td align="">
                <a href="/servlet/personalCenterServlet?operation=2&&aid=<%=aid%>">取消关注</a>
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
                <!--回访分页-->
                <nav>
                    <ul class="pagination">
                        <li>
                            <a href="/personalCenter/concern.jsp?currentpage=<%=currentpage-1%>"
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
                        <li class=""><a href="/personalCenter/concern.jsp?currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {
                        %>
                        <%
                            if (page1 < 3 || page1 > totalpage - 2) {
                        %>
                        <li class=""><a href="/personalCenter/concern.jsp?currentpage=<%=page1%>"><%=page1%>
                        </a></li>
                        <%
                        } else {%>
                        <li class="">...</li>


                        <%
                                    }
                                }
                            }
                        %>
                        <li>
                            <%
                                if (hasnextpage) {

                            %>
                            <a href="/personalCenter/concern.jsp?currentpage=<%=currentpage+1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                            <%
                            } else {
                            %>
                            <a href="/personalCenter/concern.jsp?currentpage=<%=currentpage%>" aria-label="Next">
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
        $(function(){
            var reg = new RegExp("(^|&)"+ "currentpage" +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if(r ==null){
                $(".pagination li").eq(1).addClass("active");
            }else{
                var currentPage1=unescape(r[2]);
                $(".pagination li").eq(currentPage1).addClass("active");
            }
            $(".pagination li").click(function (e){
                var page = $.trim($(e.target).text());
                $(".pagination").find("li").eq(page).addClass("active").siblings().removeClass("active");
            }) ;
        })
    })


</script>
</body>
</html>
