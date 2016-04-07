package entity;

/**
 * Created by lazier on 2015/10/17 0017.
 */
public class Tag {
    private int tag_id;
    private String tag_name;
    private Tag parentTag;
    public Tag(){}

    public int getTag_id() {
        return tag_id;
    }

    public Tag getParentTag() {
        return parentTag;
    }

    public void setParentTag(Tag parentTag) {
        this.parentTag = parentTag;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }

    public String getTag_name() {
        return tag_name;
    }

    public void setTag_name(String tag_name) {
        this.tag_name = tag_name;
    }
    @Override
    public String toString(){
        return "tag";
    }
}
