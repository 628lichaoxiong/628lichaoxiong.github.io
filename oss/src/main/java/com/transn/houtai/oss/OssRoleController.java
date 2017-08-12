package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
 * 角色管理
 * @author james.li
 * @time  2017年3月24日 下午2:20:48
 */
@Controller
@RequestMapping("/ossRole")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 110002)
public class OssRoleController extends BaseController {
	Logger logger = LoggerFactory.getLogger(OssRoleController.class);
	
	/**
	 * OSS角色列表
	 * @Title: getRoleList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getRoleList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getRoleList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String roleName=request.getParameter("roleName");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("roleName", roleName);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetRoleList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss角色列表", e);
			e.printStackTrace();
		}
		return "ossrole/roleList";
	}
	
	/**
	 * @Title: toAddRole  
	 */
	@RequestMapping("/toAddRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  toAddRole(){ 
		return "ossrole/addRole";
	}
	/**
	 * @Title: toAddRole  
	 */
	@RequestMapping("/toUpdateRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String  toUpdateRole(Integer roleId,ModelMap modelMap){ 
		JSONObject obj=ossGetRoleInfo(roleId) ;
		JSONObject objj1= (JSONObject) obj .get("data");
		JSONObject objj2=(JSONObject) objj1.get("result");
		modelMap.put("ossRole", objj2);
		return "ossrole/updateRole";
	}
	
	/**
	 * 
	 * @Title: addRole  
	 * @Description: 添加角色
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addRole(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String roleName=request.getParameter("roleName");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("roleName", roleName);
			map.put("creator", getOssUserName(request));
			obj=OssAddOrUpdateRole(map);
		} catch (Exception e) {
			logger.info("oss添加角色", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: updateRole  
	 * @Description: 修改角色
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateRole(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String roleName=request.getParameter("roleName");
			String roleId=request.getParameter("roleId");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("roleName", roleName);
			map.put("mender", getOssUserName(request));
			map.put("roleId", roleId);
			obj=OssAddOrUpdateRole(map); 
		} catch (Exception e) {
			logger.info("修改角色", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: deleteRole  
	 * @Description: 删除角色
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DELETE)
	public Object deleteRole(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String roleId=request.getParameter("roleId");
			obj=ossGetDeleteRole(roleId,getOssUserName(request)); 
		} catch (Exception e) {
			logger.info("删除角色", e);
			e.printStackTrace();
		}
		return obj;
	}
	private JSONObject ossGetDeleteRole(String roleId,String ossName) {
		String url = Config.YXTSERVER9 + "ossRole/deleteRole?roleId="+roleId+"&ossName="+ossName;
		return getRestApiData(url);
	}
	private JSONObject ossGetRoleList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER9 + "ossRole/getRoleList?page="+n+"&pageSize="+s;
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssAddOrUpdateRole(Map requestParams) {
		String url = Config.YXTSERVER9 + "ossRole/addOrUpdateRole";
		return getRestApiData(url,requestParams);
	}
	private JSONObject ossGetRoleInfo(Integer roleId) {
		String url = Config.YXTSERVER9 + "ossRole/getRoleInfo?roleId="+roleId;
		return getRestApiData(url);
	}
	
}
