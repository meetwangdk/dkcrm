package com.crm.settings.web_filter;

import com.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest)servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse)servletResponse;
        User user = (User) httpServletRequest.getSession().getAttribute("user");
        /*System.out.println(user);*/
        String path = httpServletRequest.getServletPath();
        /*System.out.println("地址是:" + httpServletRequest.getServletPath());*/
        if ("/login.jsp".equals(path) || "/settings/user/login.do".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
        }
        /*在Session域中拿对象*/
        else if (user != null ){
           /* System.out.println("session中的对象" + user);*/
            filterChain.doFilter(servletRequest, servletResponse);
        } else {
            System.out.println(" 拦截非法用户请求 ");
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
        }
    }
    @Override
    public void destroy() {

    }
}
