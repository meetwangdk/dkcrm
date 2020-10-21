package com.xx.workbench.service.serviceImpl;

import com.xx.settings.dao.UserDao;
import com.xx.settings.domain.User;
import com.xx.workbench.dao.ActivityDao;
import com.xx.workbench.dao.ActivityRemarkDao;
import com.xx.workbench.domain.Activity;
import com.xx.workbench.exception.RemoveException;
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
    @Autowired
    private ActivityRemarkDao activityRemarkDao;

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
    public List<Activity> queryActivity(int startPage,int pageSize, String name, String owner, String startDate, String endDate) {
        List<Activity> list = activityDao.selectActivity( startPage, pageSize, name, owner, startDate, endDate);
        return list;
    }

    @Override
    public int selectCountActivity(String name, String owner, String startDate, String endDate) {
        int total = activityDao.selectCountActivity(name, owner, startDate, endDate);
        return total;
    }

    @Override
    public boolean removeActivityByIds(String[] ids) throws RemoveException {
        boolean flag = true;
        try {
            int count1 = activityRemarkDao.selectByActivityIds(ids);
            int count2 = activityRemarkDao.removeByActivityIds(ids);
            if (count1 != count2){
                flag = false;
                throw new RemoveException("查询与删除数目不对移除失败");
            }
            int count3 = activityDao.selectActivityByIds(ids);
            int count4 = activityDao.removeActivityByIds(ids);
            if (count3 !=count4){
                flag = false;
                throw new RemoveException("查询与删除数目不对移除失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    @Override
    public Activity selectActivityById(String id) {
        Activity activity = activityDao.selectActivityById(id);
        return activity;
    }

    @Override
    public boolean updateActivity(
            String owner, String id,
            String name ,
            String startDate ,
            String endDate ,
            String cost ,
            String description) {
        boolean flag = false;
        int i = activityDao.updateActivity(owner,id,name,startDate,endDate,cost,description);
        if ( i > 0 ){
            flag = true;
        }
        return flag;
    }
}
