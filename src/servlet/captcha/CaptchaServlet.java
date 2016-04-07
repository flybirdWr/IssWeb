package servlet.captcha;

import servlet.captcha.validation.Validation;
import util.PathConst;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Created by Administrator on 2015/11/6.
 */
@WebServlet(name = "CaptchaServlet", urlPatterns = {PathConst.ServletPath.captcha_servlet})
public class CaptchaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Validation v = new Validation();
        v.setSize(150, 40);
        v.setCode(5);
        v.writeSession(req.getSession());
        BufferedImage img = v.getPngImage();
        OutputStream os = resp.getOutputStream();
        ImageIO.write(img, "png", os);
        os.flush();
        os.close();
    }
}
