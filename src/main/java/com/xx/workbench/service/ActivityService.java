package com.xx.workbench.service;

import com.xx.settings.domain.User;
import com.xx.workbench.domain.Activity;

import java.util.List;

public interface ActivityService {
    List<User> getUserList();
    int saveActivity(Activity activity);


}
