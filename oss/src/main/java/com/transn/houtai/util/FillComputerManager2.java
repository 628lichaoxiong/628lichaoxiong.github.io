package com.transn.houtai.util;

import java.util.List;  

import org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.hssf.usermodel.HSSFCellStyle;  
import org.apache.poi.hssf.usermodel.HSSFRow;  
import org.apache.poi.hssf.usermodel.HSSFSheet;  
import org.apache.poi.ss.usermodel.CellStyle;  
  
public class FillComputerManager2 {  
  
    public static void fillReport(HSSFSheet worksheet, int startRowIndex,  
            int startColIndex, List<ExcelOutPOJO2> datasource) {  
  
        // Row offset  
        startRowIndex += 2;  
  
        // Create cell style for the body  
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();  
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);  
        bodyCellStyle.setWrapText(false); //是否自动换行.  
        
        // date header  
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);  
        HSSFCell cellDate = dateTitle.createCell(startColIndex);  
        cellDate.setCellValue("课程的订单总金额: " + datasource.get(0).getCount()+"元");  
        
  
        // Create body  
        for (int i=startRowIndex; i+startRowIndex-2< datasource.size()+2; i++) {  
            // Create a new row  
            HSSFRow row = worksheet.createRow((short) i+1);  
  
            // Retrieve the id value  
            HSSFCell cell1 = row.createCell(startColIndex+0);  
            cell1.setCellValue(datasource.get(i-2).getId());  
            cell1.setCellStyle(bodyCellStyle);  
  
            // Retrieve the brand value  
            HSSFCell cell2 = row.createCell(startColIndex+1);  
            cell2.setCellValue(datasource.get(i-2).getBuyer());  
            cell2.setCellStyle(bodyCellStyle);  
  
            // Retrieve the model value  
            HSSFCell cell3 = row.createCell(startColIndex+2);  
            cell3.setCellValue(datasource.get(i-2).getCouponname());  
            cell3.setCellStyle(bodyCellStyle);  
  
            
         // Retrieve the model value  
            HSSFCell cell4 = row.createCell(startColIndex+3);  
            cell4.setCellValue(datasource.get(i-2).getCouponcardcode());  
            cell4.setCellStyle(bodyCellStyle); 
            
            
         // Retrieve the brand value  
            HSSFCell cell5 = row.createCell(startColIndex+4);  
            cell5.setCellValue(datasource.get(i-2).getAuhtor());  
            cell5.setCellStyle(bodyCellStyle);  
  
            // Retrieve the model value  
            HSSFCell cell6 = row.createCell(startColIndex+5);  
            cell6.setCellValue(datasource.get(i-2).getPrice());  
            cell6.setCellStyle(bodyCellStyle);  
  
            
         // Retrieve the model value  
            HSSFCell cell7 = row.createCell(startColIndex+6);  
            cell7.setCellValue(datasource.get(i-2).getRealprice());  
            cell7.setCellStyle(bodyCellStyle); 
            
            
            // Retrieve the model value  
            HSSFCell cell8 = row.createCell(startColIndex+7);  
            cell8.setCellValue(datasource.get(i-2).getData());  
            cell8.setCellStyle(bodyCellStyle); 
         
        }  
    }  
}  