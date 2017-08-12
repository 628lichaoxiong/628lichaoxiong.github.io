package com.transn.houtai.oss;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.transn.houtai.util.poiservice2;
import com.transn.houtai.util.permission.AnnotationForController;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.Saveimage;
import com.transn.houtai.util.StringUtil;

@Controller
@RequestMapping("/system")
@AnnotationForController( menuCode = 9999)
public class systemmessage extends BaseController {
	Logger logger = LoggerFactory.getLogger(systemmessage.class);
	@Resource(name = "poiService")
	public PoiService service;

	@Autowired
    Saveimage saveimage;
	
	@SuppressWarnings("unused")
    @Autowired
	private poiservice2 service2;

	public systemmessage() {

	}
	

	/**
	 * 创建系统消息
	 * 
	 */
	@RequestMapping("/addsystemmessage")
	private ModelAndView addsystemmessage(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String id = request.getParameter("id");
		
		String title = request.getParameter("title");
		String image = request.getParameter("image");
		String content = request.getParameter("content");
		String logo = request.getParameter("logo");
		if("1".equals(logo)){
			logo="http://7xr70a.com2.z0.glb.qiniucdn.com/icon_activity%403x.png";
		}
		if("2".equals(logo)){
			logo="http://7xr70a.com2.z0.glb.qiniucdn.com/icon_new%403x.png";
		}
		if("3".equals(logo)){
			logo="http://7xr70a.com2.z0.glb.qiniucdn.com/icon_questionnaire%403x.png";
		}
		ModelAndView modelview = new ModelAndView();
		if(StringUtil.isBlank(id)){
			Map<String, String> m=new HashMap<String, String>();
			m.put("title", title);
			m.put("image", image);
			m.put("content", content);
			m.put("logo", logo);
			addsystemmessage(m);
			JSONObject systemmessagelist=getsystemmessagelist("0","10");
			modelview.addObject("systemmessagelist", systemmessagelist);
		}
		else {
			Map<String, String> m=new HashMap<String, String>();
			m.put("id", id);
			m.put("title", title);
			m.put("image", image);
			m.put("content", content);
			updatesystemmessage(m);
			JSONObject systemmessagelist=getsystemmessagelist("0","10");
			modelview.addObject("systemmessagelist", systemmessagelist);
		}
		// logger.info(request.getSession().getAttribute("name")+"刷新用户列表操作的用户"+request.getSession().getAttribute("name"));

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		
		modelview.setViewName("systemmessage/systemMessageList");
		return modelview;
	}
	
	
	/**
	 * 获取消息列表
	 * 
	 */
	@RequestMapping("/getsystemmessagelist")
	private ModelAndView getsystemmessagelist(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String keyword = null;

		keyword = request.getParameter("keyword");
		
		if (keyword == null) {
			keyword = "";
		}
		if(keyword!=null){
			keyword=keyword.trim();
		}

		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "10";
		}
		ModelAndView modelview = new ModelAndView();
		JSONObject objj = getsystemmessagelist(pagenumber, pagelines);
		modelview.addObject("systemmessagelist", objj);
		logger.info(request.getSession().getAttribute("name") + "刷新用户花名册列表操作的用户" + request.getSession().getAttribute("name"));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + "/"+cpath;
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("keyword", keyword);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("systemmessage/systemMessageList");
		return modelview;
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
	
	private JSONObject addsystemmessage(Map<String, String> m) {
		String url = Config.YXTSERVER3 + "osssystem/addSystemMessage";
		return getRestApiData(url,m);
	}
	
	private JSONObject updatesystemmessage(Map<String, String> m) {
		String url = Config.YXTSERVER3 + "osssystem/updateSystemMessage";
		return getRestApiData(url,m);
	}
	
	private JSONObject getsystemmessagelist(String n,String s) {
		String url = Config.YXTSERVER3 + "osssystem/getSystemMessageList?n="+n+"&s="+s;
		return getRestApiData(url);
	}

}
