package com.crm.workbench.controller;

import com.crm.settings.domain.User;
import com.crm.utils.DateTimeUtil;
import com.crm.utils.UUIDUtil;
import com.crm.workbench.domain.Activity;
import com.crm.workbench.domain.ActivityRemark;
import com.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {

    /*采用Spring中框架中的Autowired完成自动注入将*/
    @Autowired
    private ActivityService activityService;


    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List getUserList(){
        System.out.println("getUserList.do接受请求");
        List<User> userList = activityService.getUserList();
        return userList;
    }
    @RequestMapping("/addActivity.do")
    @ResponseBody

    public Map<String,Object> addActivity(Activity activity, HttpServletRequest request){
        activity.setId(UUIDUtil.getUUID());
        activity.setCreateTime(DateTimeUtil.getSysTime());
        User user = (User) request.getSession().getAttribute("user");
        activity.setCreateBy(user.getName());
        boolean flag = false;
        int result = activityService.saveActivity(activity);
        if (result > 0){
            flag = true;
        }
        Map<String,Object> map = new HashMap();
        map.put("activity",activity);
        map.put("success",flag);
        return map;
    }

    @RequestMapping("/pageList.do")
    @ResponseBody
    public Map<String,Object> pageList(String pageNo, String pageSize, String name, String owner, String startDate, String endDate){

        /*   一共12条记录
           第一页： 1   5   展示5条记录
        *  第二页： 5   5   展示5条记录
        *  第二页： 10  5   展示两条记录
        *   所以的出来结论就是（pageNo-1）*pageSize
        * */
        int no =  Integer.valueOf(pageNo);
        int size = Integer.valueOf(pageSize);
        int startPage = (no-1)*size;
        List<Activity> list = activityService.queryActivity(startPage,size,name,owner,startDate,endDate);
        int total = activityService.selectCountActivity(name, owner, startDate, endDate);
        Map<String,Object> map = new HashMap();
        map.put("total",total);
        map.put("list",list);
        return map;
    }
    @RequestMapping("/removeActivity.do")
    @ResponseBody
    @Transactional
    public boolean removeActivity(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        boolean flag = activityService.removeActivityByIds(ids);
        return flag;
    }
    @RequestMapping("/editActivity.do")
    @ResponseBody
    public Activity editActivity(String id){
        Activity activity = activityService.selectActivityById(id);
        return activity;
    }

    @RequestMapping("/updateActivity.do")
    @ResponseBody
    public boolean updateActivity(
            String owner,
            String id,
            String name ,
            String startDate ,
            String endDate ,
            String cost ,
            String description,
            HttpServletRequest request){
        /*ton通过当前Session作用域得到当前用户的id*/
        User user = (User) request.getSession().getAttribute("user");
//      本来是将用户的id添加进去的，现在直接添加姓名
        String editBy = user.getName();
        boolean flag = activityService.updateActivity(owner,id,name,startDate,endDate,cost,description,editBy);
        return flag;
    }
    @RequestMapping("/detail.do")
    @ResponseBody
    public ModelAndView detail(String id){
        ModelAndView mv = new ModelAndView();
        Activity activity = activityService.getActivityById(id);
        mv.addObject("activity",activity);
        mv.setViewName("activity/detail");
        return mv;
    }
    @RequestMapping("/getDetail.do")
    @ResponseBody
    public List<ActivityRemark> deatil(String id){
        List<ActivityRemark> activityRemarks = activityService.selectDetailById(id);
        return activityRemarks;
    }

    @RequestMapping("/saveDetail.do")
    @ResponseBody
    public boolean saveDetail(String id ,String noteContext,String createTime,String createBy,String activityId,HttpServletRequest request){
        id = UUIDUtil.getUUID();
        createTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        createBy = user.getName();
        String editFlag = "0" ;
        boolean flag = activityService.createActivity(id,noteContext,createTime,createBy,editFlag,activityId);
        return flag;
    }
    @RequestMapping("/removeActivityDetail.do")
    @ResponseBody
    public boolean removeDetail(String id){
        boolean flag = activityService.removeDetailById(id);
        return flag;
    }
    @RequestMapping("/editNoteContent.do")
    @ResponseBody
    public boolean editDetail(String id,String noteContent,HttpServletRequest request){
        String editTime = DateTimeUtil.getSysTime();
        User user = (User) request.getSession().getAttribute("user");
        String editBy =user.getName();
        String editFlag = "1";
        boolean flag = activityService.editRemarkById(id,noteContent,editFlag,editTime,editBy);
        return flag;
    }
}
