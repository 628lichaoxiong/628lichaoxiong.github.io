package com.transn.houtai.oss;

import java.io.File;
import java.io.FileOutputStream;
import java.io.RandomAccessFile;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.transn.houtai.util.qiniu;

/**
 * 异常处理
 * @author lichaoxiong
 *
 */
@Controller
@RequestMapping("/exception")
public class ExceptionController extends BaseController{
	@RequestMapping("error") 
	public String error(String msg,HttpServletRequest request,HttpServletResponse response, ModelMap context) throws Exception {
		msg = URLDecoder.decode(msg, "UTF-8");
		context.put("msg", msg);
		return "error";
	}
	/**
	 * json 请求出现错误异常处理！
	 * @param exception
	 * @param request
	 * @param response
	 * @param context
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("errorJson")
	public @ResponseBody Map<String, Object> errorJson(String msg,HttpServletRequest request,HttpServletResponse response, ModelMap context) throws Exception {
		Map<String, Object> map =new HashMap<String, Object>();
		msg = URLDecoder.decode(msg, "UTF-8");
		map.put("msg", msg);
		map.put("jsonError", true);
		return map;
	}
	@RequestMapping("redExcel")
	public @ResponseBody Map<String, Object> redExcel(@RequestParam MultipartFile uploadFile,HttpServletRequest request,HttpServletResponse response, ModelMap context) throws Exception {
		String sql="";
		createFile(new File("/transnsg/user_resume.txt"));
		 try {
	            String cellStr = null;
	            Workbook wb = WorkbookFactory.create(uploadFile.getInputStream());
	            Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets
	            // 从第1行开始读取数据
	            //update user_resume set username ='' where usernumber ='';
	            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
	                Row row = sheet.getRow(i); // 获取行(row)对象
	                //System.out.println(row);
	                if (row == null) {
	                    // row为空的话,不处理
	                    continue;
	                }
	                List<String>  List = new ArrayList<String> ();
	                for (int j = 0; j < row.getLastCellNum(); j++) {

	                    Cell cell = row.getCell(j); // 获得单元格(cell)对象

	                    if(cell==null){
	                        List.add("");
	                    }
	                    else {
	                    	if(j ==0){
	                    		sql =sql+ "update user_resume set username ='"+ cell.getStringCellValue().toString()+"' where usernumber =";
	                    	}else if(j ==1){
	                    		sql = sql+"'"+ cell.getStringCellValue().toString()+"';\r\n";
	                    	}
	                       
	                    }
	                }
	                System.out.println(sql);
	                writeTxtFile(sql, new File("/transnsg/user_resume.txt"));
	            }
		 }catch(Exception e){
			 
		 }
	    
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("msg", sql);
		map.put("jsonError", true);
		return map;
	}
	/** 
	  * 创建文件 
	  * @param fileName 
	  * @return 
	  */  
	 public static boolean createFile(File fileName)throws Exception{  
	  boolean flag=false;  
	  try{  
	   if(!fileName.exists()){  
	    fileName.createNewFile();  
	    flag=true;  
	   }  
	  }catch(Exception e){  
	   e.printStackTrace();  
	  }  
	  return true;  
	 }   
	 public static boolean writeTxtFile(String content,File  fileName)throws Exception{  
		  boolean flag=false;  
		  FileOutputStream o=null;  
		  try {  
		   o = new FileOutputStream(fileName);  
		      o.write(content.getBytes("GBK"));  
		      o.close();  
		   flag=true;  
		  } catch (Exception e) {  
		   e.printStackTrace();  
		  }finally{  
		  }  
		  return flag;  
		 }  
}
