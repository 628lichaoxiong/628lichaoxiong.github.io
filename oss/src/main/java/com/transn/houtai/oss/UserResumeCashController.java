package com.transn.houtai.oss;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.DateUtils;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;
/**
 * 译员提现管理
 * @author james.li
 * @time  2017年7月14日 下午3:39:36
 */
@Controller
@RequestMapping("/userResumeCash")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100102)
public class UserResumeCashController extends BaseController {
	Logger logger = LoggerFactory.getLogger(UserResumeCashController.class);
	
	/**
	 * 译员提现管理列表
	 * @Title: getUserResumeCashList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getUserResumeCashList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getUserResumeCashList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			Map<String, Object> map =new HashMap<String, Object>();
			String serviceId=request.getParameter("serviceId");
			String userphonenumber =request.getParameter("userphonenumber");
			String usernumber =request.getParameter("usernumber");
			String username =request.getParameter("username");
			map.put("userphonenumber", userphonenumber );
			map.put("usernumber", usernumber );
			map.put("username", username );
			String export=request.getParameter("export");
			map.put("export", export);
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("serviceId", serviceId);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetUserResumeCashList(n,s,map);
			modelMap.addAttribute("params",map);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss译员提现管理列表", e);
			e.printStackTrace();
		}
		return "userresumecash/userResumeCashList";
	}
	
	/**
	 * @Title: 导出Excel
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping("/exportExcel")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.EXPORT)
	public void  exportExcel(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
		JSONObject obj=null;
		try {
			Map<String, Object> map =new HashMap<String, Object>();
			String serviceId=request.getParameter("serviceId");
			map.put("serviceId", serviceId);
			String userphonenumber =request.getParameter("userphonenumber");
			String usernumber =request.getParameter("usernumber");
			String username =request.getParameter("username");
			map.put("userphonenumber", userphonenumber );
			map.put("usernumber", usernumber );
			map.put("username", username );
			String export=request.getParameter("export");
			map.put("export", export);
			obj=ossGetUserResumeCashExport(map);
			JSONObject objj1= (JSONObject) obj.get("data");
			String objj2= objj1.getString("result");
			List<Map<String,Object>>  list=JSONObject.parseObject(objj2,List.class);
			// 第一步，创建一个webbook，对应一个Excel文件
			HSSFWorkbook wb = new HSSFWorkbook();
			// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
			HSSFSheet sheet = wb.createSheet("提现明细");
			sheet.setColumnWidth(0, 5000);sheet.setColumnWidth(1, 5000);sheet.setColumnWidth(2, 5000);
			sheet.setColumnWidth(3, 5000);sheet.setColumnWidth(4, 5000);sheet.setColumnWidth(5, 5000);
			sheet.setColumnWidth(6, 5000);sheet.setColumnWidth(7, 5000);sheet.setColumnWidth(8, 5000);
			sheet.setColumnWidth(9, 5000);sheet.setColumnWidth(10, 5000);sheet.setColumnWidth(11, 5000);
			sheet.setColumnWidth(12, 5000);sheet.setColumnWidth(13, 5000);sheet.setColumnWidth(14, 5000);
			sheet.setColumnWidth(15, 5000);sheet.setColumnWidth(16, 5000);sheet.setColumnWidth(17, 5000);
			sheet.setColumnWidth(18, 5000);sheet.setColumnWidth(19, 5000);sheet.setColumnWidth(20, 5000);
			sheet.setColumnWidth(21, 5000);
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
			HSSFCell cell = row.createCell(0);cell.setCellValue("译员账户");cell.setCellStyle(style);
			cell = row.createCell(1);cell.setCellValue("合作人员姓名");cell.setCellStyle(style);
			cell = row.createCell((short) 2);cell.setCellValue("项目编号");cell.setCellStyle(style);
			cell = row.createCell((short) 3);cell.setCellValue("项目名称");cell.setCellStyle(style);
			cell = row.createCell((short) 4);cell.setCellValue("处理类型");cell.setCellStyle(style);
			cell = row.createCell((short) 5);cell.setCellValue("翻译方向");cell.setCellStyle(style);
			cell = row.createCell((short) 6);cell.setCellValue("项目经理");cell.setCellStyle(style);
			cell = row.createCell((short) 7);cell.setCellValue("开工时间");cell.setCellStyle(style);
			cell = row.createCell((short) 8);cell.setCellValue("完工时间");cell.setCellStyle(style);
			cell = row.createCell((short) 9);cell.setCellValue("翻译时间");cell.setCellStyle(style);
			cell = row.createCell((short) 10);cell.setCellValue("合作单价");cell.setCellStyle(style);
			cell = row.createCell((short) 11);cell.setCellValue("合作金额");cell.setCellStyle(style);
			cell = row.createCell((short) 12);cell.setCellValue("扣款额");cell.setCellStyle(style);
			cell = row.createCell((short) 13);cell.setCellValue("税前实际结算");cell.setCellStyle(style);
			cell = row.createCell((short) 14);cell.setCellValue("扣税金额");cell.setCellStyle(style);
			cell = row.createCell((short) 15);cell.setCellValue("税后实际结算");cell.setCellStyle(style);
			cell = row.createCell((short) 16);cell.setCellValue("具体支付日期");cell.setCellStyle(style);
			cell = row.createCell((short) 17);cell.setCellValue("支付级别");cell.setCellStyle(style);
			cell = row.createCell((short) 18);cell.setCellValue("汇款银行");cell.setCellStyle(style);
			cell = row.createCell((short) 19);cell.setCellValue("帐户名");cell.setCellStyle(style);
			cell = row.createCell((short) 20);cell.setCellValue("账号/卡号");cell.setCellStyle(style);
			cell = row.createCell((short) 21);cell.setCellValue("证件号码/其他");cell.setCellStyle(style);
			List<Integer> ids =new ArrayList<Integer>();
			for(int i=0;i<list.size();i++){
				Map mp =list.get(i);
				Integer id =(Integer) mp.get("id");
				ids.add(id);
				String value_0 =(String) mp.get("bankName");String value_1 =(String) mp.get("userName");
				Integer value_2 =(Integer) mp.get("serviceId");String value_3 =(String) mp.get("projectName");
				String value_4 ="陪同";String value_5 =(String) mp.get("language");
				String value_6 ="何欢";String value_7 =(String) mp.get("serviceBeginTime");
				String value_8 =(String) mp.get("serviceEndTime");String value_9 =(String) mp.get("days");
				Integer value_10 =(Integer) mp.get("price");
				BigDecimal value_11 =(BigDecimal) mp.get("orderPrice");
				BigDecimal value_12 =(BigDecimal) mp.get("servicePrice");
				String value_13 =value_11.subtract(value_12).toString();//税前实际结算（合作金额-扣款额）
				String value_14 ="0";
				String value_15 =value_13;//
				String value_16 ="无";String value_17 ="无";
				String value_18 =(String) mp.get("accountName");String value_19 =(String) mp.get("bankName");
				String value_20 =(String) mp.get("bankCardno");String value_21 =(String) mp.get("idCard");
				
				row = sheet.createRow((int) i + 1);
				// 第四步，创建单元格，并设置值
				row.createCell((short) 0).setCellValue(value_0);
				row.createCell((short) 1).setCellValue(value_1);
				row.createCell((short) 2).setCellValue(value_2);
				row.createCell((short) 3).setCellValue(value_3);
				row.createCell((short) 4).setCellValue(value_4);
				row.createCell((short) 5).setCellValue(value_5);
				row.createCell((short) 6).setCellValue(value_6);
				row.createCell((short) 7).setCellValue(value_7);
				row.createCell((short) 8).setCellValue(value_8);
				row.createCell((short) 9).setCellValue(value_9);
				row.createCell((short) 10).setCellValue(value_10.toString());
				row.createCell((short) 11).setCellValue(value_11.toString());
				row.createCell((short) 12).setCellValue(value_12.toString());
				row.createCell((short) 13).setCellValue(value_13);
				row.createCell((short) 14).setCellValue(value_14);
				row.createCell((short) 15).setCellValue(value_15);
				row.createCell((short) 16).setCellValue(value_16);
				row.createCell((short) 17).setCellValue(value_17);
				row.createCell((short) 18).setCellValue(value_18);
				row.createCell((short) 19).setCellValue(value_19);
				row.createCell((short) 20).setCellValue(value_20);
				row.createCell((short) 21).setCellValue(value_21);
			}
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			String filename = "提现明细"+DateUtils.getNowTime();
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
				filename  = URLEncoder.encode(filename, "UTF-8");  
			} else {  
				 filename = new String(filename.getBytes("UTF-8"), "ISO8859-1");  
			} 
			response.setHeader("Content-disposition", "attachment;filename="+filename+".xls");
			if(ids.size() >0){
				//进行导出的数据修改成已导出
				Map requestParams =new HashMap();
				requestParams.put("ids", JSONObject.toJSONString(ids));
				JSONObject data =	ossUpdateUserResumeCashExport(requestParams );
				JSONObject data1= (JSONObject) data.get("data");
				Boolean data2= data1.getBoolean("result");
				String msg= data.getString("msg");
				if(!data2){
					logger.error("oss译员导出，导出数据修改出现错误", msg);
				}else{
					wb.write(response.getOutputStream());
				}
			}else{
				wb.write(response.getOutputStream());
			}
		} catch (Exception e) {
			logger.info("oss译员导出", e);
			e.printStackTrace();
		}
	}
	
	private JSONObject ossUpdateUserResumeCashExport(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossUserResumeCash/updateUserResumeCashExport";
		return getRestApiData(url,requestParams); 
	}
	private JSONObject ossGetUserResumeCashExport(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossUserResumeCash/getUserResumeCashExport";
		return getRestApiData(url,requestParams); 
	}
	private JSONObject ossGetUserResumeCashList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossUserResumeCash/getUserResumeCashList";
		return getRestApiData(url,requestParams); 
	}
}
