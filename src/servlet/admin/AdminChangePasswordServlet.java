package servlet.admin;

import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by Administrator on 2015/11/26.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.admin_change_password_servlet})
public class AdminChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String p1 = req.getParameter(KeyConst.ADMIN_PASS);
        String p2 = req.getParameter(KeyConst.NEW_ADMIN_PASS);
        File f = new File(String.format("%s/%s", AdminLoginServlet.mypath, AdminLoginServlet.file));
        BufferedReader bis = new BufferedReader(new FileReader(f));
        String p = bis.readLine().trim();
        if (p1 != null && p1.equals(p)) {
            BufferedWriter writer = new BufferedWriter(new FileWriter(f, false));
            writer.write(p2.trim());
            writer.close();
            resp.sendRedirect(PathConst.PagePath.success_admin_modify);
        } else {
            resp.sendRedirect(PathConst.PagePath.fail_admin_modify);
        }
    }
}
