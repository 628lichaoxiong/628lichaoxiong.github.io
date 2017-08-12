package com.transn.houtai.oss;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.Saveimage;
import com.transn.houtai.util.StringUtil;
import com.transn.houtai.util.poiservice2;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

@Controller
@RequestMapping("/fadeback")
@AnnotationForController( menuCode = 100501)
public class fadeback extends BaseController {
	Logger logger = LoggerFactory.getLogger(fadeback.class);
	@Resource(name = "poiService")
	public PoiService service;

	@Autowired
    Saveimage saveimage;
	
	@Autowired
	private poiservice2 service2;

	public fadeback() {

	}
	

	
	/**
	 * 获取消息列表
	 * 
	 */
	@RequestMapping("/getfadebacklist")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	private String getfadebacklist(HttpServletRequest request,Integer n,  Integer s,ModelMap modelMap) {
		try {
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
		JSONObject objj = getfadebacklist(n, s);
		modelMap.addAttribute("fadebacklist", objj);
		}catch (Exception e) {
			logger.info("oss端获取APP反馈列表失败", e);
			e.printStackTrace();
		}
		return "fadeback/fadebackList";
	}
	
	/**
	 * 添加消息表单
	 * 
	 */
	@RequestMapping("/addsystemmessageform")
	private ModelAndView addsystemmessageform(HttpServletRequest request) {
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String image = request.getParameter("image");
		String time = request.getParameter("time");
		String logo = request.getParameter("logo");
		if(StringUtil.isBlank(id)){
			id="";
		}
		if(StringUtil.isBlank(title)){
			title="";
		}
		if(StringUtil.isBlank(content)){
			content="";
		}
		if(StringUtil.isBlank(image)){
			image="";
		}
		if(StringUtil.isBlank(time)){
			time="";
		}
		if(StringUtil.isBlank(logo)){
			logo="http://7xr70a.com2.z0.glb.qiniucdn.com/icon_activity%403x.png";
		}
		if("http://7xr70a.com2.z0.glb.qiniucdn.com/icon_activity%403x.png".equals(logo)){
			logo="1";
		}
		if("http://7xr70a.com2.z0.glb.qiniucdn.com/icon_new%403x.png".equals(logo)){
			logo="2";
		}
		if("http://7xr70a.com2.z0.glb.qiniucdn.com/icon_questionnaire%403x.png".equals(logo)){
			logo="3";
		}
		ModelAndView modelview = new ModelAndView();
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("id", id);
		modelview.addObject("title", title);
		modelview.addObject("content", content);
		modelview.addObject("image", image);
		modelview.addObject("logo", logo);
		modelview.addObject("time", time);
		modelview.setViewName("systemmessage/createsystemMessageForm");
		return modelview;
	}
	
	
	/**
	 * 获取消息详情
	 * 
	 */
	@RequestMapping("/getsystemmessageinfo")
	private ModelAndView getsystemmessageinfo(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		String id=request.getParameter("id");
		JSONObject systemmessage=getsystemmessageinfo(id);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("systemmessage", systemmessage);
		modelview.setViewName("systemmessage/systemMessageDetail");
		return modelview;
	}
	
	
	/**
	 * 删除系统消息
	 * 
	 */
	@RequestMapping("/deletesystemmessage")
	private String deletesystemmessage(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		String id=request.getParameter("id");
		deletesystemmessage(id);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return  "redirect:/system/getsystemmessagelist";
	}
	
	
	
	private JSONObject getsystemmessageinfo(String id) {
		String url = Config.YXTSERVER3 + "osssystem/getSystemMessage?id="+id;
		return getRestApiData(url);
	}
	
	private JSONObject deletesystemmessage(String id) {
		String url = Config.YXTSERVER3 + "osssystem/deleteSystemMessage?id="+id;
		return getRestApiData(url);
	}
	
	private JSONObject addsystemmessage(Map m) {
		String url = Config.YXTSERVER3 + "osssystem/addSystemMessage";
		return getRestApiData(url,m);
	}
	
	private JSONObject updatesystemmessage(Map m) {
		String url = Config.YXTSERVER3 + "osssystem/updateSystemMessage";
		return getRestApiData(url,m);
	}
	
	private JSONObject getfadebacklist(Integer page,Integer pageSize) {
		String url = Config.YXTSERVER3 + "fadeback/getfadebacks?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url);
	}

}
