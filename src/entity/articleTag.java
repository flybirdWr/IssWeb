package entity;

import java.io.Serializable;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class articleTag  implements Serializable {
    private static final long serialVersionUID = 1L;
    private article a;
    private Tag t;
//    private int article_id;
//    public void setArticle_id(int id){
//        article_id = id;
//    }
//    public int getArticle_id(){
//        return this.article_id;
//    }
    public article getA() {
        return a;
    }

    public void setA(article a) {
        this.a = a;
    }

    public Tag getT() {
        return t;
    }

    public void setT(Tag t) {
        this.t = t;
    }
    @Override
    public String toString(){
        return "articletag";
    }
}
