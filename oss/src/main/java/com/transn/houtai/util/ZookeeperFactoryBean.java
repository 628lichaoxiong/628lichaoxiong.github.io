package com.transn.houtai.util;


import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.cache.NodeCache;
import org.apache.curator.framework.recipes.cache.NodeCacheListener;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;

public class ZookeeperFactoryBean implements FactoryBean<CuratorFramework>,InitializingBean,DisposableBean{
	 private CuratorFramework zkClient;//zk实体类
	 private String zkConnectionString;//链接地址
	 private String path;//zk节点
	 private ApplicationContextHelper context;
	 
	public ApplicationContextHelper getContext() {
		return context;
	}

	public void setContext(ApplicationContextHelper context) {
		this.context = context;
	}

	@Override
	public void destroy() throws Exception {
		zkClient.close();
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		//1000 是重试间隔时间基数，3 是重试次数
        RetryPolicy retryPolicy = new ExponentialBackoffRetry(1000, 3);
        zkClient =createWithOptions(zkConnectionString,retryPolicy,2000,10000);
        zkClient.start();
        registerListener(path,zkClient);
        
	}

	@Override
	public CuratorFramework getObject() throws Exception {
		return zkClient;
	}

	@Override
	public Class<?> getObjectType() {
		return zkClient.getClass();
	}

	@Override
	public boolean isSingleton() {
		return true;
	}
	//创建zk
	public CuratorFramework createWithOptions(String connectionString, RetryPolicy retryPolicy, 
			int connectionTimeoutMs, int sessionTimeoutMs){
		return CuratorFrameworkFactory.builder()
		                       .connectString(connectionString)
		                       .connectionTimeoutMs(connectionTimeoutMs)
		                       .retryPolicy(retryPolicy)
		                       .sessionTimeoutMs(sessionTimeoutMs)
		                       .build();
	}
	//注册监听器
	@SuppressWarnings({"resource"})
	public void registerListener(String path,CuratorFramework zkClient) {
		final NodeCache cache= new NodeCache(zkClient, path);
		try {
			cache.start(true);
		} catch (Exception e) {
			
		}
		
		cache.getListenable().addListener(new NodeCacheListener() {
			@Override
			public void nodeChanged() throws Exception {
				System.out.println("节点改变，新节点数据:"+new String(cache.getCurrentData().getData()));
				//String data=new String(cache.getCurrentData().getData());
				
				
			}
		});
		
	}
	public CuratorFramework getZkClient() {
		return zkClient;
	}

	public void setZkClient(CuratorFramework zkClient) {
		this.zkClient = zkClient;
	}

	public String getZkConnectionString() {
		return zkConnectionString;
	}

	public void setZkConnectionString(String zkConnectionString) {
		this.zkConnectionString = zkConnectionString;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
}
