import java.util.UUID;

/**
 * Created by Administrator on 2015/11/4.
 */
public class Test {
    public static void main(String[] args) {
        String uuid = String.format("Passenger:%s", UUID.randomUUID().toString());
        System.out.println(uuid);
    }
}
