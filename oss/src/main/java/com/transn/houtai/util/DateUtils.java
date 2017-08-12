package com.transn.houtai.util;

import java.text.SimpleDateFormat;  
import java.util.Date;

import org.apache.commons.lang.StringUtils;  
  
public class DateUtils {  
  
    /** 
     * 获得yyyy-MM-dd格式的当前日期 
     */  
    public static String getNowTime() {  
        Date date = new Date();  
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
        return dateFormat.format(date);  
    }  
    /** 
     * 获得yyyy-MM-dd格式的当前日期 
     */  
    public static String getStrTime(Date date,String fmt) {  
    	if(date ==null){
    		 date = new Date();  
    	}
    	if(StringUtils.isBlank(fmt)){
    		fmt="yyyy-MM-dd HH:mm:ss";
    	}
    	SimpleDateFormat dateFormat = new SimpleDateFormat(fmt);  
    	return dateFormat.format(date);  
    }  
  
}  
