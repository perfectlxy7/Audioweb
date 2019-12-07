package com.audioweb.service;

import com.niocast.entity.MonitorInfoBean;

/** *//** 
 * 获取系统信息的业务逻辑类接口. 
 * @author amg * @version 1.0  
 * Creation date: 2008-3-11 - 上午10:06:06 
 */  
public interface IMonitorManager {  
    /** *//** 
     * 获得当前的监控对象. 
     * @return 返回构造好的监控对象 
     * @throws Exception 
     * @author amgkaka 
     * Creation date: 2008-4-25 - 上午10:45:08 
     */  
    public MonitorInfoBean getMonitorInfoBean() throws Exception;  
  
}