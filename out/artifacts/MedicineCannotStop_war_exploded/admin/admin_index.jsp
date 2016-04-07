<%@ page import="DAO.BasicDao" %>
<%@ page import="entity.article" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Tag" %>
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
<%--搜索表单--%>
<form action="admin_index.jsp" method="post">


    <input name="keyword" type="text" placeholder="输入关键字搜索"  value=""
           style="width: 180px;"/>
        <input type="submit" value="搜索"/>
    <br>
    <input type="radio" value="1" name="content"/>按标题&nbsp;&nbsp;
    <input type="radio" value="2" name="content"/>按标签&nbsp;&nbsp;
    <input type="radio" value="3" name="content"/>按全文&nbsp;&nbsp;
    <input type="radio" value="4" name="content"/>发表时间在
    <select name="time">
        <option selected="selected" value="1">过去一天</option>
        <option value="7">过去一周</option>
        <option value="30">过去一个月</option>
        <option value="0">所有记录</option>
    </select>

</form>
<br>
<br>
<%
    boolean result=false;
    List<article> articles=new ArrayList<article>() ;
    String content=request.getParameter("content");
    String search=request.getParameter("keyword");
    String keyword;
    if(search==null||search.length()<1){  keyword="\'%%\'";}else{
     keyword="\'%"+search+"%\'";}


        if(content==null||content.length()<1){
            articles= BasicDao.select("where title like "+keyword+" or article_id like "+keyword+" or author like "+keyword+" or text like "+keyword+" or date like "+keyword,article.class);
            result=true;
        }else{
        int lab=Integer.parseInt(content);
        switch(lab){
            case 1:

                articles= BasicDao.select("where title like "+keyword,article.class);
                result=true;
                break;
            case 2:
                List<Tag> tags=BasicDao.select("where tag_name like"+keyword,Tag.class);
                if(tags.size()>0){
                    for(Tag t:tags){
                        List<article>at=BasicDao.select("where article_id in(select article_id from articletag where tag_id="+t.getTag_id()+")",article.class);
                        if(at.size()>0){
                            articles.addAll(at);
                        }}
                }
                result=true;
                break;
            case 3:
                articles=BasicDao.select("where text like"+keyword,article.class);
                result=true;
                break;
            case 4:
                int time=Integer.parseInt(request.getParameter("time"));
               if(time!=0) {
                   articles = BasicDao.select("where date>SUBDATE(NOW(),INTERVAL " + time + " day)", article.class);
               }else {
                   articles = BasicDao.select("where date like "+keyword, article.class);
                }
                result=true;
                break;
        }
    }



%>
<br>
<div class="container" style=" font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, STHeiti, 'Microsoft Yahei', sans-serif;margin-top: 70px;">
    <ul class="nav nav-pills">
        <li role="presentation" class="active"><a href="admin_index.jsp">帖子管理</a></li>
        <li role="presentation"><a href="admin_user.jsp">用户管理</a></li>
    </ul>

    <div class="">
        <div class="content" style="border-radius: 2px;border: 1px solid #D6D3D3;height: 100%;padding: 40px 20px;">
            <br><br>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <TR >
                        <th>标题</th>
                        <th>发帖人</th>
                        <th>添加时间</th>
                        <th>查看(要删除请先点进去查看)</th>
                    </TR>
                    </thead>

                    <tbody>
                    <%
                        if(!result){
                         articles = BasicDao.select("where tree_level='" + article.MAIN + "'", article.class);}
                        for (article a : articles) {
                    %>
                    <tr>
                        <td><%=a.getTitle()%>
                        </td>
                        <td><%=a.getU().getUsername()%> (ID: <%=a.getU().getUid()%>)</td>
                        <td><%=a.getDate()%>
                        </td>
                        <td><a href="/admin/read_article.jsp?aid=<%=a.getArticle_id()%>">点击查看详情</a></td>
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