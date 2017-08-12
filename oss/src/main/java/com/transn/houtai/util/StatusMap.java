package com.transn.houtai.util;

import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("serial")
public final class StatusMap {

	public static final Map<Integer, String> mapping;
	// 获取配置请求
	public static final int NO_RECEIVE = 1;//待领取
	public static final int NO_BIND = 2;//待绑定
	public static final int NO_ACTIVE = 3;//待激活
	public static final int ACTIVE = 4;//已激活
	public static final int USE = 5;//已启用
	public static final int CLOSE = 6;//已禁用
	
	static {
		mapping = new HashMap<Integer, String>(){{
			put(StatusMap.NO_RECEIVE ,  "待领取");
			put( StatusMap.NO_BIND,"待绑定");
			put(StatusMap.NO_ACTIVE , "待激活" );
			put(StatusMap.ACTIVE,  "已激活" );
			put(  StatusMap.USE,"已启用");
			put(StatusMap.CLOSE, "已禁用"  );
		}};
	}
	
	public static String getType ( Integer key ) {
		if(StatusMap.mapping.get( key )==null){
			return "";
		}else{
			return StatusMap.mapping.get( key );
		}
		
	}
}
