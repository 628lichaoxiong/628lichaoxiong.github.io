package com.transn.houtai.oss;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.Saveimage;
import com.transn.houtai.util.StringUtil;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.transn.houtai.util.poiservice2;
import com.transn.houtai.util.permission.AnnotationForController;

@Controller
@RequestMapping("/usertransnwork")
@AnnotationForController( menuCode = 9999)//不需要权限验证
public class usertransnwork extends BaseController {
	Logger logger = LoggerFactory.getLogger(usertransnwork.class);
	@Resource(name = "poiService")
	public PoiService service;

	@Autowired
    Saveimage saveimage;

	@Autowired
	private poiservice2 service2;

	public usertransnwork() {

	}

	/**
	 * 任务报名详情
	 */
	@RequestMapping("/usertransnworkinfo")
	public ModelAndView usertransnworkinfo(HttpServletRequest request) {
		// 当前第几页
		String usertransnworkid = request.getParameter("usertransnworkid");
		
		ModelAndView modelview = new ModelAndView();
		
		modelview.addObject("usertransnworkinfo", usertransnworkinfo(usertransnworkid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("usertransnworklist/usertransnworkDetail");
		return modelview;

	}
	
	/**
	 * 任务用户审核
	 */
	@RequestMapping("/checkusertransnwork")
	public String checkusertransnwork(HttpServletRequest request) {
		// 当前第几页
		String userid = request.getParameter("userid");
		if(StringUtil.isBlank(userid)){
			userid="";
		}
		String transnworkid = request.getParameter("transnworkid");
		String flag = request.getParameter("flag");
		String usertransnworkid = request.getParameter("usertransnworkid");
		String meetingname=request.getParameter("meetingname");
		if(StringUtil.isBlank(usertransnworkid)){
			usertransnworkid="0";
		}
		ModelAndView modelview = new ModelAndView();
		
		checkusertransnwork(userid, transnworkid, flag,usertransnworkid);
		JSONObject objj = getusertransnwork("", "1", "10");
		modelview.addObject("usertransnworklist", objj);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/usertransnwork/getusertransnworklist?transnworkid="+transnworkid+"&meetingname="+meetingname;

	}
	
	
	
	/**
	 * 传神任务列表
	 * 
	 */
	@RequestMapping("/transnworklist")
	private ModelAndView userList(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String keyword = null;
		String name=(String) request.getSession().getAttribute("name");
		keyword = request.getParameter("keyword");

		if (keyword == null) {
			keyword = "";
		}
		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "1";
		}
		// 每页条数
		String pagelines = request.getParameter("s");
		if (pagelines == null) {
			pagelines = "10";
		}
		ModelAndView modelview = new ModelAndView();
		// getUserList(keyword, pagenumber, pagelines);
		JSONObject objj = getTransnworkList(keyword, pagenumber, pagelines,name);
		modelview.addObject("transnworklist", objj);
		// logger.info(request.getSession().getAttribute("name")+"刷新用户列表操作的用户"+request.getSession().getAttribute("name"));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
				+ "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("usertransnworklist/transnworkList");
		return modelview;
	}
	
	
	/**
	 * 获取用户报名表
	 * 
	 */
	@RequestMapping("/getusertransnworklist")
	private ModelAndView getusertransnworklist(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String transnworkid = null;

		transnworkid = request.getParameter("transnworkid");
		
		String meetingname = request.getParameter("meetingname");

		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "20";
		}

		ModelAndView modelview = new ModelAndView();

		// getUserList(keyword, pagenumber, pagelines);

		JSONObject objj = getusertransnworklist(transnworkid, pagenumber, pagelines);
		modelview.addObject("usertransnworklist", objj);
		logger.info(request.getSession().getAttribute("name") + "刷新用户花名册列表操作的用户" + request.getSession().getAttribute("name"));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("transnworkid", transnworkid);
		modelview.addObject("meetingname", meetingname);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("newtransnwork/usertransnworkList");
		return modelview;
	}
	
	
	
	
	private JSONObject getTransnworkList(String keyword, String n, String s,String name) {
		String url = Config.YXTSERVER3 + "osstransnwork/ossgettransnworklist?n=" + n + "&s=" + s+"&name="+name;
		return getRestApiData(url);
	}
	
	private JSONObject getusertransnwork(String keyword, String n, String s) {
		String url = Config.YXTSERVER3 + "osstransnwork/ossgetusertransnworklist?n=" + n + "&s=" + s+"&key="+keyword ;
		return getRestApiData(url);
	}
	
	private JSONObject getusertransnworklist(String transnworkid, String n, String s) {
		String url = Config.YXTSERVER3 + "osstransnwork/ossgetusertransnworklistbyid?n=" + n + "&s=" + s+"&transnworkid="+transnworkid ;
		return getRestApiData(url);
	}

	private JSONObject usertransnworkinfo(String usertransnworkid) {
		String url = Config.YXTSERVER3 + "osstransnwork/ossgetusertransnwork?usertransnworkid=" + usertransnworkid ;
		return getRestApiData(url);
	}
	
	private JSONObject checkusertransnwork(String userid,String transnworkid,String flag,String usertransnworkid) {
		String url = Config.YXTSERVER3 + "osstransnwork/osschangeUserTransnworkFlag?userid=" + userid+"&transnworkid="+transnworkid+"&flag="+flag+"&usertransnworkid="+usertransnworkid ;
		return getRestApiData(url);
	}
	
}
