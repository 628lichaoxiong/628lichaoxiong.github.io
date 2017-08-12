package com.transn.houtai.util;

import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.curator.framework.CuratorFramework;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class ZooKeeperPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	
	private CuratorFramework zk;

	public CuratorFramework getZk() {
		return zk;
	}

	public void setZk(CuratorFramework zk) {
		this.zk = zk;
	}





	@Override
	protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props)
			throws BeansException {
		
		 try {  
	            /*List<String> list= (List<String>) zk.getChildren().forPath("/configuration/mysql");
	            for(String key:list){  
	                String value = new String(zk.getData().forPath("/configuration/mysql/"+key));  
	                if(value!=null){  
	                    props.put(key,value);  
	                }  
	            }  */
	            /*List<String> list2= (List<String>) zk.getChildren().forPath("/configuration/config");
	            for(String key:list2){  
	                String value = new String(zk.getData().forPath("/configuration/config/"+key));  
	                if(!StringUtils.isBlank(value)){  
	                    props.put(key,value);  
	                }  
	            }  */
	            
	            List<String> list3= (List<String>) zk.getChildren().forPath("/configuration/redis");
	            for(String key:list3){  
	                String value = new String(zk.getData().forPath("/configuration/redis/"+key));  
	                if(value!=null){  
	                    props.put(key,value);  
	                }  
	            } 
	            
//	            List<String> list4= (List<String>) zk.getChildren().forPath("/configuration/rabbitmq");
//	            for(String key:list4){  
//	                String value = new String(zk.getData().forPath("/configuration/rabbitmq/"+key));  
//	                if(value!=null){  
//	                    props.put(key,value);  
//	                }  
//	            }  
	            
	            List<String> list5= (List<String>) zk.getChildren().forPath("/configuration/dubbo");
	            for(String key:list5){  
	                String value = new String(zk.getData().forPath("/configuration/dubbo/"+key));  
	                if(value!=null){  
	                    props.put(key,value);  
	                }  
	            }  
	        } catch (Exception e) {  
	        }  
	        super.processProperties(beanFactoryToProcess, props);
	}
	
}
