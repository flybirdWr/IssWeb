package servlet;

import DAO.BasicDao;
import entity.*;
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
import java.util.List;

/**
 * Created by lazier on 2015/11/12 0012.
 */
@WebServlet(name = "PersonalCenterServlet",urlPatterns = {PathConst.ServletPath.concern_servlet})
public class PersonalCenterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        int operation=Integer.parseInt(request.getParameter("operation"));
        int aid=Integer.parseInt(request.getParameter("aid"));
        User u=(User)session.getAttribute("user");
        int uid=u.getUid();
        UserFavoriteArticle ufa=new UserFavoriteArticle();
        List<UserFavoriteArticle> uf= BasicDao.select("where uid="+uid+" and article_id="+aid,UserFavoriteArticle.class);
        for(UserFavoriteArticle u12:uf){
            ufa=u12;
        }
        switch(operation){
            case 1:
                ufa.setDue_time(ufa.getStart_date());
                BasicDao.saveOrUpdate(ufa);
                response.sendRedirect("/personalCenter/concern.jsp?aid=" + aid);
                break;
            case 2:
            case 4:
                BasicDao.delete(UserFavoriteArticle.class,("where uid="+uid+" and article_id="+aid));
                response.sendRedirect("/personalCenter/concern.jsp?aid=" + aid);
                break;
            case 3:
                int days=Integer.parseInt(request.getParameter("tianshu"));
                Date sdate=new Date();
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                Calendar rightNow = Calendar.getInstance();
                rightNow.setTime(sdate);
                rightNow.add(Calendar.DAY_OF_YEAR, days);
                Date fdate=rightNow.getTime();
                ufa.setStart_date(sdate);
                ufa.setDue_time(fdate);
                BasicDao.saveOrUpdate(ufa);
                response.sendRedirect("/personalCenter/concern.jsp?aid="+aid);
                break;
            case 5:
                BasicDao.delete(article.class, "where article_id=" + aid);
                response.sendRedirect("/personalCenter/personCenter.jsp?aid="+aid);
                break;
            case 6:
                if (ufa.getDue_time().getTime()<System.currentTimeMillis()) ufa.setIsChecked(true);
                BasicDao.saveOrUpdate(ufa);
                response.sendRedirect("/main/question.jsp?aid=" + aid);
                break;
            case 7:
                int uid1=Integer.parseInt(request.getParameter("uid1"));
                BasicDao.delete(article.class, ("where author=" + uid1 + " and article_id=" + aid));
                BasicDao.delete(message.class,"where article_id="+aid+" sender="+uid1+" relative="+uid);
                response.sendRedirect("/personalCenter/message.jsp");
                break;
            case 8:
                int uid2=Integer.parseInt(request.getParameter("uid1"));
                BasicDao.delete(articleJudgement.class, ("where uid=" + uid2 + " and article_id=" + aid));
                BasicDao.delete(message.class,"where article_id="+aid+" sender="+uid2+" relative="+uid);
                response.sendRedirect("/personalCenter/message.jsp");
                break;
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
}
