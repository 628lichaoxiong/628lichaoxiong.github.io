package com.transn.houtai.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.transn.houtai.util.impl.Doc2PdfServiceImpl;
import com.transn.houtai.util.impl.Excel2PdfServiceImpl;
import com.transn.houtai.util.impl.PPT2PdfServiceImpl;
import com.transn.houtai.util.impl.Txt2PdfServiceImpl;

/**
 * 文件转换服务，将各类文档文件转换为PDF文件
 * @author barry.wang
 * @version 2.0.0
 * @history 2017-03-13 barry.wang 创建 
 */
public class Converter implements Runnable{
    Logger logger = LoggerFactory.getLogger(Converter.class);
    /**
     * 原文件
     */
    private File srcFile;
    /**
     * 转换后的文件
     */
    private File destFile; 
    /**
     * 转换前文件类型
     */
    private String fileType;
    
    public Converter(File srcFile, File destFile, String fileType){
        this.srcFile = srcFile;
        this.destFile = destFile;
        this.fileType = fileType;
    }

    /**
     * 其他文件转换为PDF
     */
    @Override
    public void run() {
        File2PdfService file2PdfService = null;
        if(".DOCX".equals(fileType.toUpperCase()) || ".DOC".equals(fileType.toUpperCase())){
            file2PdfService = new Doc2PdfServiceImpl();
        } else if(".PPTX".equals(fileType.toUpperCase()) || ".PPT".equals(fileType.toUpperCase())){
            file2PdfService = new PPT2PdfServiceImpl();
        } else if(".XLSX".equals(fileType.toUpperCase()) || ".XLS".equals(fileType.toUpperCase())){
            file2PdfService = new Excel2PdfServiceImpl();
        } else if(".TXT".equals(fileType.toUpperCase())){
            file2PdfService = new Txt2PdfServiceImpl();
        } else {
            logger.error("不支持的文件格式:"+fileType);
            return;
        }
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try{
            inputStream = new FileInputStream(srcFile);
            outputStream = new FileOutputStream(destFile);
            file2PdfService.convert2Pdf(inputStream, outputStream);
        } catch (IOException e){
            logger.error("找不到对应文件", e);
        }
    }
    
    public static void main(String[] args) throws FileNotFoundException{
        File2PdfService file2PdfService = new PPT2PdfServiceImpl();
        InputStream inputStream = new FileInputStream(new File("F:\\传神管理文档\\王学兴-述职报告.ppt"));
        OutputStream onputStream = new FileOutputStream(new File("F:\\传神管理文档\\王学兴-述33333职报告.ppt.pdf"));
        file2PdfService.convert2Pdf(inputStream, onputStream);
    }
}
