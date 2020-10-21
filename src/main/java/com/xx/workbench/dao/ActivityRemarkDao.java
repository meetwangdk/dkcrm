package com.xx.workbench.dao;

public interface ActivityRemarkDao {
    int selectByActivityIds(String[] ids);
    int removeByActivityIds(String[] ids);
}
