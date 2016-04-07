package entity;

import java.io.Serializable;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class UserFavoriteTag implements Serializable {
    private static final long serialVersionUID = 1L;
    private Tag t;
    private User u;
public UserFavoriteTag(){}

    public Tag getT() {
        return t;
    }

    public void setT(Tag t) {
        this.t = t;
    }

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }
    @Override
    public String toString(){
        return "userfavoritetag";
    }
}
