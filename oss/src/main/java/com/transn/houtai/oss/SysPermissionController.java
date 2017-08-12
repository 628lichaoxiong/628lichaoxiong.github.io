package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;
/**
 * oss 角色权限
 * @author james.li
 * @time  2017年3月24日 下午2:20:48
 */
@Controller
@RequestMapping("/sysPermission")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 110003)
public class SysPermissionController extends BaseController {
	Logger logger = LoggerFactory.getLogger(SysPermissionController.class);
	
	/**
	 * OSS获取所有的操作权限
	 * @Title: getSysRolePermList  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getSysRolePermList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getSysRolePermList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String roleId =request.getParameter("roleId");
			if(StringUtils.isBlank(roleId)){
				roleId="0"; 
			}
			obj=ossGetSysRolePermList(roleId);
			JSONObject objj1= (JSONObject) obj .get("data");
			JSONObject objj2=(JSONObject) objj1.get("result");
			modelMap.put("result", objj2);
			modelMap.put("roleId", roleId);
		} catch (Exception e) {
			logger.info("oss获取所有的操作权限", e);
			e.printStackTrace();
		}
		return "sysperm/permList";
	}
	
	/**
	 * 
	 * @Title: updatePerm  
	 * @Description:设置角色权限
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updatePerm")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updatePerm(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String roleId=request.getParameter("roleId");
			//所有选中的菜单功能
			String menufuncs[] = request.getParameterValues("menufuncs");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("roleId", roleId);
			map.put("menufuncs", JSONObject.toJSONString(menufuncs));
			map.put("userName", getOssUserName(request));
			obj=ossUpdatePerm(map);  
		} catch (Exception e) {
			logger.info("设置用户角色", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	private JSONObject ossGetSysRolePermList(String roleId) {
		String url = Config.YXTSERVER9 + "ossRolePrivate/index?roleId="+roleId;
		return getRestApiData(url);
	}
	private JSONObject ossUpdatePerm(Map requestParams) {
		String url = Config.YXTSERVER9 + "ossRolePrivate/modify";
		return getRestApiData(url,requestParams);
	}


	
}
