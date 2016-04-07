package servlet.articleOperation;

import DAO.BasicDao;
import entity.Tag;
import entity.User;
import entity.article;
import entity.articleTag;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Administrator on 2015/11/2.
 */
@WebServlet(name = "PublishServlet", urlPatterns = {PathConst.ServletPath.publish_servlet})
public class PublishServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /**
         * STEP 1
         * insert new article
         */
        String title, text;
        title = req.getParameter(KeyConst.TITLE);
        text = req.getParameter(KeyConst.TEXT);
        System.out.println("biaoti"+title);
        System.out.println("wenben:"+text);
        User u = (User) req.getSession().getAttribute(KeyConst.USER);
        article a = new article();
        a.setTitle(title);
        a.setText(text);
        a.setU(u);
        a.setDate(new Date(System.currentTimeMillis()));
        a.setTree_level(article.MAIN);
        BasicDao.saveOrUpdate(a);
        int aid = a.getArticle_id();
        /**
         * STEP 2
         * insert new tags if they do not exist
         */
        String tags = req.getParameter(KeyConst.TAG);
        if (tags!=null) {
            String[] tagarr = tags.split("\\||\\.|;|,|\\s|&|$|#|\\^|\\*");
            List<Tag> tagList = new LinkedList<>();
            for (String t: tagarr){
                t = t.trim();
                if (t.equals("")) continue;
                String tagname = t.trim();
                Tag tag = new Tag();
                tag.setTag_name(tagname);
                BasicDao.saveOrUpdate(tag);
                tagList.add(tag);
            }

            /**
             * STEP 3
             * associate the articles with its tags
             */
            for (Tag tag : tagList) {
                articleTag at = new articleTag();
                at.setA(a);
                at.setT(tag);
                BasicDao.saveOrUpdate(at);
            }
        }
        resp.sendRedirect(String.format("%s?%s=%s", PathConst.PagePath.show_article,"aid",aid));
       // resp.sendRedirect(PathConst.PagePath.show_article+"?aid="+aid);
    }
}
