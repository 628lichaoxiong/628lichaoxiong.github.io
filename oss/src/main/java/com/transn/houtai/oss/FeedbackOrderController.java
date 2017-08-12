package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.permission.AnnotationForController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/feedbackOrder")
@AnnotationForController( menuCode = 9999)
public class FeedbackOrderController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(FeedbackOrderController.class);
	/**
	 * 
	 * @Title: feedbackOrderPager  
	 * @Description: 获取反馈留言列表  
	 * @param request
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/feedbackOrderPager" ,method = RequestMethod.GET)
	public  String feedbackOrderPager(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
			 JSONObject objj =getfeedbackOrder(n,s,new HashMap<String,Object>());
			 modelMap.addAttribute("list", objj);
		} catch (Exception e) {
			logger.info("oss端获取客户列表信息", e);
			e.printStackTrace();
		}
		return "customer/feedbackOrderPager";	
	}
	/**
	 * 
	 * @Title: feedbackByOrder  
	 * @Description: 通过订单获取所有反馈
	 * @param request
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/feedbackByOrder" ,method = RequestMethod.POST)
	public  String feedbackByOrder(HttpServletRequest request, Integer n,  Integer s,String id,String source,ModelMap modelMap){
		try {
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=5;
			 }
			 Map<String,Object> map=new HashMap<String, Object>();
			 map.put("orderId", id);
			 map.put("source",source );
			 JSONObject objj =getfeedbackOrder(n,s,map);
			 modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端通过订单获取所有反馈", e);
			e.printStackTrace();
		}
		return "compation/feedbackOrderList";	
	}
	/**
	 * 
	 * @Title: addFeedbackOrder  
	 * @Description: 跳转到添加反馈列表
	 * @param request
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/addFeedbackOrder" ,method = RequestMethod.GET)
	public String addFeedbackOrder(HttpServletRequest request,ModelMap modelMap){
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", request.getParameter("id"));
			map.put("servicename", request.getParameter("servicename"));
			map.put("payflag", request.getParameter("payflag"));
		    map.put("companynameslim", request.getParameter("companynameslim"));
			map.put("phonenumber", request.getParameter("phonenumber"));
			map.put("userid",request.getParameter("userid"));
			modelMap.addAttribute("feedbackOrder", map);
		} catch (Exception e) {
			logger.info("oss端添加订单反馈失败", e);
			e.printStackTrace();
		}
		return "compation/addFeedbackOrder";
	}
	/**
	 * 
	 * @Title: changeState  
	 * @Description: 改变订单状态  
	 * @param request
	 * @param id
	 * @param state
	 * @param method
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/changeState" ,method = RequestMethod.POST)
	public Object changeState(HttpServletRequest request,String id,String state,String method){
		JSONObject objj=null;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", id);
			map.put("state", state);
			map.put("method", method);
			objj=ossChangeState(map);
		} catch (Exception e) {
			logger.info("oss端改变订单反馈状态失败", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: addFeedback  
	 * @Description: 添加订单反馈  
	 * @param request
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/addFeedback" ,method = RequestMethod.POST)
	public Object addFeedback(HttpServletRequest request){
		JSONObject objj=null;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("payflag", request.getParameter("payflag"));
			map.put("orderId", request.getParameter("orderId"));
			map.put("name",  request.getParameter("name"));
			map.put("message", request.getParameter("message"));
			map.put("method", request.getParameter("method"));
			map.put("mobile", request.getParameter("mobile"));
			map.put("userid",request.getParameter("userid"));
			objj=ossAddFeedback(map);
		} catch (Exception e) {
			logger.info("oss端改变订单反馈状态失败", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: allFeedbackOrder  
	 * @Description: 获取所有反馈
	 * @param request
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/allFeedbackOrder" ,method = RequestMethod.GET)
	public  String allFeedbackOrder(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
			 Map<String,Object> map=new HashMap<String, Object>();
			 map.put("orderId", request.getParameter("orderId"));
			 map.put("source", "1");
			 map.put("name", request.getParameter("name"));
			 map.put("meeting", request.getParameter("meeting"));
			 JSONObject objj =getfeedbackOrder(n,s,map);
			 map.put("search",  request.getParameter("search"));
			 map.put("url", request.getParameter("url"));
			 modelMap.addAttribute("list", objj);
			 modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss端获取所有反馈", e);
			e.printStackTrace();
		}
		return "compation/allFeedbackOrder";	
	}
	/**
	 * 
	 * @Title: isNewFeedback  
	 * @Description: 查看是否有待处理的反馈  
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/isNewFeedback" ,method = RequestMethod.POST)
	public Object isNewFeedback(){
		JSONObject objj=null;
		try {
			objj=ossisNewFeedback();
		} catch (Exception e) {
			logger.info("oss端是否存在未处理的反馈", e);
			e.printStackTrace();
		}
		return objj;
	}
	private JSONObject getfeedbackOrder(Integer page,Integer pageSize,Map requestParams) {
		String url = Config.YXTSERVER3 + "feedbackOrder/getFeedbackOrderPager?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	private JSONObject ossChangeState(Map requestParams) {
		String url = Config.YXTSERVER3 + "feedbackOrder/ossChangeState";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject ossAddFeedback(Map requestParams) {
		String url = Config.YXTSERVER3 + "feedbackOrder/ossAddFeedback";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject ossisNewFeedback() {
		String url = Config.YXTSERVER3 + "feedbackOrder/isNewFeedback";
		return getRestApiData(url);
	}
}
