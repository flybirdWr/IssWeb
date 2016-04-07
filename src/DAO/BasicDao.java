package DAO;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.hibernateUtil;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class BasicDao {


    public static <T>  List<T> select(String where,Class<T> t){
        Session session= hibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try{
            String sql="select * from `"+t.getSimpleName()+"` "+where;//getSimpleName()返回的源代码中的基础类的简单名称。如果是匿名的基础类，则返回一个空字符
            Query q =session.createSQLQuery(sql).addEntity(t);
            List<T> result=q.list();
            transaction.commit();
            return result;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
        finally {

            hibernateUtil.closeSession(session);//关闭会话

            System.out.println("close session!");
        }
    }
    public static <T>  T selectById(int id,Class<T> t){
        Session session= hibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try{

            return (T)session.get(t,id);
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
        finally {

            hibernateUtil.closeSession(session);//关闭会话

            System.out.println("close session!");
        }
    }
    public static<T>  int count(Class<T> t,String where){
        Session session= hibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        int x=-1;
        try{
            String sql="select count(*) from `"+t.getSimpleName()+"` " + where;
            Query q=session.createSQLQuery(sql);
            x=((BigInteger)q.uniqueResult()).intValue();        //??????????????????????
            transaction.commit();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            hibernateUtil.closeSession(session);//关闭会话

            System.out.println("close session!");
            return x;
        }
    }
    public static <T> boolean delete(Class<T> t,String where){
        Session session= hibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();

        boolean result=true;
        try{
            String sql0="SET FOREIGN_KEY_CHECKS = 0";
            String sql="delete from `"+t.getSimpleName()+"` " + where;
            String sql2="SET FOREIGN_KEY_CHECKS = 1";
            Query q0=session.createSQLQuery(sql0);
            Query q1=session.createSQLQuery(sql);
            Query q2=session.createSQLQuery(sql2);
            q0.executeUpdate();
            q1.executeUpdate();
            q2.executeUpdate();
            transaction.commit();
        }
        catch(Exception e){
            result=false;
            e.printStackTrace();
        }
        finally {
            hibernateUtil.closeSession(session);//关闭会话

            System.out.println("close session!");
            return result;
        }

    }

    /**
     * 更新时先查询出来. 避免将非主键设成null
     * @param t
     * @param <T>
     * @return
     */
    public static <T> boolean saveOrUpdate(T t){
        Session session= hibernateUtil.getSession();
        
        Transaction transaction = session.beginTransaction();

        boolean result=true;
        try {
            session.saveOrUpdate(t);
            transaction.commit();
        }
        catch(Exception e){
            result=false;
            e.printStackTrace();
        }
        finally {
            hibernateUtil.closeSession(session);//关闭会话
            System.out.println("close session!");
            return result;
        }
    }

    public static <T> boolean save(T t){
        Session session= hibernateUtil.getSession();

        Transaction transaction = session.beginTransaction();

        boolean result=true;
        try {
            session.save(t);
            transaction.commit();
        }
        catch(Exception e){
            result=false;
            e.printStackTrace();
        }
        finally {
            hibernateUtil.closeSession(session);//关闭会话
            System.out.println("close session!");
            return result;
        }
    }

public static <T> ArrayList<Integer> getbigestNumbers(Class<T> t,String where,String columnname){
    Session session= hibernateUtil.getSession();
    Transaction transaction = session.beginTransaction();

   ArrayList<Integer> numbers=new ArrayList<>();
    int i=0;
    try{
        String sql="select "+columnname+" from "+t.getSimpleName()+" " + where;
        List list=session.createSQLQuery(sql).list();
     Iterator it=list.iterator();
        while(it.hasNext()){
            if(i<=5){
            numbers.add((int)it.next());}
            i++;
        }
        transaction.commit();
    }
    catch(Exception e){

        e.printStackTrace();
    }
    finally {
        hibernateUtil.closeSession(session);//关闭会话

        System.out.println("close session!");
        return numbers;
    }
}

}
