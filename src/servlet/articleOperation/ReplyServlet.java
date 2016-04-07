package servlet.articleOperation;

import DAO.BasicDao;
import entity.User;
import entity.article;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Created by Administrator on 2015/11/12.
 */
@WebServlet(name = "ReplyServlet", urlPatterns = {PathConst.ServletPath.reply_servlet})
public class ReplyServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String parent_id = req.getParameter(KeyConst.PARENT_ID);
        article parent = null;
        try {
            parent = BasicDao.select(String.format("where article_id='%s'", parent_id), article.class).get(0);
            article a = new article();
            a.setU((User) req.getSession().getAttribute(KeyConst.USER));
            a.setText(req.getParameter(KeyConst.TEXT));
            a.setDate(new Date(System.currentTimeMillis()));
            int level = parent.getTree_level();
            a.setTree_level(2);         //>=2为回复贴
            a.setTitle("reply");

            a.setParentArticle(parent);
            BasicDao.save(a);
            int id = Integer.valueOf(parent_id);
            resp.sendRedirect(String.format("%s?%s=%d",PathConst.PagePath.show_article, "aid", id));
        } catch (NullPointerException e){
            System.out.println("帖子可能已被删除!");
            resp.sendRedirect(PathConst.PagePath.index);
            return;
        }

    }
}
