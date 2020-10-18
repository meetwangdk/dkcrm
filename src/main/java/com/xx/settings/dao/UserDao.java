package com.xx.settings.dao;

import com.xx.settings.domain.User;

import java.util.List;

public interface UserDao {

    List<User> selectUserList();
    /*通过姓名查询用户全部信息*/
    User findUser(String loginAct);
}
