package com.transn.houtai.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

/**
 * 类功能描述:文件处理工具类
 * @className FileUtils.java
 * 
 * @author barry.wang
 * @version 2.0.0
 * 
 * @history 2017-03-14 barry.wang 创建 FileUtils.java
 */
public class FileUtils extends org.apache.commons.io.FileUtils{
	/**
	 * 下载文件
	 * @param destFileWithPath 带路径的文件（包含绝对路径）
	 * @param response
	 * @throws Exception 
	 */
	public static void downloadFile(String destFileWithPath, String fileName, HttpServletResponse response) throws Exception{
		OutputStream output = null;
        InputStream input = null;
        try {
        	input = new FileInputStream(new File(destFileWithPath));
        	int index = fileName.lastIndexOf(".");
        	String fileType = fileName.substring(index);
	        // 设置头信息
	        setResponse(fileName, fileType, response);
	        response.setHeader("Content-length", String.valueOf(input.available()));
	        // 输出文件
	        output = response.getOutputStream();
	        IOUtils.copy(input, output);
        }  catch (Exception e) {
			throw e;
		} finally{
			try {
				if(output != null){
					output.close();
				}
				if(input != null){
					input.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 删除服务器上文件
	 * @param sPath
	 * @return
	 */
	public static boolean deleteFile(String sPath) { 
	    Boolean flag = false; 
	    File file = new File(sPath); 
	      // 路径为文件且不为空则进行删除 
	      if (file.isFile() && file.exists()) { 
	          file.delete(); 
	          flag = true; 
	      } 
	      return flag; 
	  }
    /**
     * 设置Response参数
     * @param fileName
     * @param fileType
     * @param response
     * @throws UnsupportedEncodingException
     */
    public static void setResponse(String fileName, String fileType, HttpServletResponse response) throws UnsupportedEncodingException {
        if (fileType.equalsIgnoreCase(".doc") || fileType.equalsIgnoreCase(".docx")) {
            response.setContentType("application/msword");
        } else if (fileType.equalsIgnoreCase(".pdf")) {
            response.setContentType("application/pdf");
        } else if (fileType.equalsIgnoreCase(".tif")) {
            response.setContentType("image/tiff");
        } else if (fileType.equalsIgnoreCase(".xls") || fileType.equalsIgnoreCase(".xlsx")) {
            response.setContentType("application/vnd.ms-excel");
        } else {
            response.setContentType("application/x-download");
        }
        String codeFileName = URLEncoder.encode(fileName, "UTF-8");
        codeFileName = codeFileName.replace("+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename=" + codeFileName);
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");
        response.setDateHeader("Expires", (System.currentTimeMillis() + 1000));
    }
    
    /**
     * 指定位置开始写入文件
     * @param tempFile  输入文件
     * @param outPath  输出文件的路径(路径+文件名)
     * @throws IOException
     */
    public static void randomAccessFile( String outPath,File tempFile) throws IOException{
        RandomAccessFile  raFile = null;
        BufferedInputStream inputStream=null;
        try{
            File dirFile = new File(outPath);
            //以读写的方式打开目标文件
            raFile = new RandomAccessFile(dirFile, "rw"); 
            raFile.seek(raFile.length());
            inputStream = new BufferedInputStream(new FileInputStream(tempFile));
            byte[] buf = new byte[1024];
            int length = 0;
            while ((length = inputStream.read(buf)) != -1) {
                raFile.write(buf, 0, length);
            }
        }catch(Exception e){
            throw new IOException(e.getMessage());
        }finally{
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (raFile != null) {
                    raFile.close();
                }
            }catch(Exception e){
                throw new IOException(e.getMessage());
            }
        }
    }
    
    /** 
     * 从网络Url中下载文件 
     * @param urlStr 
     * @param fileName 
     * @param savePath 
     * @throws IOException 
     */  
    public static void  downLoadFromUrl(String urlStr,String fileName,String savePath, HttpServletResponse response) throws IOException{  
        URL url = new URL(urlStr);    
       HttpURLConnection conn = (HttpURLConnection)url.openConnection();    
                //设置超时间为3秒  
        conn.setConnectTimeout(3*1000);  
        //防止屏蔽程序抓取而返回403错误  
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");  
        //得到输入流  
        InputStream inputStream = conn.getInputStream();    
        
//        InputStream inputStream = url.openStream();    
        if(StringUtils.isNotBlank(savePath)){
        	//获取自己数组  
        	byte[] getData = readInputStream(inputStream);      
        	//文件保存位置  
        	File saveDir = new File(savePath);  
        	if(!saveDir.exists()){  
        		saveDir.mkdir();  
        	}  
        	File file = new File(saveDir+File.separator+fileName);      
        	FileOutputStream fos = new FileOutputStream(file);       
        	fos.write(getData);   
        	if(fos!=null){  
        		fos.close();    
        	}  
        }
        if(response !=null){
        	OutputStream output = null;
        	int index = fileName.lastIndexOf(".");
        	String fileType = fileName.substring(index);
	        // 设置头信息
	        setResponse(fileName, fileType, response);
	        response.setHeader("Content-length", String.valueOf(inputStream.available()));
	        // 输出文件
	        output = response.getOutputStream();
	      //获取自己数组  
        	byte[] getData = readInputStream(inputStream);  
        	output.write(getData);
	     /* int length = 0;
		       byte[] buf = new byte[1024];
		       while ((length = inputStream.read(buf)) > 0) {
		    	   output.write(buf, 0, length);
		       }*/
		       output.flush();
		       output.close();
//	        IOUtils.copy(inputStream, output);
        }
        if(inputStream!=null){  
            inputStream.close();  
        }  
  
    }  
    /** 
     * 从输入流中获取字节数组 
     * @param inputStream 
     * @return 
     * @throws IOException 
     */  
    public static  byte[] readInputStream(InputStream inputStream) throws IOException {    
        byte[] buffer = new byte[1024];    
        int len = 0;    
        ByteArrayOutputStream bos = new ByteArrayOutputStream();    
        while((len = inputStream.read(buffer)) != -1) {    
            bos.write(buffer, 0, len);    
        }    
        bos.close();    
        return bos.toByteArray();    
    }    
    public static void  main(String[] args) throws URISyntaxException{
//    	downloadFile(destFileWithPath, fileName, response);
    	URI uri =new URI("http://7xr70a.com2.z0.glb.qiniucdn.com/3ab1482c-95c3-4195-a05e-2d935ecbe9ae.docx");
    	new File(uri);
    	System.out.println("====="+"http://7xr70a.com2.z0.glb.qiniucdn.com/3".replace("//", "////"));
    	try {
			downLoadFromUrl("http://7xr70a.com2.z0.glb.qiniucdn.com/3ab1482c-95c3-4195-a05e-2d935ecbe9ae.docx", "", "D:\\transnsg\\files",null);
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
//    	StringBuilder sb = new StringBuilder();
//    	for(int i=1; i<62583; i++){
//    		sb.append(i).append(",");
//    	}
//    	log.error(sb.toString());
	}
    
    
}
