package servlet.admin;

import DAO.BasicDao;
import entity.User;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/11/27.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.lock_user_servlet})
public class LockUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String command = req.getParameter("command");
        String uid = req.getParameter("uid");
        User u = BasicDao.select("where uid = '" + uid + "'", User.class).get(0);
        switch (command) {
            case "freeze":
                u.setStatus(User.FROZEN);
                BasicDao.saveOrUpdate(u);
                break;
            case "delete":
                BasicDao.delete(User.class, "where uid = '" + uid + "'");
                break;
            case "recover":
                if (u.getUsername().startsWith("Passenger:")){
                    u.setStatus(User.ANONYMOUS);
                }
                else u.setStatus(User.NORMAL);
                BasicDao.saveOrUpdate(u);
            default:
                break;
        }
        resp.sendRedirect(req.getHeader("Referer"));
    }
}
