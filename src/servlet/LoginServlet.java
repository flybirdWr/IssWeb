package servlet;

import DAO.BasicDao;
import entity.User;
import entity.article;
import entity.page;
import util.KeyConst;
import util.PathConst;
import util.pageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.UUID;

/**
 * Created by Administrator on 2015/10/27.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {PathConst.ServletPath.login_servlet})
public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/x-json;charset=UTF-8");
        response.setDateHeader("Expires", 0);
        PrintWriter out = response.getWriter();
        HttpSession session1=request.getSession();
        int totalcount=BasicDao.count(article.class,"where tree_level=1");
        int currentPage=1;
        page p= pageUtil.createPage(10, totalcount, currentPage);

        session1.setAttribute("page",p);

        String username = request.getParameter(KeyConst.USERNAME), email = null, password=request.getParameter(KeyConst.PASSWORD);
        String anonymous = request.getParameter(KeyConst.ANONYMOUS);//是否游客登录
        String captcha = request.getParameter(KeyConst.CAPTCHA);//验证码
        System.out.println(username);
        System.out.println(password);
        System.out.println(captcha);
        System.out.println(anonymous);
        if (captcha == null || captcha.equals("")) {

            String info = URLEncoder.encode("验证码不能为空!", "UTF-8");
            out.write("验证码不能为空!");
           // response.sendRedirect(String.format("%s?%s=%s&%s=%s", PathConst.PagePath.login, KeyConst.SYSINFO, "error","info",info));
        } else if (!captcha.toLowerCase().equals(session1.getAttribute(KeyConst.CAPTCHA).toString().toLowerCase())) {
            String info = URLEncoder.encode("验证码不正确!", "UTF-8");
            System.out.println("您输入的验证码: " + captcha);
            System.out.println("会话中的验证码: " + session1.getAttribute(KeyConst.CAPTCHA));
            out.write("验证码不正确!");
            //response.sendRedirect(String.format("%s?%s=%s&%s=%s", PathConst.PagePath.login, KeyConst.SYSINFO, "error","info",info));
        } else if (anonymous != null && anonymous.equals(KeyConst.ANONYMOUS)) {//游客登录
//            Cookie cookies[] = request.getCookies();
            HttpSession session = request.getSession();
            boolean have_cookie = false;
            Cookie[] cookies = request.getCookies();//取得Cookie
            for (Cookie c : cookies) {
                if (c.getName().equals(KeyConst.ANONYMOUS)) {
                    have_cookie = true;
                    String _uuid = c.getValue();
                    int x = BasicDao.count(User.class, String.format("where username='%s'", _uuid));//?????????????????
                    User user = null;
                    if (x == 0) {
                        user = new User();
                        user.setStatus(User.ANONYMOUS);
                        String uuid = String.format("Passenger:%s", UUID.randomUUID().toString());
                        user.setUsername(uuid);
                        user.setHead("Avatar.jpg");
                        BasicDao.saveOrUpdate(user);
                    } else {
                        user = BasicDao.select(String.format("where username='%s'", _uuid), User.class).get(0);//??????????????
                    }
                    session.setAttribute(KeyConst.USER, user);//取得cookie共享User变量
                    break;
                }

            }
            if (!have_cookie) {
                User user = new User();
                user.setStatus(User.ANONYMOUS);
                String uuid = String.format("Passenger:%s", UUID.randomUUID().toString());
                user.setUsername(uuid);
                user.setHead("Avatar.jpg");
                BasicDao.saveOrUpdate(user);
                Cookie c = new Cookie(KeyConst.ANONYMOUS, uuid);
                c.setMaxAge(Integer.MAX_VALUE);
                response.addCookie(c);
                session.setAttribute(KeyConst.USER, user);
            }
            //response.sendRedirect(PathConst.PagePath.index);
            out.write(PathConst.PagePath.index);
        }
        else {
            String pattern = "^\\s*\\w+(?:\\.?[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";//邮箱的正则表达式
            if (username.matches(pattern)){
                email = username;
                username = null;
            }
            int count = BasicDao.count(User.class, String.format("where (username='%s' or email='%s') and password='%s'", username, email, password));
            if (count<1){
                String info = URLEncoder.encode("用户名或密码不正确, 请重新输入!", "UTF-8");
                out.write("用户名或密码不正确, 请重新输入!");
               // response.sendRedirect(String.format("%s?%s=%s&%s=%s", PathConst.PagePath.login, KeyConst.SYSINFO, "error","info",info));
            }
            else {
                User user = BasicDao.select(String.format("where username='%s' or email='%s'", username, email), User.class).get(0);
                HttpSession session = request.getSession();
                session.setAttribute(KeyConst.USER, user);
                //response.sendRedirect(PathConst.PagePath.index);
                out.write(PathConst.PagePath.index);
            }
        }

        out.flush();
        out.close();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
