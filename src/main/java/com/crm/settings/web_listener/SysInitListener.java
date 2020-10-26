package com.crm.settings.web_listener;

import com.crm.settings.dao.DicTypeDao;
import com.crm.settings.domain.DicType;
import com.crm.settings.domain.DicValue;
import com.crm.settings.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SysInitListener implements ServletContextListener {
    /*创建全局作用域监听器对象：
        1、为了在服务器加载的时候将字典中的数据添加值全局作用域中，减轻了连接数据库的频繁操作
        2、servletContextEvent 该参数能够过去到监听器对象
    * */
    /*
    这样做是错误的，要理解spring 和 server 的 声明周期
    @Autowired
    private SettingService settingService;*/

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("全局作用域监听器对象创建了,采用的是监听器对象");
        /*不能采用自动注入的方式
        * 因为Listener的声明周期和spring的声明周期是不相同的
        * */
        WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContextEvent.getServletContext());
        SettingService settingService = (SettingService)context.getBean("settingServiceImp");
        ServletContext application = servletContextEvent.getServletContext();
        Map<String, List<DicValue>> map = settingService.selectDicType();
        Set<String> strings = map.keySet();
        Iterator<String> iterator = strings.iterator();
        if (iterator.hasNext()){
            String next = iterator.next();
            List<DicValue> list = map.get(next);
            application.setAttribute(next,list);
        }
    }
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
