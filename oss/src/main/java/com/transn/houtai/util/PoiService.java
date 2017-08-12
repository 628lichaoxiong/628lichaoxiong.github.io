package com.transn.houtai.util;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;


@Component
public class PoiService {
    
	 
    
    public void exportXLS(HttpServletResponse response) {
        
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();
        
        // 2.创建一个 worksheet
        @SuppressWarnings("unused")
        HSSFSheet worksheet = workbook.createSheet("数据统计报表");
        
        // 3.定义起始行和列
        @SuppressWarnings("unused")
        int startRowIndex = 0;
        @SuppressWarnings("unused")
        int startColIndex = 0;
        
        // 4.创建title,data,headers
        
        // 5.填充数据
        
        // 6.设置reponse参数
        String fileName = "Report.xls";
        response.setHeader("Content-Disposition", "inline; filename=" + fileName);
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");
        
        // 7. 输出流
        
    }
    
    /**
     * 读取报表
     */
    public List<String> readReport(InputStream inp,int userid) {
        List<String>  Listerrs = new ArrayList<String> ();
        List<Map<Object, Object>> allListerrs = new ArrayList<Map<Object, Object>>();
        try {
            String cellStr = null;
            
            Workbook wb = WorkbookFactory.create(inp);
            
            Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets
            
            // 从第1行开始读取数据
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
                    	  cellStr = ConvertCellStr(cell, cellStr);
                          List.add(cellStr);
                          cellStr="";
					}
                }
        		if(!"1.0".equals(List.get(0))&&!"".equals(List.get(0))){
        			Map<Object, Object> m=new HashMap<Object, Object>();
            		m.put("userid", userid);
            		m.put("richengid", "0");
            		m.put("meetingname", List.get(0));
//            		m.put("meetingfrom", "");
//            		m.put("info", List.get(1));
            		m.put("category", List.get(4));
            		m.put("language", List.get(5));
            		m.put("type", List.get(3));
            		m.put("jianlitime", List.get(2));
            		allListerrs.add(m);
        		}
        		List.clear();
            }
            String courSharResoStr;
    		@SuppressWarnings("unused")
            ModelAndView modelview = new ModelAndView();
//            courSharResoStr = restTemplate.postForObject(Config.YXTSERVER3+"ossuser/adduserjianli?userid="+userid+"&richengid=0&meetingname="+List.get(0)+"&info="+List.get(1)+"&category="+List.get(4)+"&type="+List.get(3)+"&jianlitime="+List.get(2)+"&address="+List.get(6)+"&language="+List.get(5), null, String.class,"");
    		String jsontext=JSON.toJSONString(allListerrs,SerializerFeature.WriteMapNullValue);
    		MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>(); 
    		map.set("jsontext", jsontext);
    		
    		RestTemplate restTemplate = new RestTemplate();
    		courSharResoStr = restTemplate.postForObject(Config.YXTSERVER3+"ossuser/adduserjianli", map, String.class,"");
    		
    		@SuppressWarnings("unused")
            JSONObject objj=JSONObject.parseObject(courSharResoStr);
//    		if(objj.getInt("status")!=200){
//    			Listerrs.add(List.get(0));
//    		}
    		} catch (Exception e) {
           
            e.printStackTrace();
        } finally {
            if (inp != null) {
                try {
                    inp.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                
            }
        }
        return Listerrs;
        
    }



    /**
     * 读取报表
     */
    public List<String>  readReport2(InputStream inp) {
        List<String>  Listerrs = new ArrayList<String> ();
        List<Map<String, Object>>  AllListerrs = new ArrayList<Map<String, Object>>();
        try {
            String cellStr = null;
            Workbook wb = WorkbookFactory.create(inp);
            Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets
            // 从第1行开始读取数据
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
                        cellStr = ConvertCellStr(cell, cellStr);
                        List.add(cellStr);
                        cellStr="";
                    }
                }
                if(!"1.0".equals(List.get(0))&&!"".equals(List.get(0))){
                    Map<String, Object> m=new HashMap<String, Object>();
                    m.put("usernumber", List.get(0));//译员编号
                    m.put("realusername", List.get(1));//姓名
                    m.put("sex", List.get(2));//性别
                    m.put("age", List.get(3));//出生年月
                    m.put("education1",List.get(4));//学历
                    m.put("country", List.get(5));//居住地
                    m.put("language", List.get(7));//目标语种
                    m.put("workyears", List.get(8));//翻译经验
                    m.put("othercountry", List.get(9));//海外经历
                    m.put("type", List.get(10));//口译类型
                    m.put("hangye", List.get(11));//擅长行业
                    m.put("userphonenumber", List.get(12));//手机号
                    m.put("userqq", List.get(13));//qq号
                    m.put("useremail", List.get(14));//邮箱
                    m.put("workaddress", List.get(15));//意向工作地区
                    m.put("worktype", List.get(16));//工作性质
                    m.put("worktime", List.get(17));//工作周期
                    m.put("usercurwork", List.get(18));//工作状态
                    m.put("servicetime", List.get(19)==null?'0':List.get(19));//技能次数
                    m.put("serviceevaluate", List.get(20)==null?'5':List.get(20));//技能评价
                    m.put("school1", List.get(21));//教育1
                    m.put("school2", List.get(22));//教育2
                    m.put("usertechnical", List.get(23));//技能证书
                    m.put("userInfo", List.get(24));//自我描述
                    m.put("jingli1", List.get(25));
                    m.put("jingli2", List.get(26));
                    m.put("jingli3", List.get(27));
                    m.put("jingli4", List.get(28));
                    m.put("jingli5", List.get(29));
                    AllListerrs.add(m);
                }
                List.clear();
            }
            @SuppressWarnings("unused")
            String courSharResoStr;
            @SuppressWarnings("unused")
            ModelAndView modelview = new ModelAndView();
//            courSharResoStr = restTemplate.postForObject(Config.YXTSERVER3+"ossuser/adduserjianli?userid="+userid+"&richengid=0&meetingname="+List.get(0)+"&info="+List.get(1)+"&category="+List.get(4)+"&type="+List.get(3)+"&jianlitime="+List.get(2)+"&address="+List.get(6)+"&language="+List.get(5), null, String.class,"");
            String jsontext=JSON.toJSONString(AllListerrs,SerializerFeature.WriteMapNullValue);
            MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();
            map.set("jsontext", jsontext);

            RestTemplate restTemplate = new RestTemplate();
            courSharResoStr = restTemplate.postForObject(Config.YXTSERVER3+"ossResume/updateResume", map, String.class,"");

//            JSONObject objj=JSONObject.fromObject(courSharResoStr);
//    		if(objj.getInt("status")!=200){
//    			Listerrs.add(List.get(0));
//    		}
        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            if (inp != null) {
                try {
                    inp.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {

            }
        }
        return Listerrs;

    }



    /**
     * 
     * @Title: readResume  
     * @Description: 读取简历模板  
     * @param is
     * @return
     * @return List<String>
     */
    public JSONObject readResume(InputStream is){
         List<Map<String, Object>>  allListerrs = new ArrayList<Map<String, Object>>();
         JSONObject objj=null;
         try {
             String cellStr = null;
            Workbook wb = WorkbookFactory.create(is);
             Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets
             
             // 从第1行开始读取数据
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
                     	  cellStr = ConvertCellStr(cell, cellStr);
                           List.add(cellStr);
                           cellStr="";
 					}
                     // 转换接收的单元格
                   
                     //System.out.println(cellStr);
                 }
         		if(!"".equals(List.get(0))){
         			Map<String, Object> m=new HashMap<String, Object>();
             		m.put("usernumber", List.get(0));//译员编号
             		m.put("realusername", List.get(1));//姓名
             		m.put("sex", List.get(2));//性别
             		m.put("age", List.get(3));//出生年月
             		m.put("education1",List.get(4));//学历
             		m.put("country", List.get(5));//居住地
             		m.put("language", List.get(7));//目标语种
             		m.put("workyears", List.get(8));//翻译经验
             		m.put("othercountry", List.get(9));//海外经历
             		m.put("type", List.get(10));//口译类型
             		m.put("hangye", List.get(11));//擅长行业
             		m.put("userphonenumber", List.get(12));//手机号
             		m.put("userqq", List.get(13));//qq号
             		m.put("useremail", List.get(14));//邮箱
             		m.put("workaddress", List.get(15));//意向工作地区
             		m.put("worktype", List.get(16));//工作性质
             		m.put("worktime", List.get(17));//工作周期
             		m.put("usercurwork", List.get(18));//工作状态
             		m.put("servicetime", List.get(19)==null?'0':List.get(19));//技能次数
             		m.put("serviceevaluate", List.get(20)==null?'5':List.get(20));//技能评价
             		m.put("school1", List.get(21));//教育1
             		m.put("school2", List.get(22));//教育2
             		m.put("usertechnical", List.get(23));//技能证书
             		m.put("userInfo", List.get(24));//自我描述
             		m.put("jingli1", List.get(25));
             		m.put("jingli2", List.get(26));
             		m.put("jingli3", List.get(27));
             		m.put("jingli4", List.get(28));
             		m.put("jingli5", List.get(29));	
             		allListerrs.add(m);
         		}
         		List.clear();
             }
             
     		String jsontext=JSON.toJSONString(allListerrs,SerializerFeature.WriteMapNullValue);
     		MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>(); 
     		map.set("jsontext", jsontext);
     		RestTemplate restTemplate = new RestTemplate();
     		String courSharResoStr = restTemplate.postForObject(Config.YXTSERVER3+"ossResume/importResume",  map, String.class,"");
     		objj=JSONObject.parseObject(courSharResoStr);
     		} catch (Exception e) {
            
             e.printStackTrace();
         } finally {
             if (is != null) {
                 try {
                     is.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             } else {
                 
             }
         }
         return objj;
    	
    }
    
    
    /**
     * 把单元格内的类型转换至String类型
     */
    private String ConvertCellStr(Cell cell, String cellStr) {
    	DecimalFormat df = new DecimalFormat("#"); 
        switch (cell.getCellType()) {
        
        case Cell.CELL_TYPE_STRING:
            // 读取String
            cellStr = cell.getStringCellValue().toString();
            break;
        
        case Cell.CELL_TYPE_BOOLEAN:
            // 得到Boolean对象的方法
            cellStr = String.valueOf(cell.getBooleanCellValue());
            break;
        
        case Cell.CELL_TYPE_NUMERIC:
            
            // 先看是否是日期格式
            if (DateUtil.isCellDateFormatted(cell)) {
                
                // 读取日期格式
                cellStr = cell.getDateCellValue().toString();
                
            } else {
                
                // 读取数字
                cellStr = String.valueOf(df.format(cell.getNumericCellValue()));
            }
            break;
        
        case Cell.CELL_TYPE_FORMULA:
            // 读取公式
            cellStr = cell.getCellFormula().toString();
            break;
        }
        return cellStr;
    }
    
    
    
}
