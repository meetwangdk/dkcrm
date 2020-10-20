package com.xx.workbench.service;

import com.xx.settings.domain.User;
import com.xx.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

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
    boolean removeActivityById(String[] ids);
}
