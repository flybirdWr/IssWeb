package entity;

/**
 * Created by lazier on 2015/10/14 0014.
 */
public class User {
    public static final int ANONYMOUS = -1;
    public static final int FROZEN = 0;
    public static final int NORMAL = 1;
    public static final int ADMIN = 2;
    private int uid;
    private String username;
    private String email;
    private String phone;
    private String password;
    private int status=1;
    private String signature;
    /*
    -1 :游客
    0 ：冻结
    1：普通
    2：管理员
     */
    private boolean Activated=false;
    private String head;
    public User(){
    }
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public boolean getActivated() {
        return Activated;
    }

    public void setActivated(boolean Activated) {
        this.Activated = Activated;
    }
    @Override
    public String toString(){
        return "user";
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }
}
