<%@ page import="entity.User" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="util.KeyConst" %>
<%@ page import="util.PathConst" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <LINK rel=stylesheet href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/personCenter.css">
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/jquery-2.1.3.min.js"></script>
    <script src="/js/main.js"></script>

    <script src="/js/bootstrap.min.js"></script>
    <%--<script src="/js/register.js"></script>--%>
    <%--/<script src="/js/login.js"></script>--%>
    <script type="text/javascript">

    </script>
</head>
<BODY style="background:rgb(236,235,235)">
<!--导航栏-->
<jsp:include page="/module/navbar.jsp" flush="true"/>
<%
    User user = (User) session.getAttribute(KeyConst.USER);
    String filename = String.format("uid%d-ms%d",user.getUid(), System.currentTimeMillis());
    String phone=user.getPhone();
    if(phone==null ){
        phone="";
    }
%>
<div class="container-fluid">
    <jsp:include page="/module/headerblock.jsp" flush="true"/>
    <div class="container">
        <div class="quesions" style="height:600px;margin-bottom: 100px;">
            <div class="tab-title" id="tab-title">
                <ul class="nav nav-tabs nav-tabs-zen">
                    <li class="active">
                        <A>个人资料</A>
                    </li>
                    <li>
                        <A>修改密码</A>
                    </li>
                </ul>
            </div>
            <div class="tab-content" id="tab-content">
                <!--设置资料-->
                <span class="row ziliao" style="display:block">
                    <div class="col-md-4">
                        <div class="touxiang" style=" width: 200px;margin: 50px auto auto 20px;">
                            <form name="image-upload" method="post" action="<%=String.format("%s?%s=%s",PathConst.ServletPath.head_servlet,KeyConst.FILENAME,filename)%>" id="fileupload" enctype="multipart/form-data">
                                <h2 style="font-size: 18px;">请选择上传的头像：</h2>
                                <a class="a-upload">
                                    <input type="file" id="file" name="filename" accept="image/png,image/jpeg" onchange="previewImage(this);"/>
                                    点击这里上传
                                </a>
                                <br/>
                                <label>预览</label><br/>
                                <img id="preview" src="/user_data/<%=user.getHead()%>" width="150"/><br/><br/>
                                <input class="btn btn-primary pull-right" type="submit" value="上传" id="submit"/>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class=" xinxi">
                            <form class="form-horizontal" action="<%=PathConst.ServletPath.modify_servlet%>" method="post">
                                <input type="hidden" name="command" value="tel"/>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">性别</label>
                                    <div class="col-sm-6">
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" id="secret" value="secret" checked> 保密
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" id="man" value="man"> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" id="woman" value="woman"> 女
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="col-sm-2 control-label">现居住地</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" id="address" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="birthday" class="col-sm-2 control-label">生日</label>
                                    <div class="col-sm-6">
                                        <input type="datetime" class="form-control" id="birthday" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="telephone" class="col-sm-2 control-label">手机号</label>
                                    <div class="col-sm-6">
                                        <input name="<%=KeyConst.TEL%>" type="tel" class="form-control" id="telephone" placeholder="<%=user.getPhone()%>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">个性签名</label>
                                    <div class="col-sm-6">
                                        <textarea class="form-control" name="signature" rows="3" placeholder="一两句话介绍自己的擅长领域和需求"></textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-primary">确认修改</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </span>
                <!-- 更换密码-->
                <span class="row passwd" style="display: none">
                    <div class="col-md-6">
                        <div class=" xinxi">
                            <form class="form-horizontal" action="<%=PathConst.ServletPath.modify_servlet%>">
                                <div class="form-group">
                                    <input type="hidden" name="command" value="password"/>
                                    <label for="password" class="col-sm-2 control-label">原密码*</label>
                                    <div class="col-sm-6">
                                        <input name="pass1" type="password" class="form-control" id="password"
                                               placeholder="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="newPassword" class="col-sm-2 control-label">新密码*</label>
                                    <div class="col-sm-6">
                                        <input name="pass2" type="password" class="form-control" id="newPassword"
                                               placeholder="" onblur="checkName()">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="conformPassword" class="col-sm-2 control-label">确认密码*</label>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control" id="conformPassword" placeholder=""  onblur="checkName2()">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-primary">确认更改</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </span>
            </div>

        </div>
    </div>


</div>

<script>
//    document.getElementById("submit").onclick=function(){
//        window.alert("haha");
//        window.alert(document.getElementById("file").value);
//        if(document.getElementById("file").value==null){
//            window.alert("请点击要上传的图片");
//        }
//    };
    var info = '<%=request.getParameter("info")%>';
    if(info=="success"){
         window.alert("修改成功！");
    }

    function checkName(){
        var password = $("password").value;

        var newPassword = $("newPassword").value;


        if(password == newPassword){
            window.alert("现密码不能与原密码相同");
        }

    }
    function checkName2(){
        var newPassword = $("newPassword").value;
        var conformPassword = $("conformPassword").value;
        if(newPassword != conformPassword&&conformPassword!=""){
            window.alert("两次密码输入不一致");
        }
    }
    function $(id){
        return typeof id=="string"?document.getElementById(id):id;
    }
    window.onload = function(){
        var titleName = $("tab-title").getElementsByTagName("li");
        var tabContent = $("tab-content").getElementsByTagName("span");
        if(titleName.length!=tabContent.length){
            return;
        }
        for(var i=0; i<titleName.length; i++){
            titleName[i].id = i;
            titleName[i].onclick = function(){
                for(var j=0; j<titleName.length; j++){
                    titleName[j].className="";
                    tabContent[j].style.display = "none";
                }
                this.className = "active";
                tabContent[this.id].style.display = "block";
            }
        }

        /*菜单栏的显示*/
        var navSelect = document.getElementById('navSelectid');
        var navItems = navSelect.getElementsByTagName('li');
        for(var i=0; i<navItems.length; i++){
            if(i==1){
                navItems[i].className = "active";
            }else{
                navItems[i].className = "";
            }
        }

        /*个人中心页面子菜单显示*/
        var headBlock = document.getElementById('headBlockid');
        var headItems = headBlock.getElementsByTagName('li');
        for(var j=0; j<headItems.length; j++){
            if(j==3){
                headItems[j].className = "active";
            }else{
                headItems[j].className = "";
            }
        }

    }
</script>

</body>
</html>