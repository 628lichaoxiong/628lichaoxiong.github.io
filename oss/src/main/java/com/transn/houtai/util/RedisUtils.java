package com.transn.houtai.util;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RedisUtils {
	private static JedisPool pool;
	private static final Logger log = LoggerFactory.getLogger(RedisUtils.class);
	public  void setPool(JedisPool pool) {
		RedisUtils.pool = pool;
	}
	public  JedisPool getPool() {
		return pool;
	}
	public static String get(String key){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			return jedis.get(key);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
			return "";
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	
	public static void set(String key, int seconds, String value){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			jedis.setex(key, seconds, value);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	
	public static void set(String key, String value){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			jedis.set(key, value);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	
	public static boolean exists(String key){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			return jedis.exists(key);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
			return false;
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	
	public static void del(String key){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			jedis.del(key);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	public static void lpush(String key,String[] value ){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			jedis.lpush(key, value);
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	public static List<String> lrange(String key){
		Jedis jedis = null;
		try{
			jedis = pool.getResource();
			List<String> values = jedis.lrange(key, 0, -1);//查询所有的
			return values;
		}catch (Exception e) {
			log.error("获取redis出错："+e.getMessage());
			return new ArrayList<String>();
		}finally{
			if(jedis != null){
				pool.returnResource(jedis);
			}
		}
	}
	/**
	 * 获取一级菜单名称
	 * @param args
	 */
	public static String getFirstMenuName(String menuFirstId){
		String menName="";
		menName =RedisUtils.get(RedisValue.SysFirstMenusName+RedisValue.SplitIdAndName+menuFirstId);
		return menName;
	}
	public static void main(String[] args) {
			
	}
}
