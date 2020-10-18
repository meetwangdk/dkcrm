package com.xx.settings.controller;

import com.xx.settings.domain.User;
import com.xx.settings.exception.LoginException;
import com.xx.settings.service.UserService;
import com.xx.utils.DateTimeUtil;
import com.xx.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/settings/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/login.do")
    @ResponseBody
    public Map doLogin(String loginAct , String loginPwd, HttpServletRequest request) {
        System.out.println(loginAct+"----"+loginPwd);
        Map<String, Object> map = new HashMap<>();
        String date = DateTimeUtil.getSysTime();
        String md5 = MD5Util.getMD5(loginPwd);
        System.out.println(md5);
        boolean flag = false ;
        String msg = "";
        try{
            User user = userService.checkLogin(loginAct, md5);
            if (user==null){
                throw new LoginException("用户名或密码错误");
            }
            else{
                if ("0".equals(user.getLockState())){
                    throw new LoginException("用户已经锁定");
                }if (user.getExpireTime().compareTo(date) < 0){
                    throw  new LoginException("用户信息已经过时");
                }
                request.getSession().setAttribute("user",user);
                flag = true;
            }
        }catch (Exception e){
            e.printStackTrace();
            msg = e.getMessage();
        }
        map.put("msg",msg);
        map.put("flag",flag);
        map.put("page","workbench/index.jsp");
        return map;
    }
}