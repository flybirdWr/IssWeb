<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="util.KeyConst" %>
<%@ page import="util.PathConst" %>
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
    <link rel="stylesheet" href="css/index.css">


    <link rel="stylesheet" href="css/style.css">

</head>
<body>
<div class="bg"></div>
<div class="content">
    <!--导航栏-->
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
    <div id="login">
        <ul>
            <li>
                <a href="/login_admin.jsp">登录</a>
            </li>
            <li class="active">
                <a href="#">修改密码</a>
            </li>
        </ul>

        <form name="RegisterAction" class="form-horizontal" role="form"
              action="<%=PathConst.ServletPath.admin_change_password_servlet%>" method="post">

            <div class="form-group">
                <label class="sr-only control-label">
                    旧密码
                </label>

                <div>
                    <input type="password" name="<%=KeyConst.ADMIN_PASS%>" id="passwordid" class="form-control"
                           placeholder="请输入原来的密码">
                </div>
            <span id="name-ck" class="help-block">
            </span>
            </div>
            <div class="form-group">
                <label class="sr-only control-label">
                    新密码
                </label>

                <div class=" ">
                    <input type="password" name="<%=KeyConst.NEW_ADMIN_PASS%>" id="passwordid" class="form-control"
                           placeholder="输入新密码">
                </div>
            <span id="password-ck" class="help-block">

            </span>
            </div>
            <div class="form-group">
                <label class="sr-only control-label">
                    确认新密码
                </label>

                <div class=" ">
                    <input type="password" id="passwordid" class="form-control" placeholder="重复新密码">
                </div>
            <span id="password-ck" class="help-block">

            </span>
            </div>
            <br>

            <div class="form-group">
                <div class="">
                    <button type="submit" id="registerBtn" class="btn btn-info"
                            style="font-size:1.4em; width:100%;font-weight:600;">
                        更改密码
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="js/jquery-2.1.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>