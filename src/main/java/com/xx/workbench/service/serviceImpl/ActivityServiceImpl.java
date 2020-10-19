package com.xx.workbench.service.serviceImpl;

import com.xx.settings.dao.UserDao;
import com.xx.settings.domain.User;
import com.xx.workbench.dao.ActivityDao;
import com.xx.workbench.domain.Activity;
import com.xx.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private ActivityDao activityDao;

    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.selectUserList();
        return userList;
    }

    @Override
    public int saveActivity(Activity activity) {
        int res = activityDao.addActivity(activity);
        return res;

    }

    @Override
    public List<Activity> queryActivity(String pageNO, String pageSize, String name, String owner, String startDate, String endDate) {
        List<Activity> list = activityDao.selectActivity( pageNO, pageSize, name, owner, startDate, endDate);
        return list;
    }
}
