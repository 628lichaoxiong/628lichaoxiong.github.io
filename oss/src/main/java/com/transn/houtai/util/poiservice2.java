package com.transn.houtai.util;

import java.util.List;  
  
import javax.servlet.http.HttpServletResponse;  
  
import org.apache.poi.hssf.usermodel.HSSFSheet;  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.ss.usermodel.Cell;  
import org.apache.poi.ss.usermodel.DateUtil;  
import org.springframework.stereotype.Service;  
  
@Service
public class poiservice2 {  
  
//    @Resource(name = "poiDao")  
//    private PoiDao dao;  
     
    public void exportXLS(HttpServletResponse response,List<ExcelOutPOJO> l) {  
  
        // 1.创建一个 workbook  
        HSSFWorkbook workbook = new HSSFWorkbook();  
  
        // 2.创建一个 worksheet  
        HSSFSheet worksheet = workbook.createSheet("数据统计报表");  
  
        // 3.定义起始行和列  
        int startRowIndex = 0;  
        int startColIndex = 0;  
  
        // 4.创建title,data,headers  
        Layouter.buildReport(worksheet, startRowIndex, startColIndex);  
  
        // 5.填充数据  
        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,  
                l);  
  
        // 6.设置reponse参数  
        String fileName = "Report.xls";  
        response.setHeader("Content-Disposition", "inline; filename="  
                + fileName);  
        // 确保发送的当前文本格式  
        response.setContentType("application/vnd.ms-excel");  
  
        // 7. 输出流  
        Writer.write(response, worksheet);  
  
    }  
    
    
    
    public void exportXLS2(HttpServletResponse response,List<ExcelOutPOJO2> l) {  
    	  
        // 1.创建一个 workbook  
        HSSFWorkbook workbook = new HSSFWorkbook();  
  
        // 2.创建一个 worksheet  
        HSSFSheet worksheet = workbook.createSheet("数据统计报表");  
  
        // 3.定义起始行和列  
        int startRowIndex = 0;  
        int startColIndex = 0;  
  
        // 4.创建title,data,headers  
        Layouter2.buildReport(worksheet, startRowIndex, startColIndex);  
  
        // 5.填充数据  
        FillComputerManager2.fillReport(worksheet, startRowIndex, startColIndex,  
                l);  
  
        // 6.设置reponse参数  
        String fileName = "Report.xls";  
        response.setHeader("Content-Disposition", "inline; filename="  
                + fileName);  
        // 确保发送的当前文本格式  
        response.setContentType("application/vnd.ms-excel");  
  
        // 7. 输出流  
        Writer.write(response, worksheet);  
  
    }  
    
    public void exportXLS3(HttpServletResponse response,List<ExcelOutPOJO3> l) {  
  	  
        // 1.创建一个 workbook  
        HSSFWorkbook workbook = new HSSFWorkbook();  
  
        // 2.创建一个 worksheet  
        HSSFSheet worksheet = workbook.createSheet("高级用户统计报表");  
  
        // 3.定义起始行和列  
        int startRowIndex = 0;  
        int startColIndex = 0;  
  
        // 4.创建title,data,headers  
        Layouter3.buildReport(worksheet, startRowIndex, startColIndex);  
  
        // 5.填充数据  
        FillComputerManager3.fillReport(worksheet, startRowIndex, startColIndex,  
                l);  
  
        // 6.设置reponse参数  
        String fileName = "Report.xls";  
        response.setHeader("Content-Disposition", "inline; filename="  
                + fileName);  
        // 确保发送的当前文本格式  
        response.setContentType("application/vnd.ms-excel");  
  
        // 7. 输出流  
        Writer.write(response, worksheet);  
  
    }  
  
    /** 
     * 读取报表 
     */  
//    public List<ExcelOutPOJO> readReport(InputStream inp) {  
//  
//        List<ExcelOutPOJO> computerList = new ArrayList<ExcelOutPOJO>();  
//  
//        try {  
//            String cellStr = null;  
//  
//            Workbook wb = WorkbookFactory.create(inp);  
//  
//            Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets  
//  
//            //从第四行开始读取数据  
//            for (int i = 3; i <= sheet.getLastRowNum(); i++) {  
//  
//            	ExcelOutPOJO computer = new ExcelOutPOJO();  
//            	ExcelOutPOJO addComputer = new ExcelOutPOJO();  
//  
//                Row row = sheet.getRow(i); // 获取行(row)对象  
//  
//                if (row == null) {  
//                    // row为空的话,不处理  
//                    continue;  
//                }  
//  
//                for (int j = 0; j < row.getLastCellNum(); j++) {  
//  
//                    Cell cell = row.getCell(j); // 获得单元格(cell)对象  
//  
//                    // 转换接收的单元格  
//                    cellStr = ConvertCellStr(cell, cellStr);  
//  
//                    // 将单元格的数据添加至一个对象  
//                    addComputer = addingComputer(j, computer, cellStr);  
//  
//                }  
//                // 将添加数据后的对象填充至list中  
//                computerList.add(addComputer);  
//            }  
//  
//        } catch (InvalidFormatException e) {  
//            e.printStackTrace();  
//        } catch (IOException e) {  
//            e.printStackTrace();  
//        } finally {  
//            if (inp != null) {  
//                try {  
//                    inp.close();  
//                } catch (IOException e) {  
//                    e.printStackTrace();  
//                }  
//            } else {  
//                logger.info("没有数据流!");  
//            }  
//        }  
//        return computerList;  
//  
//    }  
  
    /** 
     * 从数据库获得所有的Computer信息. 
     */  
    @SuppressWarnings("unused")
    private List<ExcelOutPOJO> getDatasource(List<ExcelOutPOJO> l) {  
       // return dao.getComputer(); 
//    	ExcelOutPOJO e=new ExcelOutPOJO();
//    	e.setMouth1("1");
//    	e.setMouth2("2");
//    	e.setMouth3("3");
//    	e.setMouth4("4");
//    	e.setMouth5("5");
//    	e.setMouth6("6");
//    	e.setMouth7("7");
//    	e.setMouth8("8");
//    	e.setMouth9("9");
//    	e.setMouth10("10");
//    	e.setMouth11("11");
//    	e.setMouth12("12");
//    	e.setName("干货");
//    	e.setSum("100");
//    	e.setPrecent("10");
//    	List<ExcelOutPOJO> l=new ArrayList<ExcelOutPOJO>();
//    	l.add(e);
    	return l;
    }  
  
    /** 
     * 读取报表的数据后批量插入 
     */  
    public int[] insertComputer(List<ExcelOutPOJO> list) {  
        //return dao.insertComputer(list);  
    	return null;
    }  
  
    /** 
     * 获得单元格的数据添加至computer 
     *  
     * @param j 
     *            列数 
     * @param computer 
     *            添加对象 
     * @param cellStr 
     *            单元格数据 
     * @return 
     */  
//    private ExcelOutPOJO addingComputer(int j, ExcelOutPOJO computer, String cellStr) {  
//        switch (j) {  
//        case 0:  
//            computer.setId(null);  
//            break;  
//        case 1:  
//            computer.setBrand(cellStr);  
//            break;  
//        case 2:  
//            computer.setCpu(cellStr);  
//            break;  
//        case 3:  
//            computer.setGpu(cellStr);  
//            break;  
//        case 4:  
//            computer.setMemory(cellStr);  
//            break;  
//        case 5:  
//            computer.setPrice(new Double(cellStr).doubleValue());  
//            break;  
//        }  
//  
//        return computer;  
//    }  
  
    /** 
     * 把单元格内的类型转换至String类型 
     */  
    @SuppressWarnings("unused")
    private String ConvertCellStr(Cell cell, String cellStr) {  
  
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
                cellStr = String.valueOf(cell.getNumericCellValue());  
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
