package servlet;

import DAO.BasicDao;
import entity.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import util.KeyConst;
import util.PathConst;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/11/7.
 */
@WebServlet(name = "HeadServlet", urlPatterns = {PathConst.ServletPath.head_servlet})
public class HeadServlet extends HttpServlet {

    String baseURL = "";

    @Override
    public void init() throws ServletException {
        baseURL = getServletContext().getRealPath("/")+"/user_data/";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
       // System.out.println(req.getContentType());
       // System.out.println(req.getContentLength());
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload fileUpload = new ServletFileUpload(factory);
        OutputStream outputStream = null;
        InputStream inputStream = null;
        String fname = req.getParameter(KeyConst.FILENAME);
        System.out.println("fanme:"+fname);
        if(fname==null){
            resp.sendRedirect(req.getHeader("Referer")+"?error=请点击要上传的图片");
        }else{


        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(KeyConst.USER);
        try {
            List items = fileUpload.parseRequest(req);
            byte[] bs = new byte[1024];
            for (Iterator iterator = items.iterator(); iterator.hasNext(); ) {
                FileItem name = (FileItem) iterator.next();

                if (!name.isFormField()) {
                    String fileName = name.getName();
                    System.out.println("fileName"+fileName);
                    if(fileName==""){
                        System.out.println("NULL!!!");
                        return;
                    }

                    String lastFileName = baseURL
                            + fname
                            + fileName.substring(fileName.lastIndexOf("."), fileName.length());
                    user.setHead(fname + fileName.substring(fileName.lastIndexOf("."), fileName.length()));
                    BasicDao.saveOrUpdate(user);
                    outputStream = new FileOutputStream(new File(lastFileName));
                    inputStream = name.getInputStream();
                    int length = 0;
                    while (null != inputStream && (length = inputStream.read(bs)) != -1) {
                        outputStream.write(bs);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            outputStream.flush();
            outputStream.close();
            resp.sendRedirect(req.getHeader("Referer"));
        }
    }
    }

}
