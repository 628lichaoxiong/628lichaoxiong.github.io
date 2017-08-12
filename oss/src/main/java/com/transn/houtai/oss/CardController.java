package com.transn.houtai.oss;

import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.DateUtils;
import com.transn.houtai.util.MD5;
import com.transn.houtai.util.StatusMap;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;



@Controller
@RequestMapping("/card")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100401)
public class CardController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(CardController.class);
	/**
	 * 
	 * @Title: addCards  
	 * @Description:  oss生成卡片信息
	 * @param request
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addCards")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public Object addCards(HttpServletRequest request){
		JSONObject obj=null;
		try {
			Map<String,Object> map =new HashMap<String,Object>();
			map.put("ossUserId", getOssUserName(request));
			map.put("cardNumber", request.getParameter("cardNumber"));
			map.put("cardType", request.getParameter("cardType"));
			map.put("salesName", request.getParameter("salesName"));
			map.put("salesNumber", request.getParameter("salesNumber"));
			map.put("cardNumberNo", request.getParameter("cardNumberNo"));
			obj=OssAddCards(map);
		} catch (Exception e) {
			logger.info("oss生成卡片信息失败", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: countCards  
	 * @Description: 卡的信息统计 
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/countCards")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT,menuCode=100403)
	public Object countCards(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			obj=OssCountCards();
		} catch (Exception e) {
			logger.info("oss卡的统计", e);
			e.printStackTrace();
		}
		return  obj;
	}
	
	/**
	 * 
	 * @Title: countCards  
	 * @Description: 跳转到卡统计页面 
	 * @return
	 * @return String
	 */
	@RequestMapping("/toCountCards")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT,menuCode=100403)
	public String countCards(){
		
		return "card/countCard";
	}
	/**
	 * 新卡管理
	 * @Title: getCardInfoPager  
	 * @Description: oss获取卡分页信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getNewCardInfoParams")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT,menuCode=100402)
	public String getNewCardInfoParams(HttpServletRequest request,boolean isFirst,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String first=request.getParameter("first");
			String second=request.getParameter("second");
			String three=request.getParameter("three");
			String four=request.getParameter("four");
			List<String> list =new ArrayList<String>();
			if(isFirst){
				//如果第一次，则设置4个条件
				first="1";
				second="2";
				three="3";
				four="4";
				list.add("1");
				list.add("2");
				list.add("3");
				list.add("4");
			}else{
				if(StringUtils.isNotBlank(first)){
					list.add(first);
				}
				if(StringUtils.isNotBlank(second)){
					list.add(second);
				}
				if(StringUtils.isNotBlank(three)){
					list.add(three);
				}
				if(StringUtils.isNotBlank(four)){
					list.add(four);
				}
			}
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("search", JSON.toJSONString(list)); 
			obj=OssGetCardInfoPager(map);
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("first", first);
			params.put("second", second);
			params.put("three", three);
			params.put("four", four);
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取卡分页信息", e);
			e.printStackTrace();
		}
		return "card/newCardList";
	}
	/**
	 * 
	 * @Title: getCardInfoParams  
	 * @Description: oss获取卡分页信息列表 
	 * @param request
	 * @param modelMap
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getCardInfoParams")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getCardInfoParams(HttpServletRequest request,ModelMap modelMap){
		setCardList(request, modelMap);
		return "card/cardList";
	}
	/**
	 * 设置查询数据
	 * @param request
	 * @param modelMap
	 */
	void setCardList(HttpServletRequest request,ModelMap modelMap){
		try {
			String cardNumber=request.getParameter("cardNumber");
			String customerName=request.getParameter("customerName");
			String phonenumber=request.getParameter("phonenumber");
			String salesName=request.getParameter("salesName");
			String cardStatus=request.getParameter("cardStatus");
			String cardType=request.getParameter("cardType");
			String yn=request.getParameter("yn");
			String order=request.getParameter("order");
			String n=request.getParameter("n");
			String s=request.getParameter("s"); 
			if(n==null){
				n="1";
			}
			if(s==null){ 
				s="10";
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("cardNumber", cardNumber);
			map.put("customerName", customerName);
			map.put("phonenumber", phonenumber);
			map.put("salesName", salesName);
			map.put("cardStatus", cardStatus);
		    map.put("search",  request.getParameter("search"));
		    map.put("cardType", cardType);
			map.put("yn", yn);
			map.put("order", order);
			JSONObject obj=OssGetCardInfoParams(n,s,map);
			modelMap.addAttribute("list", obj);
			modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss获取卡分页信息列表", e);
			e.printStackTrace();
		}
	}
	/**
	 * 
	 * @Title: getCardInfo  
	 * @Description: 获取卡片信息  
	 * @param cardInfoId
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping("/getCardInfo")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String  getCardInfo(int cardInfoId,ModelMap modelMap){
		try {
			JSONObject obj=OssGetCardInfo(cardInfoId);
			modelMap.addAttribute("card", obj);
		} catch (Exception e) {
			logger.info("oss获取卡详情信息", e);
			e.printStackTrace(); 
		}
		return "card/cardInfo";
	}
	/**
	 * 
	 * @Title: addCard  
	 * @Description: 获取卡片信息  
	 * @param cardInfoId
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping("/addCard")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  addCard(){ 
		return "card/addCard";
	}
	/**
	 * 
	 * @Title: setCardStatus  
	 * @Description: oss设置卡片状态 
	 * @param status
	 * @param cardInfoId
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/setCardStatus")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object setCardStatus(HttpServletRequest request,int  status,int cardInfoId){
		JSONObject obj=null;
		try {
			obj=OssSetCardStatus(status,cardInfoId,getOssUserName(request));
		} catch (Exception e) {
			logger.info("oss设置卡片状态", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: setCardStatus  
	 * @Description: 启用禁用卡 
	 * @param cardYn 目前卡状态1正常0禁用
	 * @param cardInfoId
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/disableCard")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DISABLE)
	public Object disableCard(HttpServletRequest request,int cardInfoId,int cardYn){
		JSONObject obj=null;
		try {
			String username=getOssUserName(request);
			obj=ossDisableCard(cardInfoId,cardYn,username);
		} catch (Exception e) {
			logger.info("oss禁用启用卡", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: updatecardInfo  
	 * @Description: 变更卡片信息 
	 * @param request
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updatecardInfo")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updatecardInfo(HttpServletRequest request){
		JSONObject obj=null;
		try {
			Map<String,Object> params =new HashMap<String, Object>();
			params.put("phonenumber", request.getParameter("phonenumber"));
			params.put("customerName", request.getParameter("customerName"));
			params.put("salesName", request.getParameter("salesName"));
			params.put("salesNumber", request.getParameter("salesNumber"));
			params.put("cardInfoId", request.getParameter("cardInfoId"));
			params.put("username", getOssUserName(request));
			obj=OssUpdatecardInfo(params);
		} catch (Exception e) {
			logger.info("oss更新卡片信息", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Title: rechargeMonery  
	 * @Description: oss后台充值  
	 * @param request
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/rechargeMonery")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object rechargeMonery(HttpServletRequest request){
		JSONObject obj=null;
		try {
			Map<String,Object> params =new HashMap<String, Object>();
			String cardInfoId=request.getParameter("cardInfoId");
			String monery=request.getParameter("monery");
			params.put("cardInfoId", cardInfoId);
			params.put("monery", monery);
			params.put("username", getOssUserName(request));
			params.put("rechargeTime", request.getParameter("rechargeTime"));
			params.put("rechargeName", request.getParameter("rechargeName"));
			params.put("tokenCheck", MD5.MD5tool(Config.auth_tpken+cardInfoId+monery));
			obj=OssRechargeMonery(params);
		} catch (Exception e) {
			logger.info("oss充值金额", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 查询卡的消费充值或者还款数据
	 * @param type 0消费1充值2还款
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/getCardInfoConsumeList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getCardInfoConsumeList(String type,String cardType ,String cardNumber,HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		String view="card/cardConsumeList";//根据不同的类型显示不同的页面
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s"); 
			if(n==null){
				n="1";
			}
			if(s==null){ 
				s="10";
			}
			if(StringUtils.isBlank(type)){
				type ="0";
			}
			if(type.equals("1")|| (type.equals("2")&& cardType.equals("2"))){
				view="card/cardRechargeList";
			}else if(type.equals("2")){ 
				view="card/cardImpowerList";
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("cardNumber", cardNumber);
		    map.put("type",  type);
		    map.put("cardType",  cardType);
			obj=OssGetCardInfoConsumeList(n,s,map);
			modelMap.addAttribute("list", obj);
			modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss分页查询卡的消费充值或者还款数据", e);
			e.printStackTrace();
		}
		return view;
	}
	/**
	 * 查询卡的授权信息
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/getCardInfoImpowerList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getCardInfoImpowerList(String cardNumber,String cardType,HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s"); 
			if(n==null){
				n="1";
			}
			if(s==null){ 
				s="10";
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("cardNumber", cardNumber);
			map.put("cardType",  cardType);
			obj=OssGetCardInfoImpowerList(n,s,map);
			modelMap.addAttribute("list", obj);
			modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss分页查询卡的授权信息", e);
			e.printStackTrace();
		}
		return "card/cardImpowerList";
	}
	/**
	 * 
	 * @Title: exportCards  
	 * @Description: oss导出卡数据
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/exportCards")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.EXPORT)
	public void exportCards(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String cardNumber=request.getParameter("cardNumber");
			String customerName=request.getParameter("customerName");
			String phonenumber=request.getParameter("phonenumber");
			String salesName=request.getParameter("salesName");
			String cardStatusstr=request.getParameter("cardStatus");
			String n=request.getParameter("n");
			String s=request.getParameter("s"); 
			if(n==null){
				n="1";
			}
			if(s==null){ 
				s="1000";
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("cardNumber", cardNumber);
			map.put("customerName", customerName);
			map.put("phonenumber", phonenumber);
			map.put("salesName", salesName);
			map.put("cardStatusstr", cardStatusstr);
			obj=OssGetCardInfoParams(n,s,map);
			JSONObject objj1= (JSONObject) obj.get("data");
			JSONObject objj2=(JSONObject) objj1.get("result");
			JSONArray orderlist= (JSONArray) objj2.get("datas");
			 // 第一步，创建一个webbook，对应一个Excel文件
			 HSSFWorkbook wb = new HSSFWorkbook();
			 // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
			 HSSFSheet sheet = wb.createSheet("卡明细");
			 sheet.setColumnWidth(0, 5600);
			 sheet.setColumnWidth(1, 5000);
			 sheet.setColumnWidth(2, 5000);
			 sheet.setColumnWidth(3, 5000);
			 sheet.setColumnWidth(4, 5000);
			 sheet.setColumnWidth(5, 5000);
			 sheet.setColumnWidth(6, 5000);
			 sheet.setColumnWidth(7, 5000);
			 sheet.setColumnWidth(8, 5000);
			 sheet.setColumnWidth(9, 5000);
			 sheet.setColumnWidth(10,5000); 
			 // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
			 HSSFRow row = sheet.createRow((int) 0);
			 // 第四步，创建单元格，并设置值表头 设置表头居中
			 HSSFCellStyle style = wb.createCellStyle();
			 style.setAlignment(HSSFCellStyle.ALIGN_LEFT);// 左右居中
			 style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			 style.setWrapText( true);
			 style.setFillForegroundColor(HSSFColor.YELLOW.index);
			 style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); 
			 
			 style.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
			 style.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
			 style.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
			 style.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框
			 
			 HSSFFont font = (HSSFFont) wb.createFont();
			 font.setFontHeightInPoints((short) 12); // 字体高度
			 font.setFontName("宋体"); // 字体
			 font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); // 宽度
			 style.setFont(font);
			 //强制换行 样式
			 HSSFCellStyle styleR = wb.createCellStyle();
			 styleR.setWrapText(true);
			 HSSFCell cell = row.createCell(0);
			 cell.setCellValue("卡号");
			 cell.setCellStyle(style);
			 cell = row.createCell(1); 
			 cell.setCellValue("客户名称");
			 cell.setCellStyle(style);
			 cell = row.createCell(2); 
			 cell.setCellValue("协议手机号");
			 cell.setCellStyle(style);
			 cell = row.createCell( 3); 
			 cell.setCellValue("N卡类型");
			 cell.setCellStyle(style);
			 cell = row.createCell(4);
			 cell.setCellValue("已消费金额");
			 cell.setCellStyle(style);
			 cell = row.createCell(5);
			 cell.setCellValue("激活时间");
			 cell.setCellStyle(style);
			 cell = row.createCell(6);
			 cell.setCellValue("责任销售");
			 cell.setCellStyle(style);
			 cell = row.createCell(7);
			 cell.setCellValue("余额");
			 cell.setCellStyle(style);
			 cell = row.createCell(8);
			 cell.setCellValue("账单额");
			 cell.setCellStyle(style);
			 cell = row.createCell(9);
			 cell.setCellValue("N卡状态");
			 cell.setCellStyle(style);
			 cell = row.createCell(10);
			 cell.setCellValue("预约次数");
			 cell.setCellStyle(style);
			
			if(orderlist !=null){
				for (int i = 0; i < orderlist.size(); i++) { 
					Map<String,Object> map2 =(Map<String, Object>) orderlist.get(i);
					String cardNum =(String) map2.get("cardNumber");
					String phonenum =(String) map2.get("phonenumber");
					String customerNa =(String) map2.get("customerName");
					Integer cardType =(Integer) map2.get("cardType");
					Integer cardStatus =(Integer) map2.get("cardStatus");
					Long activateTime =(Long) map2.get("activateTime");
					String consumeMoney =(String) map2.get("consumeMoney");
					String salesNa =(String) map2.get("salesName");
					String balanceMoney =(String) map2.get("balanceMoney");
					Integer serviceTimes =(Integer) map2.get("serviceTimes");
					String billMoney=balanceMoney;
					String cardTypeStr="";
					String cardStatusStr="";
					if(cardType.equals(1)){
						cardTypeStr="N卡";
						billMoney="0";
					}else if(cardType.equals(2)){
						cardTypeStr="S卡";
						balanceMoney="0"; 
					}
					String activateTimeStr="";
					if(activateTime !=null){
						activateTimeStr =DateUtils.getStrTime(new Date(activateTime),null);
					}
					cardStatusStr =StatusMap.getType(cardStatus);
					row = sheet.createRow((int) i + 1);
					// 第四步，创建单元格，并设置值
					row.createCell(0).setCellValue(cardNum);
					row.createCell(1).setCellValue(customerNa);
					row.createCell(2).setCellValue(phonenum);
					row.createCell(3).setCellValue(cardTypeStr);
					row.createCell(4).setCellValue(consumeMoney);
					row.createCell(5).setCellValue(activateTimeStr);
					row.createCell(6).setCellValue(salesNa);
					row.createCell(7).setCellValue(balanceMoney);
					row.createCell(8).setCellValue(billMoney);
					row.createCell(9).setCellValue(cardStatusStr);
					row.createCell(10).setCellValue(serviceTimes); 
				}
			}
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			String filename = "卡详情"+DateUtils.getNowTime();
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
			    filename  = URLEncoder.encode(filename, "UTF-8");  
			} else {  
			    filename = new String(filename.getBytes("UTF-8"), "ISO8859-1");  
			} 
			response.setHeader("Content-disposition", "attachment;filename="+filename+".xls");
			wb.write(response.getOutputStream());
		} catch (Exception e) {
			logger.info("exportCards", e);
			e.printStackTrace();
		}
	}
	
	private JSONObject OssAddCards( Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/addCards";
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject OssCountCards() {
		String url = Config.YXTSERVER3 + "ossCard/countCards";
		return getRestApiData(url);
	}
	
	private JSONObject OssGetCardInfoPager(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/getCardInfoPager";
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssGetCardInfoConsumeList(String page,String pageSize,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/getCardInfoConsumeList?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssGetCardInfoImpowerList(String page,String pageSize,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/getCardInfoImpowerList?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject OssGetCardInfoParams(String page,String pageSize,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/getCardInfoParams?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	
	private JSONObject OssGetCardInfo(int cardInfoId) {
		String url = Config.YXTSERVER3 + "ossCard/getCardInfo?cardInfoId="+cardInfoId;
		return getRestApiData(url);
	}
	private JSONObject OssSetCardStatus(int  status,int cardInfoId,String username) {
		String url = Config.YXTSERVER3 + "ossCard/setCardStatus?status="+status+"&cardInfoId="+cardInfoId+"&username="+username;
		return getRestApiData(url);
	}
	private JSONObject OssUpdatecardInfo(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/updatecardInfo";
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssRechargeMonery(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossCard/rechargeMonery";
		return getRestApiData(url,requestParams);
	}
	private JSONObject ossDisableCard(int cardInfoId,int cardYn, String username) {
		String url = Config.YXTSERVER3 + "ossCard/disableCard?cardInfoId="+cardInfoId+"&cardYn="
	           +cardYn+"&username="+username;
		return getRestApiData(url);
	}
}
