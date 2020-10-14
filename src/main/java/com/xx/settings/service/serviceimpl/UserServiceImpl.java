package com.xx.settings.service.serviceimpl;

import com.xx.settings.dao.UserDao;
import com.xx.settings.domain.User;
import com.xx.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;


    @Override
    public User checkLogin(String loginAct, String loginPwd , HttpServletRequest request) {
        User user = userDao.findByUsername(loginAct);
        if(user != null && user.getLoginPwd().equals(loginPwd)){
            return user;
        }
        return null;
    }
}
