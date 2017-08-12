/**
 * 创建于: 2012-12-22 下午1:50:28<br>
 * 所属项目:Transn SG
 * 文件名称:SystemConfig.java
 * 作者:barry.wang
 * 版权信息:Copyright (c) 2016~2016,  All Rights Reserved.
 */
package com.transn.houtai.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 类功能描述:读取系统配置文件system.properties
 * @author barry.wang
 * @version 2.0.0
 * @history 2017-03-13 barry.wang 创建 
 */
public class SystemConfig {
  private static volatile SystemConfig instance = null;

  private static final Logger logger = LoggerFactory.getLogger(SystemConfig.class);
  private static final String SYSTEM_SETTING_FILE = "system.properties";
  private static final String SYSTEM_ENCODING = "SYSTEM_ENCODING";
  private static String LOCALCCY = "LOCALCCY";
  private Properties properties;

  /**
   * 获取系统配置文件实例
   * @return
   */
  public static SystemConfig getInstance() {
    if (instance == null) {
      synchronized (SystemConfig.class) {
        if (instance == null) {
          instance = new SystemConfig();
          init();
        }
      }
    }
    return instance;
  }

  /**
   * 加载配置文件
   */
  private static void init() {
    InputStream inStream = null;
    Properties prop = new Properties();
    try {
      inStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(SYSTEM_SETTING_FILE);
      prop.load(inStream);
      getInstance().properties = prop;
    } catch (FileNotFoundException err) {
      logger.error("系统中不存在配置文件:"+SYSTEM_SETTING_FILE);
      try {
        if (inStream != null)
          inStream.close();
      }
      catch (IOException localIOException1){}
    }
    catch (IOException err){
      logger.error("读取配置文件时发生错误.");
      try {
        if (inStream != null)
          inStream.close();
      }
      catch (IOException localIOException2){}
    } finally {
      try{
        if (inStream != null)
          inStream.close();
      } catch (IOException localIOException3) {}
    }
  }

  /**
   * 根据key获取值
   * @param key
   * @return
   */
  public String getValue(String key){
	  return this.properties.getProperty(key);
  }

  /**
   * 获取系统编码
   * @return
   */
  public static String getSystemEncoding() {
	  return getInstance().getValue(SYSTEM_ENCODING);
  }

  public static String getLocalCcy() {
	  return getInstance().getValue(LOCALCCY);
  }
}