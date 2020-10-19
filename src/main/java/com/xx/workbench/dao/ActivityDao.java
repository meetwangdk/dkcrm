package com.xx.workbench.dao;

import com.xx.settings.domain.User;
import com.xx.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityDao {
    int addActivity(Activity activity);

    List<Activity> selectActivity(
            @Param("pageNo") String pageNO,
            @Param("pageSize") String pageSize,
            @Param("name") String name,
            @Param("owner") String owner,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
}
