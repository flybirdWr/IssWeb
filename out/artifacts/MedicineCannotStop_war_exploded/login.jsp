<%@ page import="util.KeyConst" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>登陆入口</title>
    <!--支持响应式-->
    <meta name="viewport" content="width=device-width initial-scale=1">

    <LINK rel=stylesheet href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/login.css">

    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/login.js"></script>
    <script type="text/javascript">
        <%--更换验证码--%>
        function refreshcaptcha() {
            //直接修改元素属性是可行的。
            document.getElementById("captcha").src = "/servlet/CaptchaServlet?nocache=" + Math.floor(Math.random() * 1e9);
        }
    </script>
</head>
<body>
<%
    HttpSession session1=request.getSession();
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("passwrod");
    if(username==null){
        username="用户名或邮箱";
    }
    if(password==null){
        password="密码";
    }

%>
<div class="bg"></div>
<div class="content">
    <!-- 导航栏-->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img src="images/logo.png" height="40" style="margin-top:-10px;margin-left:-10px;">
                </a>
            </div>


        </div><!-- /.container-fluid -->
    </nav>


    <!-- 登录表单-->
    <div id="login">
        <ul>
            <li class="active">
                <a href="#">登录</a>
            </li>
            <li >
                <a href="register.html">注册</a>
            </li>
        </ul>
        <form name="LoginAction" class="form-horizontal" role="form" action="/user/LoginServlet" onsubmit="loginCheck()" method="post">

            <div class="form-group">
                <label class="sr-only control-label">
                    账号
                </label>
                <div>
                    <input type="text" name="username" id="lusernameid" class="form-control" placeholder="用户名或邮箱" >
                </div>
            <span id="lname-ck" class="help-block">
            </span>
            </div>
            <div class="form-group">
                <label class="sr-only control-label">
                    密码
                </label>
                <div class=" ">
                    <input type="password" name="password" id="lpasswordid" class="form-control" placeholder="密码">
                </div>
            <span id="lpassword-ck" class="help-block">

            </span>
            </div>
            <div class="form-group">
                <label class="sr-only control-label" for="input">
                    验证码
                </label>
                <div style="width:40%;float:left">
                    <input type="text" id="input" class="form-control" name="captcha" placeholder="验证码" required>
                </div>
                <div style="width:30%;float:left;margin-left:2%">
                    <img src="/servlet/CaptchaServlet?nocache=<%=Math.floor(Math.random()*1e9) %>"
                         onclick="return refreshcaptcha()" id="captcha" style="width: 100%;height: 32px;">
                </div>
                <div style="width:20%;float:left">
                    <p style="font-size: 10px">看不清，请点击验证码图片换一张</p>
                </div>
            <span id="lcheckCode-ck" class="help-block">

            </span>
            </div>
            <div class="form-group">
                <div style="width:45%;float:left">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="passerbyid" name="anonymous" value="anonymous"/>
                            <span>游客登录</span>
                        </label>
                    </div>
                </div>
                <div style="width:45%;float:left">
                    <div class="checkbox">
                        <label>
                            <a href="main/forgetPassword.jsp">忘记密码？</a>
                        </label>
                    </div>
                </div>
            </div>
            <br>
            <div class="form-group">
                <div class="">
                    <button  type="button" class="btn btn-info" style="font-size:1.4em; width:100%;font-weight:600;" onclick="check();">
                        登   录
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    var error = '<%=request.getParameter("sysinfo")%>';
    var info = '<%=request.getParameter("info")%>';
    if(error=="error")
    {
        alert(info);
    }

    function check(){

        $.post("/user/LoginServlet",{
            username:$("#lusernameid").val(),
            password:$("#lpasswordid").val(),
            captcha:$("#input").val(),
            anonymous:$("#passerbyid:checked").val()
        },function(data,textStatus){
            if(data.indexOf("jsp")>-1){
                window.location.href = data;
            }else{
                alert(data);
            }

        },"html")
    }
</script>
</body>
</html>