package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;



@Controller
@RequestMapping("/sysLog")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100601)
public class SysLogController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(SysLogController.class);
	
	
	@RequestMapping("/getSysLogList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getSysLogList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String type=request.getParameter("type");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("type", type);
			obj=OssGetSysLogList(map);
			map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			modelMap.addAttribute("params",map);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取日志分页信息", e);
			e.printStackTrace();
		}
		return "syslog/sysLogList"; 
	}
	

	@RequestMapping("/getSaleChanceList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT,menuCode = 100302)
	public String getSaleChanceList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String userName=request.getParameter("userName");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("userName", userName);
			obj=OssGetSaleChanceList(map);
			map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			modelMap.addAttribute("params",map);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取销售机会分页信息", e);
			e.printStackTrace();
		}
		return "syslog/saleChanceList"; 
	}
	
	private JSONObject OssGetSysLogList(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossSysLog/getSysLogList";
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssGetSaleChanceList(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossSysLog/getSaleChanceList";
		return getRestApiData(url,requestParams);
	}
	
}
