package com.crm.settings.service.serviceimpl;

import com.crm.settings.dao.UserDao;
import com.crm.settings.domain.User;
import com.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    //AutoWrited默认采用的时byType 要想要按名称注入则需要@Qualifier注解
    private UserDao userDao;
    @Override
    public User checkLogin(String loginAct, String loginPwd) {
        User user = userDao.findUser(loginAct);
        if(user != null && user.getLoginPwd().equals(loginPwd)){
            return user;
        }
        return null;
    }
}
