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
 * 标签管理
 * @author james.li
 * @time  2017年6月25日 上午10:57:37
 */
@Controller
@RequestMapping("/label")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100702)
public class LabelController extends BaseController {
	Logger logger = LoggerFactory.getLogger(LabelController.class);
	
	/**
	 * 系统标签列表
	 * @Title: getLabelList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getLabelList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getLabelList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String labelName=request.getParameter("username");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("labelName", labelName);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetLabelList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取系统标签信息", e);
			e.printStackTrace();
		}
		return "labelsystem/labelList";
	}
	
	/**
	 * @Title: toAddLabel  
	 */
	@RequestMapping("/toAddLabel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  toAddLabel(){ 
		return "labelsystem/addOrUpdateLabel";
	}
	/**
	 * @Title: toAddLabel  
	 */
	@RequestMapping("/toUpdateLabel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String  toUpdateLabel(Integer id,String labelName,ModelMap modelMap){ 
		modelMap.put("labelName", labelName);
		modelMap.put("id", id); 
		return "labelsystem/addOrUpdateLabel";
	}
	
	/**
	 * 
	 * @Title: addLabel  
	 * @Description: 添加系统标签
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addLabel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addLabel(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String labelName=request.getParameter("labelName");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("labelName", labelName);
			map.put("type", 1+"");//默认1
			obj=OssAddLabel(map);
		} catch (Exception e) {
			logger.info("oss添加系统标签", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: updateLabel  
	 * @Description: 修改系统标签
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateLabel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateLabel(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			String labelName=request.getParameter("labelName");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("labelName", labelName);
			map.put("id", id);//陪同版 Templte请求不支持Integer
			obj=OssUpdateLabel(map); 
		} catch (Exception e) {
			logger.info("修改系统标签", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: deleteLabel  
	 * @Description: 删除系统标签
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteLabel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object deleteLabel(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			obj=ossGetDeleteLabel(id); 
		} catch (Exception e) {
			logger.info("删除系统标签", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	
	private JSONObject ossGetDeleteLabel(String id) {
		String url = Config.YXTSERVER3 + "osslabel/delLabelSystem?id="+id;
		return getRestApiData(url);
	}
	private JSONObject ossGetLabelList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER3 + "osslabel/getLabelSystemList?page="+n+"&pageSize="+s;
		return getRestApiData(url,requestParams); 
	}
	private JSONObject OssUpdateLabel(Map requestParams) {
		String url = Config.YXTSERVER3 + "osslabel/updateLabelSystem";
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssAddLabel(Map requestParams) {
		String url = Config.YXTSERVER3 + "osslabel/saveLabelSystem";
		return getRestApiData(url,requestParams);
	}
}
