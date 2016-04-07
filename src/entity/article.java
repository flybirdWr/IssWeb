package entity;

import DAO.BasicDao;

import java.util.Date;
import java.util.List;

/**
 * Created by lazier on 2015/10/14 0014.
 */
public class article {
    public static final int MAIN = 1;
    private int article_id;
    private String title;
    //private String author;//外键映射到uid
    private Date date;
    private String text;
    private User u;
    private int tree_level=0;
    /*
    1为主题帖
    >=2位为回复
     */
    private article parentArticle;
public article(){


}

    public int getArticle_id() {
        return article_id;
    }

    public article getParentArticle() {
        return parentArticle;
    }

    public void setParentArticle(article parentArticle) {
        this.parentArticle = parentArticle;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

//    public String getAuthor() {
//        return author;
//    }
//
//    public void setAuthor(String author) {
//        this.author = author;
//    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

//    public String getParent_article() {
//        return parent_article;
//    }
//
//    public void setParent_article(String parent_article) {
//        this.parent_article = parent_article;
//    }

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }

    public int getTree_level() {
        return tree_level;
    }

    public void setTree_level(int tree_level) {
        this.tree_level = tree_level;
    }

    public void setConcreteUser(int uid){
        List<User> u1= BasicDao.select("where uid="+uid,User.class);
        for(User u2:u1){
            u.setUsername(u2.getUsername());
            u.setPassword(u2.getPassword());
            u.setPhone(u2.getPhone());
            u.setEmail(u2.getEmail());
            u.setActivated(u2.getActivated());
            u.setHead(u2.getHead());
            u.setStatus(u2.getStatus());
        }
    }

    @Override
    public String toString(){
        return "article";
    }
}
