package com.crm.settings.dao;

import com.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> selectDicValues(String typeCode);
}
