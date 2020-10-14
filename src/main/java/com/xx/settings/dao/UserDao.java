package com.xx.settings.dao;

import com.xx.settings.domain.User;

public interface UserDao {
    User findByUsername(String loginAct);
}
