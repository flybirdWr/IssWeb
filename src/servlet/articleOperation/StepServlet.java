package servlet.articleOperation;

import DAO.BasicDao;
import entity.User;
import entity.article;
import entity.articleJudgement;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2015/10/31.
 */
@WebServlet(name = "StepServlet", urlPatterns = {PathConst.ServletPath.step_servlet})
public class StepServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer article_id = Integer.parseInt(req.getParameter(KeyConst.ARTICLE_ID));

        User user = (User) req.getSession().getAttribute(KeyConst.USER);
        article ar = new article();
        ar.setArticle_id(article_id);
        articleJudgement aj = new articleJudgement();
        aj.setA(ar);
        aj.setU(user);
        aj.setThumb_or_step(articleJudgement.STEP);
        BasicDao.saveOrUpdate(aj);

        /**
         * The "Referer" field of HTTP request header is the page that calls this servlet
         */
        resp.sendRedirect(req.getHeader("Referer"));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            doGet(req,resp);
    }
}
