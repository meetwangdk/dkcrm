package com.xx.workbench.controller;

import com.xx.settings.domain.User;
import com.xx.utils.DateTimeUtil;
import com.xx.utils.UUIDUtil;
import com.xx.workbench.domain.Activity;
import com.xx.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {
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
}
