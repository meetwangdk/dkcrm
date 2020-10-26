package com.crm.workbench.service;

import com.crm.settings.domain.User;
import com.crm.workbench.domain.Activity;
import com.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityService {

    List<User> getUserList();

    int saveActivity(Activity activity);

    List<Activity> queryActivity( int startPage,
                                  int pageSize,
                                  String name,
                                  String owner,
                                  String startDate,
                                  String endDate);
    int selectCountActivity( String name,
                             String owner,
                             String startDate,
                             String endDate);
    boolean removeActivityByIds(String[] ids);

    Activity selectActivityById(String id);

    boolean updateActivity(
            String owner,
            String id,
            String name ,
            String startDate ,
            String endDate ,
            String cost ,
            String description,
            String editBy);

    Activity getActivityById(String id);

    List<ActivityRemark> selectDetailById(String id);

    boolean createActivity(String id, String noteContext, String createTime, String createBy, String editFlag, String activityId);

    boolean removeDetailById(String id);

    boolean editRemarkById(String id, String noteContent, String editFlag, String editTime, String editBy);
}
