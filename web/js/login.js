
//检测登录的输入是否正确
function loginCheck() {

    function $(id){
        return typeof id=="string"?document.getElementById(id):id;
    }

   /*根据是否选择了游客登陆判断是否输入用户名和密码*/

        if($('passerbyid').checked){

        }else{
            if($("lusernameid").value == ''){
                $('lname-ck').textContent = '用户名不能为空';
                return false;
            }
            if($("lpasswordid").value == ''){
                $('lpassword-ck').textContent = '密码不能为空';
                return false;
            }
        }

return true;

}

//验证码刷新
