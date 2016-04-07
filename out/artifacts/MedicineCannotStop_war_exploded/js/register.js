function registerCheck(){
    var valid=/^\w+$/;

    function $(id){
        return typeof id=="string"?document.getElementById(id):id;
    }
    //创建ajax引擎
    function getXmlHttpObject(){

        var xmlHttpRequest;
        //不同的浏览器获取对象xmlhttprequest 对象方法不一样
        if(window.ActiveXObject){

            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");

        }else{

            xmlHttpRequest=new XMLHttpRequest();
        }

        return xmlHttpRequest;

    }
    var myXmlHttpRequest="";

    /*用户昵称*/

    $('usernameid').onblur = function(){
        $('name-ck').textContent='';
        myXmlHttpRequest=getXmlHttpObject();
        if(myXmlHttpRequest) {
            var url = "/user/RegisterServlet";
            var data = "username=" + $("usernameid").value;
            myXmlHttpRequest.open("post", url, true);
            myXmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            myXmlHttpRequest.onreadystatechange = chuli;
            myXmlHttpRequest.send(data);
        }
        if(this.value=="") {
            $('name-ck').textContent = '用户昵称不能为空';
            $('registerBtn').disabled = 'disabled';
            return false;
        }

        if (this.value.length<2)
        {
            $('name-ck').textContent='昵称长度必须大于等于2位';
            $('registerBtn').disabled = 'disabled';
            return false;
        }

        if(!valid.test(this.value)){
            $('name-ck').textContent='昵称必须是数字、字母或下划线';
            $('registerBtn').disabled = 'disabled';
            return false;
        }
        return true;
    }
    function chuli(){

        //window.alert("处理函数被调回"+myXmlHttpRequest.readyState)
        if(myXmlHttpRequest.readyState==4){
            if(myXmlHttpRequest.status==200){
                var res=myXmlHttpRequest.responseText;
                $('name-ck').textContent = res;
                if(res.length!=0){
                    return false;
                }
            }
            //取出值,根据返回信息的格式定.text
            //window.alert("服务器返回"+myXmlHttpRequest.responseText);


        }
    }
    /*用户密码*/
    $('passwordid').onblur = function(){
        $('password-ck').textContent='';

        if (this.value=="")
        {
            $('password-ck').textContent='密码不能为空';
            $('registerBtn').disabled = 'disabled';
            return false;
        }
        if (this.value.length<6)
        {
            $('password-ck').textContent='密码长度必须大于6位';
            $('registerBtn').disabled = 'disabled';
            return false;
        }
        return true;
    }
    $("conformpassword").onblur=function(){
        $('conformpassword-ck').textContent="";
        var password = $("passwordid").value;
        var conformPassword = $("conformpassword").value;
        if(password!=conformPassword){
            $('conformpassword-ck').textContent='两次密码输入不一致';
            $('registerBtn').disabled = 'disabled';
            return false;
        }
        return true;
    }

    /*用户邮箱*/
    //$('emailid').onblur = function(){
    //    $("email-ck").textContent="";
    //    myXmlHttpRequest=getXmlHttpObject();
    //    if(myXmlHttpRequest) {
    //        var url = "/user/RegisterServlet";
    //        var data = "email=" + $("emailid").value;
    //        myXmlHttpRequest.open("post", url, true);
    //        myXmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    //        myXmlHttpRequest.onreadystatechange = chuli2;
    //        myXmlHttpRequest.send(data);
    //    }
    //    var apos=this.value.indexOf("@")
    //    var dotpos=this.value.lastIndexOf(".")
    //    if(this.value == ''){
    //        $('email-ck').textContent = '邮箱不能为空';
    //        return false;
    //    }
    //    if (apos<1||dotpos-apos<2){
    //        $('email-ck').textContent = '邮箱格式不正确';
    //        return false;
    //    }
    //    return true;
    //}
    function chuli2(){

        //window.alert("处理函数被调回"+myXmlHttpRequest.readyState)
        if(myXmlHttpRequest.readyState==4){
            if(myXmlHttpRequest.status==200){
                var res=myXmlHttpRequest.responseText;
                $('email-ck').textContent = res;
                if(res.length!=0){
                    $('registerBtn').disabled = 'disabled';
                    return false;
                }
            }
        }
    }

    /*判断用户是否同意了网站协议决定是否让其注册*/
    $('agreeid').onclick = function(){
        if(this.checked) {
            if($('usernameid').value!=""&&$('passwordid').value!=""&&$('conformpassword').value!=""){
                $('registerBtn').disabled = '';
            }

        } else{
            $('registerBtn').disabled = 'disabled';
        }
    }
    $("registerBtn").onclick = function(){

    }

}
registerCheck();