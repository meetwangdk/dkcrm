package com.crm.workbench.service;

import com.crm.settings.domain.User;
import com.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueService {
    public abstract List<User> selectUser();

    boolean addClue(Clue clue);

    List<Clue> searchClueBy(Clue clue,int startPage,int pageSize);

    int selectClue();

    boolean editClue(Clue clue);

    Clue searchClueById(String id);

    boolean removeClueByIds(String[] ids);

    Clue selectClueById(String id);
}
