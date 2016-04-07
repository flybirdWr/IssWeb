package entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by lazier on 2015/11/15 0015.
 */
public class message  implements Serializable {

    private static final long serialVersionUID = 1L;
    private article a;
    private User u1;
    private User sender;
    private Date d;
    private boolean IsChecked=false;

    public article getA() {
        return a;
    }

    public void setA(article a) {
        this.a = a;
    }

    public User getU1() {
        return u1;
    }

    public void setU1(User u1) {
        this.u1 = u1;
    }


    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public Date getD() {
        return d;
    }

    public void setD(Date d) {
        this.d = d;
    }

    public boolean getIsChecked() {
        return IsChecked;
    }

    public void setIsChecked(boolean isChecked) {
        this.IsChecked = isChecked;
    }
}
