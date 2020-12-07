package com.crm.workbench.dao;

import com.crm.workbench.domain.Activity;
import com.crm.workbench.domain.ClueActivityRelation;
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
            @Param("description") String description,
            @Param("editTime") String editTime,
            @Param("editBy") String editBy
            );

    List<Activity> selectClueActivityById(String id);

    int deleteClueActivityById(String id);

    List<Activity> searchANameAndClueId(@Param("aName") String aName,@Param("clueId") String clueId);


    List<Activity> searchActivityByName(String name);
}
