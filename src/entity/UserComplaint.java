package entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by lazier on 2015/10/14 0014.
 */
public class UserComplaint implements Serializable {
    private static final long serialVersionUID = 1L;
    private User u;
    private article a;
    private String ctext;
    private Date ctime;
public UserComplaint(){}

    public article getA() {
        return a;
    }

    public void setA(article a) {
        this.a = a;
    }

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }

    public String getCtext() {
        return ctext;
    }

    public void setCtext(String uxtext) {
        this.ctext = ctext;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }
    @Override
    public String toString(){
        return "usercomplaint";
    }
}
