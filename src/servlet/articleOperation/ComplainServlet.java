package servlet.articleOperation;

import DAO.BasicDao;
import entity.User;
import entity.UserComplaint;
import entity.article;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/11/7.
 */
@WebServlet(name = "ComplainServlet", urlPatterns = {PathConst.ServletPath.complain_servlet})
public class ComplainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(KeyConst.USER);
        String article_id = req.getParameter(KeyConst.ARTICLE_ID);
        String content = req.getParameter(KeyConst.COMPLAINT_CONTENT);
        Date d = new Date(System.currentTimeMillis());
        List<article> a = BasicDao.select(String.format("where article_id='%s'", article_id), article.class);
        if (a != null && !a.isEmpty()) {
            UserComplaint complaint = new UserComplaint();
            complaint.setA(a.get(0));
            complaint.setU(user);
            complaint.setCtext(content);
            complaint.setCtime(d);
            BasicDao.saveOrUpdate(complaint);
        } else {
            System.err.println("内部错误 ComplaintServlet: 没有找到id为" + article_id + "的帖子.");
        }
    }
}
