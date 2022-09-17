package com.mvest.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;


public class WebConfig {
	public static final Logger LOG = Logger.getLogger(WebConfig.class);
	
	private static Properties property;
	private static boolean loaded = false;
	private static String ROOT_PATH;
	public static String WEB_INF = WebConfig.class.getResource("/").getPath().replace("/classes/", "");
	
	public static String CONFI_PATH 		= WEB_INF+"/config";
	public static String PROPERTY_FILE 		= CONFI_PATH+"/conf.properties";
	
	public static void load(String realPath){
		ROOT_PATH  = realPath;
		if(loaded) return;
		try {
			String host = InetAddress.getLocalHost().getHostAddress();
			LOG.debug("Address : "+host);
			
			if(System.getenv().get("USERNAME") != null && System.getenv().get("USERNAME").equals("idwook80")){
				CONFI_PATH 		=  WEB_INF+"/config/devel";
			}else if(System.getenv().get("HOSTNAME") != null && System.getenv().get("HOSTNAME").equals("nhisct.com")){
				CONFI_PATH 		=  WEB_INF+"/config/remo";
			}
			
			
			
			showSystemInfo();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		PROPERTY_FILE 		= CONFI_PATH+"/conf.properties";
		
		LOG.debug("WebConfig Load :"+PROPERTY_FILE);
		property = new Properties();
		FileInputStream fis;
		try {
			File f = new File(PROPERTY_FILE);
			fis = new FileInputStream(f);
	    	property.load(fis);
	    	property.put("WEB_INF", WebConfig.class.getResource("/").getPath().replace("/classes/", ""));
	    	loaded = true;
	    	System.out.println(property.get("CF_LOGO"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void showSystemInfo(){
		Map map = System.getenv();
		Iterator keys = map.keySet().iterator();
		LOG.debug("##### System Envirenment ######");
		while(keys.hasNext()){
			Object key = keys.next();
			Object value = map.get(key);
			LOG.debug("key : "+key+",value : "+value);
		}
		keys = System.getProperties().keySet().iterator();
		LOG.debug("##### System Properties ######");
		while(keys.hasNext()){
			Object key = keys.next();
			Object value = System.getProperty(key.toString());
			LOG.debug("key : "+key+",value : "+value);
		}
		
		
	}
	
	
	public static String get(String key){
		 return get(key,null);
	}
	public static String get(String key,String def){
		String value = "";
		if(!loaded) load(ROOT_PATH);
		 if(!property.containsKey(key)){
			  if(def != null && !def.equals("")){
				  value = def;
			  }else {
				  value = key;
			  }
		}else{
			 //if(key.equals("TIMEOUT")) return "60";
			  value = (String) property.get(key);
		}
		return value;
	}
	public static int getInt(String key){
		if(!loaded) load(ROOT_PATH);
		try{
			return Integer.parseInt(get(key));
		}catch(Exception e){
			return 0;
		}
	}
	public static void put(String key,String value){
		if(!loaded) load(ROOT_PATH);
		property.put(key, value);
	}
	public static void debug(Object msg){
		LOG.debug(msg);
	}
	public static void info(Object msg){
		LOG.info(msg);;
	}
	public static File getConfigFile(String fileName){
		File f = new File(CONFI_PATH+"/"+fileName);
		if(!f.exists()) return null;
		return f;
	}
	public static File getConfigDir(){
		File f = new File(CONFI_PATH);
		if(!f.exists()) return null;
		if(!f.isDirectory()) return null;
		return f;
	}
	public static void reload(){
		loaded = false;
		load(ROOT_PATH);
	}
}