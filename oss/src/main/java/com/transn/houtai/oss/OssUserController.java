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
import com.transn.houtai.util.MD5;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;
/**
 * oss 用户管理
 * @author james.li
 * @time  2017年3月24日 下午2:20:48
 */
@Controller
@RequestMapping("/ossUser")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 110001)
public class OssUserController extends BaseController {
	Logger logger = LoggerFactory.getLogger(OssUserController.class);
	
	/**
	 * OSS用户列表
	 * @Title: getUserList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getUserList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getUserList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String phonenumber=request.getParameter("phonenumber");
			String username=request.getParameter("username");
			String name=request.getParameter("name");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("name", name);
			map.put("username", username);
			map.put("phonenumber", phonenumber);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetUserList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取用户信息", e);
			e.printStackTrace();
		}
		return "ossuser/userList";
	}
	
	/**
	 * @Title: toAddUser  
	 */
	@RequestMapping("/toAddUser")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  toAddUser(){ 
		return "ossuser/addUser";
	}
	/**
	 * @Title: toAddUser  
	 */
	@RequestMapping("/toUpdateUser")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String  toUpdateUser(Integer userId,ModelMap modelMap){ 
		JSONObject obj=ossGetUserInfo(userId) ;
		JSONObject objj1= (JSONObject) obj .get("data");
		JSONObject objj2=(JSONObject) objj1.get("result");
		modelMap.put("ossUser", objj2);
		return "ossuser/updateUser";
	}
	
	/**
	 * 
	 * @Title: addUser  
	 * @Description: 添加用户
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addUser")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addUser(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String phonenumber=request.getParameter("phonenumber");
			String username=request.getParameter("username");
			String name=request.getParameter("name");
			String passwd=request.getParameter("passwd");
			String useremail=request.getParameter("useremail");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("name", name);
			map.put("username", username);
			map.put("phonenumber", phonenumber);
			map.put("passwd", MD5.MD5tool(passwd));
			map.put("useremail", useremail);
			map.put("groups", "2");//陪同版
			obj=OssAddOrUpdateUser(map);
		} catch (Exception e) {
			logger.info("oss添加用户", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: updateUser  
	 * @Description: 修改用户
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateUser")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateUser(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String phonenumber=request.getParameter("phonenumber");
			String username=request.getParameter("username");
			String name=request.getParameter("name");
//			String passwd=request.getParameter("passwd");
			String userId=request.getParameter("userId");
			String useremail=request.getParameter("useremail");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("name", name);
			map.put("username", username);
			map.put("phonenumber", phonenumber);
//			map.put("passwd", passwd);
			map.put("id", userId+"");//陪同版 Templte请求不支持Integer
			map.put("useremail", useremail);
			obj=OssAddOrUpdateUser(map); 
		} catch (Exception e) {
			logger.info("修改用户", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: deleteUser  
	 * @Description: 删除用户
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteUser")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object deleteUser(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String userId=request.getParameter("userId");
			obj=ossGetDeleteUser(userId,getOssUserName(request)); 
		} catch (Exception e) {
			logger.info("删除用户", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: setRole  
	 * @Description: 设置用户角色
	 * @return
	 * @return Object
	 */
	@RequestMapping("/toSetRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String toSetRole(HttpServletRequest request,ModelMap model){
		JSONObject obj=null;
		try { 
			String userId=request.getParameter("userId");
			obj=ossGetToSetRole(userId);
			JSONObject objj1= (JSONObject) obj .get("data");
			JSONObject objj2=(JSONObject) objj1.get("result");
			model.put("result", objj2);
		} catch (Exception e) {
			logger.info("设置用户角色", e);
			e.printStackTrace();
		}
		return "ossuser/setRole";  
	}
	/**
	 * 
	 * @Title: setRole  
	 * @Description: 设置用户角色
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/setRole")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object setRole(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String userId=request.getParameter("userId");
			//所有选中的菜单功能
			String userRoles[] = request.getParameterValues("userRoles");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("userId", userId);
			map.put("userRoles", JSONObject.toJSONString(userRoles));
			map.put("userName", getOssUserName(request));
			obj=ossSetRole(map); 
		} catch (Exception e) {
			logger.info("设置用户角色", e);
			e.printStackTrace();
		}
		return obj;
	}
	private JSONObject ossGetDeleteUser(String userId,String ossName) {
		String url = Config.YXTSERVER9 + "ossUser/deleteUser?userId="+userId+"&ossName="+ossName;
		return getRestApiData(url);
	}
	private JSONObject ossGetUserList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER9 + "ossUser/getUserList?page="+n+"&pageSize="+s;
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssAddOrUpdateUser(Map requestParams) {
		String url = Config.YXTSERVER9 + "ossUser/addOrUpdateUser";
		return getRestApiData(url,requestParams);
	}
	private JSONObject ossGetUserInfo(Integer userId) {
		String url = Config.YXTSERVER9 + "ossUser/getUserInfo?userId="+userId;
		return getRestApiData(url);
	}
	private JSONObject ossGetToSetRole(String userId) {
		String url = Config.YXTSERVER9 + "ossRole/toSetRole?userId="+userId;
		return getRestApiData(url);
	}
	private JSONObject ossSetRole(Map requestParams) {
		String url = Config.YXTSERVER9 + "ossRole/setRole";
		return getRestApiData(url,requestParams);
	}


	
}
