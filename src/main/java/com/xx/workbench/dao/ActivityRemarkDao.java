package com.xx.workbench.dao;

public interface ActivityRemarkDao {
    int selectByActivityId(String[] ids);
    int removeByActivityId(String[] ids);
}
