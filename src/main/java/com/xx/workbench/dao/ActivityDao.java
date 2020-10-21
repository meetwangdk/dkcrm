package com.xx.workbench.dao;

import com.xx.settings.domain.User;
import com.xx.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityDao {
    int addActivity(Activity activity);

    List<Activity> selectActivity(
            @Param("startPage") int startPage,
            @Param("pageSize") int pageSize,
            @Param("name") String name,
            @Param("owner") String owner,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    int selectCountActivity(@Param("name") String name,
                            @Param("owner") String owner,
                            @Param("startDate") String startDate,
                            @Param("endDate") String endDate);

    int removeActivityByIds(String[] ids);
    int selectActivityByIds(String[] ids);

    Activity selectActivityById(String id);

    int updateActivity(
            @Param("owner") String owner,
            @Param("id") String id,
            @Param("name") String name ,
            @Param("startDate") String startDate ,
            @Param("endDate") String endDate ,
            @Param("cost") String cost ,
            @Param("description") String description);
}
