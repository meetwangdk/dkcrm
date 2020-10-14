package com.xx.settings.controller;

import com.xx.settings.domain.User;
import com.xx.settings.service.serviceimpl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/login.do")
    public ModelAndView doLogin(String username , String loginPwd, HttpServletRequest request){
        User user = userService.checkLogin(username,loginPwd,request);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        if (user != null){
            HttpSession session = request.getSession();
            session.setAttribute("user",user);
            return mv;
        }
        return null;
    }
}
