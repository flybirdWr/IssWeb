package util;

/**
 * Created by Administrator on 2015/10/18.
 */
public class PathConst {
    public class PagePath{
        public static final String login = "/login.jsp";
        public static final String index = "/main/index.jsp";
        public static final String register = "/register.html";
        public static final String db_error = "/errorpage/DB_ERROR.jsp";
        public static final String auth_error = "/errorpage/AuthError.jsp";
        public static final String post = "/main/post.jsp";
        public static final String show_article = "/main/question.jsp";
        public static final String admin_index = "/admin/admin_index.jsp";
        public static final String recommend = "/admin/recommend.jsp";
        public static final String admin_user = "/admin/admin_user.jsp";
        public static final String admin_login = "/login_admin.jsp";
        public static final String success_admin_modify = "/errorpage/successModifyAdminPass.html";
        public static final String fail_admin_modify = "/errorpage/failModifyAdminPass.html";
    }

    public class ServletPath {
        public static final String login_servlet = "/user/LoginServlet";
        public static final String register_servlet = "/user/RegisterServlet";
        public static final String step_servlet = "/main/StepServlet";
        public static final String thumb_servlet = "/main/ThumbServlet";
        public static final String publish_servlet = "/main/PublishServlet";
        public static final String reply_servlet = "/main/ReplyServlet";
        public static final String delete_servlet = "/personalCenter/DeleteServlet";
        public static final String edit_servlet = "/personalCenter/EditServlet";
        public static final String captcha_servlet = "/servlet/CaptchaServlet";
        public static final String attention_servlet = "/servlet/AttentionServlet";
        public static final String concern_servlet = "/servlet/personalCenterServlet";
        public static final String complain_servlet = "/user/ComplainServlet";
        public static final String head_servlet = "/servlet/HeadServlet";
        public static final String modify_servlet = "/user/ModifyServlet";
        public static final String admin_login_servlet = "/admin_/AdminLoginServlet";
        public static final String admin_change_password_servlet = "/admin_/AdminChangePasswordServlet";
        public static final String exit_servlet = "/servlet/ExitServlet";
        public static final String lock_user_servlet = "/admin/LockUserServlet";
    }

    public class FilterPath {
        public static final String user_data = "/user_data/*";
    }

}
