package com.crm.settings.dao;

import com.crm.settings.domain.DicType;

import java.util.List;

public interface DicTypeDao {
    public abstract List<DicType> selectDicType();
}
