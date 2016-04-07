package entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class UserFavoriteArticle  implements Serializable {
    private static final long serialVersionUID = 1L;
    private User u;
    private article a;
    private Date start_date;
    private  Date due_time;
    private boolean IsChecked=false;
    public UserFavoriteArticle(){}

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }

    public article getA() {
        return a;
    }

    public void setA(article a) {
        this.a = a;
    }

    public boolean getIsChecked() {
        return IsChecked;
    }

    public void setIsChecked(boolean isChecked) {
        this.IsChecked = isChecked;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getDue_time() {
        return due_time;
    }

    public void setDue_time(Date due_time) {
        this.due_time = due_time;
    }
    @Override
    public String toString(){
        return "userfavoritearticle";
    }
}
