package com.xx.settings.service.serviceimpl;

import com.xx.settings.dao.UserDao;
import com.xx.settings.domain.User;
import com.xx.settings.exception.LoginException;
import com.xx.settings.service.UserService;
import com.xx.utils.DateTimeUtil;
import com.xx.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    //AutoWrited默认采用的时byType 要想要按名称注入则需要@Qualifier注解
    private UserDao userDao;
    @Override
    public User checkLogin(String loginAct, String loginPwd) {
        User user = userDao.findByUsername(loginAct);
        if(user != null && user.getLoginPwd().equals(loginPwd)){
            return user;
        }
        return null;
    }
}
