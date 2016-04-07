package servlet.userOperation;

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

/**
 * Created by Administrator on 2015/11/20.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.modify_servlet})
public class ModifyServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String command = req.getParameter("command");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(KeyConst.USER);
        switch (command) {
            case "tel":
                String tel = req.getParameter(KeyConst.TEL);
                String signature = req.getParameter("signature");
                user.setPhone(tel);
                user.setSignature(signature);
                BasicDao.saveOrUpdate(user);
                resp.sendRedirect("/personalCenter/setZiliao.jsp?info=success");
                break;
            case "password":
                String pass1 = req.getParameter("pass1");       //‘≠√‹¬Î
                String pass2 = req.getParameter("pass2");       //–¬√‹¬Î
                if (!pass1.equals(user.getPassword())) {
                    resp.sendRedirect("/errorpage/failModifyPass.html");
                    return;
                }
                user.setPassword(pass2);
                BasicDao.saveOrUpdate(user);
                session.setAttribute(KeyConst.USER, user);
                resp.sendRedirect("/personalCenter/setZiliao.jsp?info=success");
                break;
            default:
                break;
        }
    }
}
