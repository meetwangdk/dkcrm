package com.crm.workbench.dao;

import com.crm.workbench.domain.Clue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClueDao {


    int insertClue(Clue clue);

    List<Clue> selectClueBy(@Param("clue") Clue clue, @Param("startPage") int startPage ,@Param("pageSize") int pageSize);

    int selectClue();

    int updateClue(Clue clue);

    Clue selectClueById(String id);

    int selectClueByIds(String[] ids);

    int deleteClueByIds(String[] ids);
}
