package servlet;

import DAO.BasicDao;
import entity.User;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/10/28.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {PathConst.ServletPath.register_servlet})
public class RegisterServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");
            PrintWriter out = resp.getWriter();
            //String f=req.getParameter(KeyConst.FLAG);
            String username = req.getParameter(KeyConst.USERNAME),
                    password = req.getParameter(KeyConst.PASSWORD);
            //  email = req.getParameter(KeyConst.EMAIL);

            int nuser = BasicDao.count(User.class, String.format("where username='%s'", username));
            // int nemail = BasicDao.count(User.class, String.format("where email='%s'", email));
            if (nuser != 0) {
                out.println("The username is already used");
                //resp.sendRedirect(String.format("%s?%s=%s", PathConst.PagePath.auth_error, KeyConst.REASON, URLEncoder.encode("The username is already in use", "UTF-8")));
            }
            //else if(nemail!=0){
            // out.println("The email is already used");
            //resp.sendRedirect(String.format("%s?%s=%s", PathConst.PagePath.auth_error, KeyConst.REASON, URLEncoder.encode("The email is already in use", "UTF-8")));
            //}
            if (password != null) {
                if(u==null) {
                    User user = new User();
                    user.setUsername(username);
                    // user.setEmail(email);
                    user.setPassword(password);
                    user.setStatus(User.NORMAL);
                    user.setHead("Avatar.jpg");
                    BasicDao.saveOrUpdate(user);
                    session.setAttribute(KeyConst.USER, user);
                    resp.sendRedirect("/errorpage/successRegister.html");
                }else{
                    u.setUsername(username);
                    u.setPassword(password);
                    u.setStatus(User.NORMAL);
                    u.setHead("Avatar.jpg");
                    BasicDao.saveOrUpdate(u);
                    session.setAttribute(KeyConst.USER, u);
                    resp.sendRedirect("/errorpage/successRegister.html");
                }
            out.flush();
            out.close();
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
