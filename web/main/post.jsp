<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="util.KeyConst" %>
<%@ page import="util.PathConst" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>

    <LINK rel=stylesheet href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/head.css">
    <link rel="stylesheet" href="../css/questionshow.css">

    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <title>发帖</title>
</head>
<BODY style="background:#f2f1f1">
<!--导航栏-->

<jsp:include page="/module/navbar.jsp" flush="true"/>


<DIV id=wrap>



    <div class="container" style="width: 100%; font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, STHeiti, 'Microsoft Yahei', sans-serif;margin-top: -20px;">
        <h3 style="margin-top: 30px;color: #0599C1;margin-bottom:3px;">发表帖子</h3>
        <hr style="border-top: 1px solid #C3C0C0;margin:0;">

        <div class="col-md-8 col-sm-12 col-xs-12" style="margin-top:20px;padding:30px;background:rgb(249,247,247);border-radius:10px;">
            <form class="form-horizontal" role="form" action="<%=PathConst.ServletPath.publish_servlet%>" onsubmit="return checkform()" method="post" >
                <div class="form-group">
                    <label class="sr-only control-label" for="fenshuid" style="font-weight:600;font-size: 1.2em;margin-right: -20px;color: #595757;">标题: </label>
                    <div class="col-md-12">
                        <input class="form-control" type="text" name="<%=KeyConst.TITLE%>" size="45" id="titleid" placeholder="标题:标题尽量简洁，突出主题" style="height:45px;font-size:1.2em;">
                    </div>
                </div>
                <div class="form-group">
                    <label class="sr-only control-label" for="fenshuid" style="font-weight:600;font-size: 1.2em;margin-right: -20px;color: #595757;">标签: </label>
                    <div class="col-md-12">
                        <input class="form-control" type="text" size="45" name="<%=KeyConst.TAG%>"  id="biaoqianid" placeholder="标签：用空格或半角逗号, 点号及分号分隔">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-12 pull-left" for="fenshuid" style="font-weight:600;font-size: 1.1em;margin-right: -20px;color: #595757;">内容：</label>
                    <div class="col-md-12">
                        <textarea name="<%=KeyConst.TEXT%>" class="form-control" rows="15" id="text"></textarea>
                        <div class="post">
                            <div class="pull-right">
                                <INPUT class="btn btn-primary" style="background-color: #0599C1;margin: 5px;border-color: #06A6D2;" value="发  布" type="submit" onclick="checkLen()"/>
                            </div>
                        </div>
                    </div>
                </div>


            </form>
        </div>
    </div>

</DIV>

<script>
    window.onload = function(){
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            navItems[i].className = "";
        }
    }
    function checkLen(){
//        window.alert("checkLen");
        var len = document.getElementById("text").value.length;
//        window.alert(len);
        if(len>254){
            window.alert("超出规定字数");
            return false;
        }else{
            window.alert("发帖成功!");
        }
    }


</script>
</BODY>
</html>