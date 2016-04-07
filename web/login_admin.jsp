<%@ page import="util.KeyConst" %>
<%@ page import="util.PathConst" %>
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
    <link rel="stylesheet" href="css/head.css">
    <link rel="stylesheet" href="css/indx.css">
    <script type="text/javascript">
        function refreshcaptcha() {
            //直接修改元素属性是可行的。
            document.getElementById("captcha").src = "/servlet/CaptchaServlet?nocache=" + Math.floor(Math.random() * 1e9);
        }
    </script>

    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="bg"></div>
<div class="content">
    <!-- 导航栏-->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img src="images/logo.png" height="40" style="margin-top:-10px;margin-left:-10px;">
                </a>
            </div>


        </div>
        <!-- /.container-fluid -->
    </nav>
    <!-- 登录表单-->
    <div id="login">
        <ul>
            <li class="active">
                <a href="#">登录</a>
            </li>
            <li>
                <a href="/change_password.jsp">修改密码</a>
            </li>
        </ul>

        <form name="LoginAction" class="form-horizontal" role="form"
              action="<%=PathConst.ServletPath.admin_login_servlet%>" onsubmit=""
              method="post">

            <div class="form-group">
                <label class="sr-only control-label">
                    密码
                </label>

                <div class=" ">
                    <input type="password" name="<%=KeyConst.ADMIN_PASS%>" id="lpasswordid" class="form-control"
                           placeholder="密码"
                           required>
                </div>
            <span id="lpassword-ck" class="help-block">

            </span>
            </div>
            <div class="form-group">
                <label class="sr-only control-label" for="input">
                    验证码
                </label>
                <div style="width:65%;float:left">
                    <input type="text" id="input" class="form-control" name="captcha" placeholder="验证码" required>
                </div>
                <div style="width:33%;float:left;margin-left:2%">
                    <img src="/servlet/CaptchaServlet?nocache=<%=Math.floor(Math.random()*1e9) %>"
                         onclick="return refreshcaptcha()" id="captcha" style="width: 100%;height: 32px;">
                </div>
            <span id="lcheckCode-ck" class="help-block">

            </span>
            </div>
            <br>

            <div class="form-group">
                <div class="">
                    <button type="submit" class="btn btn-info" style="font-size:1.4em; width:100%;font-weight:600;">
                        登 录
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="js/jquery-2.1.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/login.js"></script>
</body>
</html>