package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.connection.StringRedisConnection.StringTuple;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/customer")
@AnnotationForController( menuCode = 100201)
public class CustomerController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(CustomerController.class);
	
	/**
	 * 
	 * @Title: getCustomerList  
	 * @Description: 返回客户列表  
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getCustomerList" ,method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  String getCustomerList(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("customerName", request.getParameter("customerName"));
			 map.put("mobile", request.getParameter("mobile"));
			 map.put("id",request.getParameter("id"));
			 map.put("search",  request.getParameter("search"));
//			 map.put("url", request.getParameter("url"));
			 map.put("salesName", request.getParameter("salesName"));
			 map.put("cardType", request.getParameter("cardType"));
			 map.put("cardStatus", request.getParameter("cardStatus"));
			if(n==null){
					 n=1;
				}
			if(s==null){
					 s=20;
			 }
			 String sortValue=request.getParameter("sortValue");
			 if(StringUtils.isBlank(sortValue)){
				 map.put("sortValue", "time.desc");
			 }else{
				 map.put("sortValue", sortValue);
			 }
			 JSONObject objj =getCuslist(n,s,map);
			 modelMap.addAttribute("list", objj);
			 modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss端获取客户列表信息", e);
			e.printStackTrace();
		}
		return "customer/customerList";	
	}
	/**
	 * 
	 * @Title: getCustomerList  
	 * @Description: 返回客户详情
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getCustomerInfo" ,method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  String getCustomerInfo(HttpServletRequest request, ModelMap modelMap){
		try {
			
		   	String id=request.getParameter("id");
		   	JSONObject objj= getCustomerInfo(Integer.valueOf(id));
			// JSONObject pageList= getEvlauteList(n,s,map);
			 modelMap.addAttribute("card", objj);
			 //modelMap.addAttribute("pageList", pageList);
		} catch (Exception e) {
			logger.info("oss端获取客户列表信息", e);
			e.printStackTrace();
		}
		return "customer/customerInfo";	
	}
	/**
	 * 
	 * @Title: getEvlaute  
	 * @Description: 获取评价列表 
	 * @param modelMap
	 * @param request
	 * @param page
	 * @param pageSize
	 * @return
	 * @return String
	 */
   
	@RequestMapping(value="/getEvlaute",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  @ResponseBody Map getEvlaute(HttpServletRequest request,Integer page,  Integer pageSize){
		 Map<String,Object> maps=new HashMap<String, Object>();
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("customerId", request.getParameter("customerId"));
			 JSONObject objj= getEvlauteList(page,pageSize,map);
			 maps.put("objj", objj.toString());
		   } catch (Exception e) {
			logger.info("oss端获取客户评价列表", e);
			e.printStackTrace();
		}
		 return maps;
		
	}
	/**
	 * 
	 * @Title: setAuth  
	 * @Description: 设定认证状态
	 * @param customerId
	 * @param flag
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="/setAuth",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public @ResponseBody JSONObject setAuth(Integer companyId,Integer flag,Integer customerId){
		JSONObject objj=null;
		try {
		   objj =setCusAuth(companyId,flag,customerId);
		} catch (Exception e) {
			logger.info("oss端获取客户设定认证状态", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: setRate  
	 * @Description: 设定费率
	 * @param customerId
	 * @param rate
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="/setRate",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public @ResponseBody JSONObject setRate(Integer customerId,String rate){
		JSONObject objj=null;
		try {
		   objj =setCusRate(customerId,rate);
		} catch (Exception e) {
			logger.info("oss端获取客户设定费率", e);
			e.printStackTrace();
		}
		return objj;
	}
	
	@SuppressWarnings({"unchecked","rawtypes"})
	private JSONObject getCuslist(Integer page,Integer pageSize, Map requestParams) {
		String url ;
		if(page==null&&pageSize==null){
			url = Config.YXTSERVER7 + "oss/customerList";
		}else{
		    url = Config.YXTSERVER7 + "oss/customerList?page="+page+"&pageSize="+pageSize;
		}
		
		return getRestApiData(url, requestParams);
	}
	
	
	@SuppressWarnings({"unchecked","rawtypes"})
	private JSONObject getEvlauteList(Integer page,Integer pageSize, Map requestParams) {
		String url = Config.YXTSERVER7 + "oss/getAllEvlaute?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url, requestParams);
	}
	/**
	 * 
	 * @Title: setCardStatus  
	 * @Description: 设定用户状态
	 * @param customerId
	 * @param state
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="/setCardStatus",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public @ResponseBody JSONObject setCardStatus(Integer customerId,String state){
		JSONObject objj=null;
		try {
		   objj =setOssCardStatus(customerId,state);
		} catch (Exception e) {
			logger.info("oss端获取客户设定费率", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: resetPasswd  
	 * @Description: 重置密码
	 * @param customerId
	 * @param rate
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="/resetPasswd",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public @ResponseBody JSONObject resetPasswd(Integer customerId){
		JSONObject objj=null;
		try {
		   objj =ossResetPasswdOss(customerId);
		} catch (Exception e) {
			logger.info("oss端重置客户密码", e);
			e.printStackTrace();
		}
		return objj;
	}
	private JSONObject setCusAuth(Integer companyId,Integer flag,Integer customerId) {
		String url = Config.YXTSERVER7 + "oss/setAuth?companyId="+companyId+"&flag="+flag+"&customerId="+customerId;
		return getRestApiData(url);
	}
	
	private JSONObject setCusRate(Integer customerId,String rate) {
		String url = Config.YXTSERVER7 + "oss/setRate?customerId="+customerId+"&rate="+rate;
		return getRestApiData(url);
	}
	
	private JSONObject getCustomerInfo(Integer id){
		String url = Config.YXTSERVER7 + "oss/getCustomerInfo?id="+id;
		return getRestApiData(url);
	}
	private JSONObject ossResetPasswdOss(Integer id){
		String url = Config.YXTSERVER7 + "oss/resetPasswd?id="+id;
		return getRestApiData(url);
	}
	private JSONObject setOssCardStatus(Integer customerId,String state) {
		String url = Config.YXTSERVER7 + "oss/setCardStatus?customerId="+customerId+"&state="+state;
		return getRestApiData(url);
	}
}
