package servlet;

import DAO.BasicDao;
import entity.User;
import entity.UserFavoriteArticle;
import entity.article;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by lazier on 2015/11/2 0002.
 */
@WebServlet(name = "AttentionServlet", urlPatterns = {PathConst.ServletPath.attention_servlet})
public class AttentionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        int days=Integer.parseInt(request.getParameter("tianshu"));
        Date sdate=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Calendar rightNow = Calendar.getInstance();
        rightNow.setTime(sdate);
        rightNow.add(Calendar.DAY_OF_YEAR, days);
        Date fdate=rightNow.getTime();
        UserFavoriteArticle ufa=new UserFavoriteArticle();
        ufa.setStart_date(sdate);
        ufa.setDue_time(fdate);
        int aid=Integer.parseInt(request.getParameter("aid"));
        article a=BasicDao.selectById(aid, article.class);
        User u=(User)session.getAttribute("user");
        ufa.setU(u);
        ufa.setA(a);
        BasicDao.saveOrUpdate(ufa);
        response.sendRedirect("/main/question.jsp?aid="+aid);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
