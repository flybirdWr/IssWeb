package servlet.admin;

import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by Administrator on 2015/11/25.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.admin_login_servlet})
public class AdminLoginServlet extends HttpServlet {
    public static final String file = "PasswordFile.txt";
    public static String mypath = AdminLoginServlet.class.getResource("/").getPath();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String password = req.getParameter(KeyConst.ADMIN_PASS);
        File f = new File(String.format("%s/%s", AdminLoginServlet.mypath, AdminLoginServlet.file));
        BufferedReader bis = new BufferedReader(new FileReader(f));
        String pass2 = bis.readLine().trim();
        if (password != null && password.equals(pass2)) {
            session.setAttribute(KeyConst.SUPER_ADMIN, new Object());
            bis.close();
            resp.sendRedirect(PathConst.PagePath.admin_index);
        } else {
            bis.close();
            resp.sendRedirect(PathConst.PagePath.admin_login);
        }
    }
}
