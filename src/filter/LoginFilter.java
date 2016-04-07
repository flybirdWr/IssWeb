package filter;

import util.KeyConst;
import util.PathConst;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * WENKE:
 * Barrier all non-login users
 * used for pages except login and register
 */
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // cast request and response objects to HttpServletXXXX
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;

        // Check whether the user is in session
        HttpSession session = request.getSession();
        if (session.getAttribute(KeyConst.USER)==null){
            // if not in session, i.e. the user hasn't log in
            // then redirect the user to login page
            response.sendRedirect(PathConst.PagePath.login);
        } else {
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
