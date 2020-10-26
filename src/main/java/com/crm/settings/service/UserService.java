package com.crm.settings.service;

import com.crm.settings.domain.User;

public interface UserService {
    User checkLogin(String loginAct, String loginPwd);
}
