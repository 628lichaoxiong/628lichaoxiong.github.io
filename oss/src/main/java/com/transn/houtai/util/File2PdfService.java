package com.transn.houtai.util;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * 文件转换服务，将各类文档文件转换为PDF文件
 * @author barry.wang
 * @version 2.0.0
 * @history 2017-03-13 barry.wang 创建 
 */
public interface File2PdfService {
    /**
     * 将输入文件转换为PDF文件。
     * <br/>
     * <em>注意：输入及输出流在该方法中不会主动关闭，请调用完成后自己关闭！</em>
     * @param inputStream 输入流
     * @param outputStream 输出流
     * @return ConvertStatus 转换状态
     */
    public ConvertStatus convert2Pdf(InputStream inputStream, OutputStream outputStream);
}
