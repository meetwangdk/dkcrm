package com.crm.workbench.service.serviceImpl;

import com.crm.settings.dao.UserDao;
import com.crm.settings.domain.User;
import com.crm.workbench.dao.ClueDao;
import com.crm.workbench.domain.Clue;
import com.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private ClueDao clueDao;

    /*添加一条线索*/
    @Override
    public boolean addClue(Clue clue) {
        boolean flag = false;
        int i = clueDao.insertClue(clue);
        if (i>0){
            flag = true;
        }
        return flag;
    }
    /*查询用户信息，将用户信息展示到前台页面的下拉框中*/
    @Override
    public List<User> selectUser() {
        List<User> users = userDao.selectUserList();
        return users;
    }

    @Override
    public int selectClue() {
        int i = clueDao.selectClue();
        return i;
    }

    /*通过条件进行查询*/
    @Override
    public List<Clue> searchClueBy(Clue clue,int startPage,int pageSize) {
        List<Clue> clues = clueDao.selectClueBy(clue,startPage,pageSize);
        return clues;
    }

    @Override
    public boolean removeClueByIds(String[] ids) {
        boolean flag = false;
        int i = clueDao.selectClueByIds(ids);
        int o = clueDao.deleteClueByIds(ids);
        if (i==o){
            flag = true;
        }
        return flag;
    }

    @Override
    public Clue searchClueById(String id) {
        Clue clue = clueDao.selectClueById(id);
        return clue;
    }

    @Override
    public boolean editClue(Clue clue) {
        boolean flag = false;
        int i = clueDao.updateClue(clue);
        if (i>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public Clue selectClueById(String id) {
        Clue clue = clueDao.selectClueById(id);
        return clue;
    }
}
