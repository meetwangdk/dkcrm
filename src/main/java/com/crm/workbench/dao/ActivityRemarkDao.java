package com.crm.workbench.dao;

import com.crm.workbench.domain.ActivityRemark;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityRemarkDao {
    int selectByActivityIds(String[] ids);
    int removeByActivityIds(String[] ids);
    List<ActivityRemark> selectByActivityDetailById(String id);

    int insertDetail(@Param("id") String id,
                     @Param("noteContent")  String noteContent,
                     @Param("createTime")  String createTime,
                     @Param("createBy")  String createBy,
                     @Param("editFlag")  String editFlag,
                     @Param("activityId")  String activityId);

    int deleteDetailById(String id);

    int editRemarkById(@Param("id") String id,@Param("noteContent")  String noteContent,@Param("editFlag")  String editFlag,
                       @Param("editTime") String editTime,@Param("editBy")  String editBy);
}
