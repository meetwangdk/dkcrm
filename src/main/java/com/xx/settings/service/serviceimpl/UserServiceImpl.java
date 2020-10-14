package com.xx.settings.service.serviceimpl;

import com.xx.settings.dao.UserDao;
import com.xx.settings.domain.User;
import com.xx.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;


    @Override
    public User checkLogin(String username, String password) {
        User user = userDao.findByUsername(username);
        if(user != null && user.getLoginPwd().equals(password)){
            return user;
        }
        return null;
    }
}
