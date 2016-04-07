package servlet.articleOperation;

import DAO.BasicDao;
import entity.article;
import entity.message;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/11/6.
 */
@WebServlet(urlPatterns = {PathConst.ServletPath.delete_servlet})
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer article_id = Integer.valueOf(req.getParameter(KeyConst.ARTICLE_ID));
        BasicDao.delete(article.class, String.format("where %s='%d'", KeyConst.ARTICLE_ID, article_id));
        BasicDao.delete(message.class, "where article_id=" + article_id);
        resp.sendRedirect(req.getHeader("Referer"));
    }
}
