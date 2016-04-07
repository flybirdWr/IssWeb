package entity;

import java.io.Serializable;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class articleJudgement implements Serializable {
    private static final long serialVersionUID = 1L;
    private article a;
    private User u;
    private int thumb_or_step=0;//0表示未评价，1表示赞，-1表示踩
    public static final int THUMB = 1;
    public static final int STEP = -1;
    public static final int NONE = 0;
    public articleJudgement(){}

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

    public int getThumb_or_step() {
        return thumb_or_step;
    }

    public void setThumb_or_step(int thumb_or_step) {
        this.thumb_or_step = thumb_or_step;
    }
    @Override
    public String toString(){
        return "articlejudgement";
    }
}
