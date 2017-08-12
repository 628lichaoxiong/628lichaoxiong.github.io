package com.transn.houtai.oss;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.table.transnworkcompanion;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.DateUtil;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;



@Controller
@RequestMapping("/compation")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100301)
public class TransnworkCompationController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(TransnworkCompationController.class);
	
	@RequestMapping(value="/getcompationList" ,method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  String getcompationList(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("id", request.getParameter("id"));
			 map.put("companyname", request.getParameter("companyname"));
			 map.put("meetingcity", request.getParameter("meetingcity"));
			 map.put("servicename", request.getParameter("servicename"));
			 map.put("phonenumber", request.getParameter("phonenumber"));
			 map.put("serviceType", request.getParameter("serviceType"));
			 map.put("orderType", request.getParameter("orderType"));
			 map.put("payflag", request.getParameter("payflag"));
			 map.put("startTime", request.getParameter("startTime"));
			 map.put("endTime", request.getParameter("endTime"));
			 map.put("cardType", request.getParameter("cardType"));
			 map.put("search",  request.getParameter("search"));
			 map.put("url", request.getParameter("url"));
			 String sortValue=request.getParameter("sortValue");
			 if(StringUtils.isBlank(sortValue)){
				 map.put("sortValue", "time.desc");
			 }else{
				 map.put("sortValue", sortValue);
			 }
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
			 JSONObject objj =getEvlauteList(n,s,map);
			 modelMap.addAttribute("list", objj);
			 modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss端获取订单列表信息", e);
			e.printStackTrace();
		}
		return "compation/compationList";	
	}
	/**
	 * 
	 * @Title: getcompationInfo  
	 * @Description: 获取订单详情 
	 * @param id
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getcompationInfo" ,method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  String getcompationInfo(Integer id,Integer type,Integer isscan,ModelMap modelMap){
		try {
			 JSONObject objj =getCompationInfo(id,isscan);
			 JSONObject objj1= (JSONObject) objj.get("data");
			 JSONObject objj2=(JSONObject) objj1.get("result");
			String orderlist= (String) objj2.get("orderlist");
			 List list = new ArrayList();
			if(StringUtils.isNotBlank(orderlist)){
				String[] orderArray=orderlist.split(",");
				for (int i = 0; i < orderArray.length; i++) {
					Map<String,Object> map =new HashMap<String, Object>();
					map.put("content", orderArray[i]);
					map.put("monery", orderArray[i+1]);
					list.add(map);
					++i;
				}
			}
			//设置译员需求 英语,1/西班牙语,2/法语,1
			List<String> askinfoList =new ArrayList<String>();
			//此处得到的null是JSONNull。要么和JSONNull.getInstance()进行比较equals，要么将其toStringJSONNull.getInstance()
			if(objj2.get("askinfo")!=null){
				String askinfo= (String) objj2.get("askinfo"); 
				if(StringUtils.isNotBlank(askinfo)){ 
					String[] arr= askinfo.split("/");
			    	for (int i = 0; i < arr.length; i++) {
						String info=arr[i];
						String infos=info.replace(",","&nbsp;&nbsp;&nbsp;&nbsp;   ")+"人";
						askinfoList.add(infos); 
			    	}  
				}
			}
			 modelMap.put("askinfoList", askinfoList);
			 modelMap.put("list", list);
			 modelMap.addAttribute("objj", objj);
			 modelMap.put("type", type);
		} catch (Exception e) {
			logger.info("oss端获取订单列表信息", e);
			e.printStackTrace();
		}
		return "compation/compationInfoready";
		/*if(type==1){
			return "compation/compationInfoready";
		}else{
			return "compation/compationInfo";	
		}*/
		
	}
	
	/**
	 * 
	 * @Title: getcompationInfo  
	 * @Description: 更新订单备注 
	 * @param id
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/updateComment" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public  Object updateComment(String id,String comment){
		JSONObject objj=null;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("id", id);
			map.put("comment", comment);
			objj =updateComment(map);
		} catch (Exception e) {
			logger.info("oss端更新订单备注失败", e);
			e.printStackTrace();
		}
		return objj;	
	}
	/**
	 * 
	 * @Title: updateCommentInfo  
	 * @Description: 更新订单信息
	 * @param transnworkcompanion
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/updateCompationInfo" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateCommentInfo(transnworkcompanion transnworkcompanion){
		JSONObject objj=null;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			String stringcompanion=JSON.toJSON(transnworkcompanion).toString();
			map.put("stringcompanion", stringcompanion);
			map.put("type", "0");
			objj=updateCompationInfo(map);
		} catch (Exception e) {
			logger.info("oss端更新订单信息失败", e);
			e.printStackTrace();
		}
		return objj;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/sendMessage" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object sendMessage(transnworkcompanion transnworkcompanion){
		JSONObject objj=null;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			String stringcompanion=JSON.toJSON(transnworkcompanion).toString();
			map.put("stringcompanion", stringcompanion);
			map.put("type", "1");
			objj=updateCompationInfo(map);
		} catch (Exception e) {
			logger.info("oss端更新订单信息失败", e);
			e.printStackTrace();
		}
		return objj;
		
	}

	/**
	 * 
	 * @Title: getOrderResume  
	 * @Description:获取已预订译员列表
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getOrderResume" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getOrderResume(Integer id,Integer type,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=getOrderResumeList(id,null);
			modelMap.addAttribute("objj", objj);
			modelMap.addAttribute("type", type);
		} catch (Exception e) {
			logger.info("oss端获取预约译员失败", e);
			e.printStackTrace();
		}
		return "compation/userResumeList";
		
	}
	/**
	 * 
	 * @Title: getOrderAcceptedResume  
	 * @Description:获取译员端已报名译员列表
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getOrderAcceptedResume" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getOrderAcceptedResume(Integer id,Integer type,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=getOrderAcceptedResumeList(id);
			modelMap.addAttribute("objj", objj);
			modelMap.addAttribute("type", type);
		} catch (Exception e) {
			logger.info("oss端获取预约已报名译员失败", e);
			e.printStackTrace();
		}
		return "compation/userResumeAcceptedList";
		
	}
	/**
	 * 
	 * @Title: deleteResume  
	 * @Description: 删除预订译员
	 * @param userid
	 * @param serviceId
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/deleteResume" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DELETE)
	public Object deleteResume(Integer userid,Integer serviceId){
		JSONObject objj=null;
		try {
			objj=ossDeleteResume(userid,serviceId);
		} catch (Exception e) {
			logger.info("oss端更新订单信息失败", e);
			e.printStackTrace();
		}
		return objj;
		
	}
	/**
	 * 
	 * @Title: getSearchResume  
	 * @Description: 获取搜索译员列表
	 * @param optype
	 * @param searchkey
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getSearchResume" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getSearchResume(String optype,String searchkey,Integer n,  Integer s,ModelMap modelMap){
		JSONObject objj=null;
		try {
			if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=10;
			 }
			Map<String,Object> map= new HashMap<String, Object>();
			if(Integer.valueOf(optype)==1){
				map.put("usernumber", searchkey);
				map.put("optype",  optype);
			}
			if(Integer.valueOf(optype)==2){
				map.put("userphonenumber", searchkey);
				map.put("optype", optype);
			}
			if(Integer.valueOf(optype)==3){
				map.put("realusername", searchkey);
				map.put("optype", optype);
			}
			if(Integer.valueOf(optype)==4){
				map.put("language", searchkey);
				map.put("optype", optype);
			}
			map.put("isshow", "1");
			objj=ossGetSearchResume(n,s,map);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端获取译员列表失败", e);
			e.printStackTrace();
		}
		return "compation/searchResumeList";
	}
	/**
	 * 
	 * @Title: addResume  
	 * @Description: 添加译员
	 * @param userid
	 * @param serviceId
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/addResume" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addResume(Integer userid,Integer serviceId,String fromLan,String toLan){
		JSONObject objj=null;
		try {
			objj=ossAddResume(userid,serviceId,fromLan,toLan);
		} catch (Exception e) {
			logger.info("oss端更新订单信息失败", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: serviceTimeChange  
	 * @Description: oss端判断译员和会议时间冲突  
	 * @param beginTime
	 * @param endTime
	 * @param serviceid
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/serviceTimeChange" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object serviceTimeChange(String beginTime,String endTime,String serviceid){
		JSONObject objj=null;
		try {
			Map<String,Object> map =new HashMap<String,Object>();
			map.put("beginTime", beginTime);
			map.put("endTime", endTime);
			map.put("serviceid", serviceid);
			objj=ossServiceTimeChange(map);
		} catch (Exception e) {
			logger.info("oss端判断译员和会议时间冲突失败", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: getUserjingli  
	 * @Description: 获取译员简历列表  
	 * @param userid
	 * @param n
	 * @param s
	 * @return
	 * @return Object
	 */
	@RequestMapping(value="/getUserjingli" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getUserjingli(String userid,Integer n,  Integer s,ModelMap modelMap){
		JSONObject objj=null;
		try {
			if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=10;
			 }
			objj=ossGetUserjingli(n,s,userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端获取译员简历列表", e);
			e.printStackTrace();
		}
		return "compation/userJingliList";
	}
	/**
	 * 
	 * @Title: getServiceFlag  
	 * @Description: 获取订单状态 
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getServiceFlag" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getServiceFlag(Integer serviceid){
		JSONObject objj=null;
		try {
			objj=ossGetServiceFlag(serviceid);
		} catch (Exception e) {
			logger.info("oss端获取订单最新状态", e);
			e.printStackTrace();
		}
		return objj;
	}
	
	/**
	 * 
	 * @Title: getOrderResume  
	 * @Description:获取订单费用明细
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getOrderFee" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getOrderResume(Integer id,String beginTime,String endTime,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=getOrderResumeList(id,1);//只查询客户选中的
			int days=DateUtil.differentDaysByMillisecond(beginTime, endTime, "yyyy-MM-dd");
			//得到计算价格的系数
			//服务费用=语种服务单价*次参数
			String argDate = DateUtil.calculateDay(beginTime, endTime, "yyyy-MM-dd HH:mm");
			modelMap.addAttribute("argDate", argDate);
			modelMap.addAttribute("objj", objj);
			modelMap.addAttribute("days", days);
		} catch (Exception e) {
			logger.info("oss端获取订单费用明细", e);
			e.printStackTrace();
		}
		return "compation/orderFeeList";
		
	}
	/**
	 * 
	 * @Title: getnoreadServices  
	 * @Description: 获取未读订单
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getnoreadServices" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getnoreadServices(){
		JSONObject objj=null;
		try {
			objj=ossGetnoreadServices();
		} catch (Exception e) {
			logger.info("oss端获取未读订单", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: updateServiceBaomingPrice  
	 * @Description: 修改译员成本价
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/updateServiceBaomingPrice" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateServiceBaomingPrice(Integer serviceId,Integer userid,BigDecimal costPrice){
		JSONObject objj=null;
		try {
			objj=ossUpdateServiceBaomingPrice(serviceId,userid,costPrice);
		} catch (Exception e) {
			logger.info("修改译员成本价", e);
			e.printStackTrace();
		}
		return objj;
	}
	private JSONObject ossUpdateServiceBaomingPrice(Integer serviceId,Integer userid,BigDecimal costPrice) {
		String url = Config.YXTSERVER3 + "ossCompation/updateCostPrice?serviceId="+serviceId+"&userid="+userid+"&costPrice="+costPrice;
		return getRestApiData(url);
	}
	private JSONObject getEvlauteList(Integer page,Integer pageSize, Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCompation/ossCompationList?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url, requestParams);
	}
	
	private JSONObject getCompationInfo(Integer id,Integer isscan) {
		String url = Config.YXTSERVER3 + "ossCompation/getCompationInfo?id="+id+"&isscan="+isscan;
		return getRestApiData(url);
	}
	private JSONObject updateComment(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCompation/updateComment";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject updateCompationInfo(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCompation/updateCompationInfo";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject getOrderResumeList(Integer id,Integer status) {
		String url = Config.YXTSERVER3 + "ossCompation/getOrderResume?id="+id;
		if(status!=null){ 
			url =url+"&status="+status;
		}
		return getRestApiData(url);
	}
	private JSONObject getOrderAcceptedResumeList(Integer id) {
		String url = Config.YXTSERVER3 + "ossCompation/getOrderAcceptedResumeList?id="+id;
		return getRestApiData(url);
	}
	
	private JSONObject ossDeleteResume(Integer userid,Integer serviceId) {
		String url = Config.YXTSERVER3 + "ossCompation/deleteResume?userid="+userid+"&serviceId="+serviceId;
		return getRestApiData(url);
	}
	
	private JSONObject ossGetSearchResume( Integer page,Integer pageSize,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCompation/getSearchResume?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject ossAddResume(Integer userid,Integer serviceId,String fromLan,String toLan ) {
		String url = Config.YXTSERVER3 + "ossCompation/addResume?userid="+userid+"&serviceId="+serviceId+"&fromLan="+fromLan+"&toLan="+toLan;
		return getRestApiData(url);
	}
	
	private JSONObject ossServiceTimeChange(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCompation/serviceTimeChange";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject ossGetUserjingli(Integer page,Integer pageSize,String userid) {
		String url = Config.YXTSERVER3 + "ossCompation/getUserjingli?page="+page+"&pageSize="+pageSize+"&userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject ossGetServiceFlag(Integer serviceid) {
		String url = Config.YXTSERVER3 + "ossCompation/getServiceFlag?serviceid="+serviceid;
		return getRestApiData(url);
	}
	private JSONObject ossGetnoreadServices() {
		String url = Config.YXTSERVER3 + "ossCompation/getnoreadOrder";
		return getRestApiData(url);
	}
}
