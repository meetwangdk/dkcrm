package com.crm.workbench.service.serviceImpl;

import com.crm.settings.dao.UserDao;
import com.crm.settings.domain.User;
import com.crm.utils.DateTimeUtil;
import com.crm.workbench.dao.ActivityDao;
import com.crm.workbench.dao.ActivityRemarkDao;
import com.crm.workbench.dao.ClueRemarkDao;
import com.crm.workbench.domain.Activity;
import com.crm.workbench.domain.ActivityRemark;
import com.crm.workbench.domain.ClueActivityRelation;
import com.crm.workbench.exception.RemoveException;
import com.crm.workbench.service.ActivityService;
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
    @Autowired
    private ClueRemarkDao clueRemarkDao;

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
    public Activity getActivityById(String id) {
        Activity activity = activityDao.selectActivityById(id);
        return activity;
    }

    @Override
    public boolean updateActivity(
            String owner,
            String id,
            String name ,
            String startDate ,
            String endDate ,
            String cost ,
            String description,
            String editBy){
            String editTime = DateTimeUtil.getSysTime();

        boolean flag = false;
        int i = activityDao.updateActivity(owner,id,name,startDate,endDate,cost,description ,editTime,editBy);
        if ( i > 0 ){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean createActivity(String id, String noteContext, String createTime, String createBy, String editFlag, String activityId) {
        boolean flag = false;
        int i = activityRemarkDao.insertDetail(id,noteContext,createTime,createBy,editFlag,activityId);
        if (i > 0){
            flag =true;
        }
        return flag;
    }

    @Override
    public List<ActivityRemark> selectDetailById(String id) {
        List<ActivityRemark> activityRemarks = activityRemarkDao.selectByActivityDetailById(id);
        return activityRemarks;
    }

    @Override
    public boolean removeDetailById(String id) {
        boolean flag = false;
        int i = activityRemarkDao.deleteDetailById(id);
        if (i > 0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean editRemarkById(String id, String noteContent, String editFlag, String editTime, String editBy) {
        boolean flag = false;
        int i = activityRemarkDao.editRemarkById(id,noteContent,editFlag,editTime,editBy);
        if (i > 0){
            flag = true;
        }
        return flag;
    }

    @Override
    public List<Activity> searchAcitvityListById(String id) {
        List<Activity>list = activityDao.selectClueActivityById(id);
        return list;
    }

    @Override
    public boolean removeClueActivityById(String id) {
        boolean flag = false;
        int i = activityDao.deleteClueActivityById(id);
        if (i>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public List<Activity> searchANameAndClueId(String aName, String clueId) {
        List<Activity> list = activityDao.searchANameAndClueId(aName,clueId);
        return list;
    }

    @Override
    public boolean relevanceActivity(List<ClueActivityRelation> list) {
        boolean flag = false;
        int a = clueRemarkDao.insertRelevanceActivity(list);
        if (a==list.size()){
            flag =  true;
        }
        return flag;
    }

    @Override
    public List<Activity> searchActivityByName(String name) {
        List<Activity> list = activityDao.searchActivityByName(name);
        return list;
    }
}
