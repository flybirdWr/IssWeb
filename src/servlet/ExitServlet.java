package servlet;

import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Administrator on 2015/11/27.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.exit_servlet})
public class ExitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.setAttribute(KeyConst.USER, null);
        // TODO É¾³ýÓÃ»§Ãûcookie
        resp.sendRedirect(PathConst.PagePath.login);
    }
}
