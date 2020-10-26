package com.crm.settings.dao;

import com.crm.settings.domain.User;

import java.util.List;

public interface UserDao {

    List<User> selectUserList();
    /*通过姓名查询用户全部信息*/
    User findUser(String loginAct);
}
