package com.xx.settings.service;

import com.xx.settings.domain.User;

import javax.servlet.http.HttpServletRequest;

public interface UserService {
    User checkLogin(String loginAct, String loginPwd, HttpServletRequest request);
}
