package com.crm.workbench.dao;

import com.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueRemarkDao {

    int insertRelevanceActivity(List<ClueActivityRelation> list);

}
