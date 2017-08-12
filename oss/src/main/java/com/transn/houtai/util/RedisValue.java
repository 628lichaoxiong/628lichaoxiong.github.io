package com.transn.houtai.util;

public class RedisValue {
	public final static String  SplitIdAndName = "-";//缓存id和name的分隔符	
	
	/**
	 * redis 用户角色key
	 */
	public final static String SysRolesName = "transnSysRolesName";			// 系统所有角色
	public final static String SysUserRoleName = "transnSysUserRoleName_";			// 系统用户角色
	public final static String SysUserPermName = "nasha_user_perm";			// 系统用户角色
	public final static String SysFirstMenusName = "transnSysFirstMenusName";	// 系统所有1级菜单权限
	public final static String SysMenusName = "transnSysMenusName_";	// 系统所有菜单权限
//	public final static String SysUserRolePrivateName = "SysUserRolePrivateName_";	// 系统用户角色权限
	
	public final static String SystemStatusName = "SystemStatusName_";			// 系统状态名称
	public final static Integer SystemStatusNameTime = 60*60*24*5;			// 缓存存时间  5天
	public final static String SystemTypeName = "SystemTypeName_";			// 系统状态名称
	public final static Integer SystemTypeNameTime = 60*60*24*5;			// 缓存存时间  5天
	//oss 登录redis缓存
	public final static String OSSUserLoginName = "transnOSSUserLoginName_";
	public final static Integer OSSUserLoginNameTime = 60*60*1;			// 缓存存时间  1小时
}
