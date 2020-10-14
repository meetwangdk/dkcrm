package com.xx.settings.service;

import com.xx.settings.domain.User;

public interface UserService {
    User checkLogin(String username, String password);
}
