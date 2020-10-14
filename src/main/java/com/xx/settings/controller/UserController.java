package com.xx.settings.controller;

import com.xx.settings.domain.User;
import com.xx.settings.service.serviceimpl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/login.do")
    public ModelAndView doLogin(String username ,String loginPwd ){
        User user = userService.checkLogin(username,loginPwd);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        if (user != null){
            return mv;
        }
        return null;
    }
}
