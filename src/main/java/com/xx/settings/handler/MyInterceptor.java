package com.xx.settings.handler;

import com.xx.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor implements HandlerInterceptor {
    User user = null;
    //拦截"/addGoods"和"/login"请求
    private static final String login = "/settings/user/login.do";
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //        System.out.println("拦截器中的MyInterceptor中的preHandle方法执行");
//        Object ref = request.getSession().getAttribute("user");
//        System.out.println(ref);
//        if (ref != null){
//            user = (User)ref;
//            return true;
//        }
//        request.setAttribute("mag","请合法进行访问");
//        response.sendRedirect(request.getContextPath() + "/login.jsp");
//        return false;

        boolean flag = true;
        //拦截请求
            //1.获取session中的用户
            User user = (User)request.getSession().getAttribute("user");
            //2.判断用户是否已经登录
            if(user == null) {
                String path = request.getServletPath();
                System.out.println(path);
                if (path.equals(login)){
                    flag = true;
                }else {
                    //验证还未登录，跳转至登录界面
                    System.out.println("AuthorizationInterceptor拦截请求：");
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    flag = false;
                }

            } else {
                //如果用户已经登录，则验证通过，放行
                System.out.println("AuthorizationInterceptor放行请求：");
                flag = true;
            }
        return flag;
    }
}

