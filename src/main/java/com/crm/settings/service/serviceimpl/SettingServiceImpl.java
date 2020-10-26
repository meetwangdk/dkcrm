package com.crm.settings.service.serviceimpl;

import com.crm.settings.dao.DicTypeDao;
import com.crm.settings.dao.DicValueDao;
import com.crm.settings.domain.DicType;
import com.crm.settings.domain.DicValue;
import com.crm.settings.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(value = "settingServiceImp")
public class SettingServiceImpl implements SettingService {
    @Autowired
    private DicTypeDao dicTypeDao;
    @Autowired
    private DicValueDao dicValueDao;

    @Override
    public Map<String,List<DicValue>> selectDicType() {

        Map<String,List<DicValue>> map = new HashMap<>();
        List<DicType> dicTypes = dicTypeDao.selectDicType();
        for (DicType dicType : dicTypes){
            String code = dicType.getCode();
            List<DicValue> list = dicValueDao.selectDicValues(code);
            map.put(code,list);
        }
        return map;
    }
}
