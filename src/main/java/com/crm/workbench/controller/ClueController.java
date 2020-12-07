package com.crm.workbench.controller;

import com.crm.settings.domain.User;
import com.crm.utils.DateTimeUtil;
import com.crm.utils.UUIDUtil;
import com.crm.workbench.domain.Activity;
import com.crm.workbench.domain.Clue;
import com.crm.workbench.domain.ClueActivityRelation;
import com.crm.workbench.service.ActivityService;
import com.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("/workbench/clue")
public class ClueController {
    @Autowired
    private ClueService clueService;
    @Autowired
    private ActivityService activityService;
    @RequestMapping("/addUser.do")
    @ResponseBody
    public List selectUser(){
        List<User> users = clueService.selectUser();
        return users;
    }

    @RequestMapping(value = "saveClue.do")
    @ResponseBody
    public boolean addClue(Clue clue, HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getId();
        clue.setCreateBy(createBy);
        clue.setCreateTime(createTime);
        clue.setId(id);
        boolean flag  = clueService.addClue(clue);
        return flag;
    }


    @RequestMapping("/selectClueList.do")
    @ResponseBody
    /*pageNo 当前页码
     * pageSize 一页中有几条数据
     * */
    public Map<String,Object> clue(Clue clue ,int pageNo , int pageSize){
        int startPage = (pageNo-1)*pageSize;
        Map<String,Object> map = new HashMap();
        List<Clue> clues = clueService.searchClueBy(clue,startPage,pageSize);
        int total = clueService.selectClue();
        map.put("total",total);
        map.put("list",clues);
        return map;
    }

    @RequestMapping("/editClue.do")
    @ResponseBody
    public boolean editClue(Clue clue,HttpServletRequest request){
        String editTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String id = user.getId();
        clue.setEditBy(id);
        clue.setEditTime(editTime);
        boolean flag = clueService.editClue(clue);
        return flag;
    }
    @RequestMapping("/selectByClueId.do")
    @ResponseBody
    public Clue selectByClueId(String id){
        Clue clue = clueService.searchClueById(id);
        return clue;
    }
    @RequestMapping("/removeClue.do")
    @ResponseBody
    @Transactional
    public boolean removeClueById(HttpServletRequest request){
        String[]  ids = request.getParameterValues("id");
        boolean flag = clueService.removeClueByIds(ids);
        return flag;
    }


    @RequestMapping("/detail.do")
    @ResponseBody
    public ModelAndView clueDetail(String id){
        Clue clue = clueService.selectClueById(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("clue",clue);
        mv.setViewName("clue/detail");
        return mv;
    }
    @RequestMapping("clueActivityList.do")
    @ResponseBody
    public List<Activity> selectClueActivityById(String id){
        List<Activity> list = activityService.searchAcitvityListById(id);
        return list;
    }

    @RequestMapping("deleteClueActivity.do")
    @ResponseBody
    public boolean removeClueActivityById(String id){
        boolean flag = activityService.removeClueActivityById(id);
        return flag;
    }
    @RequestMapping(value = "/searchByANameAndClueId.do")
    @ResponseBody
    public List<Activity> searchANameAndClueId(String aName,String clueId){
        List<Activity> list = activityService.searchANameAndClueId(aName,clueId);
        return list;
    }

    /*将活动和当前对象进行关联操作*/
    /*@RequestMapping("/relevanceActivity.do")
    @ResponseBody
    public boolean relevanceActivity(HttpServletRequest request , String clueId){
        List<ClueActivityRelation> list = new ArrayList<>();
        String[] ids = request.getParameterValues("id");
        for (String id : ids){
            String carId = UUIDUtil.getUUID();
            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(carId);
            car.setClueId(clueId);
            car.setActivityId(id);
            list.add(car);
            System.out.println(car);
        }
        boolean flag = activityService.relevanceActivity(list);
        return flag;
    }*/

    @RequestMapping("/relevanceActivity.do")
    @ResponseBody
    public boolean relevanceActivity(String iDs,String clueId){
        List<ClueActivityRelation> list = new ArrayList<>();
        String[] ids = iDs.split(",");
        System.out.println(ids);
        for (int i = 0; i < ids.length; i++) {
            System.out.println(ids[i]);
            String carId = UUIDUtil.getUUID();
            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(carId);
            car.setClueId(clueId);
            car.setActivityId(ids[i]);
            list.add(car);
            System.out.println(car);
        }

        boolean flag = activityService.relevanceActivity(list);
        return flag;
    }
    /*根据clue中的用户输入框中的内容查询activity*/
    @RequestMapping("/searchActivityByName.do")
    @ResponseBody
    public List searchActivityByName(String name){
        List<Activity> list = activityService.searchActivityByName(name);
        return list;
    }
}
