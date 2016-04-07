package filter;

import util.KeyConst;
import util.PathConst;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Administrator on 2015/10/28.
 */
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();
        Object lock = session.getAttribute(KeyConst.SUPER_ADMIN);
        if (lock != null) {
            filterChain.doFilter(request, response);
        } else {
            response.sendRedirect(PathConst.PagePath.admin_login);
        }
    }

    @Override
    public void destroy() {

    }
}
