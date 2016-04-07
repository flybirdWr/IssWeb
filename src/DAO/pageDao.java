package DAO;

import entity.page;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.hibernateUtil;


import java.util.List;
/**
 * Created by lazier on 2015/10/26 0026.
 */
public class pageDao {
    public static <T>  List<T> queryByPage(String where,Class<T> t, page p){
        Session session= hibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try{
            String sql="select * from `"+t.getSimpleName()+"` "+where;
            Query q =session.createSQLQuery(sql).addEntity(t);
            q.setMaxResults(p.getEveryPage());
            q.setFirstResult(p.getBeginIndex());
            List<T> result=q.list();
            transaction.commit();
            return result;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
        finally {

            hibernateUtil.closeSession(session);//�رջỰ

            System.out.println("close session!");
        }
    }
}
