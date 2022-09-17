package com.mvest.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;

import org.apache.log4j.Logger;

public class Lang {
	/*private static final Logger LOG = Logger.getLogger(Lang.class);
	
	private static boolean loaded  = false;
	
	public static String WEB_INF = Lang.class.getResource("/").getPath().replace("/classes/", "");
	public static String LANG_DIR = WEB_INF+"/lang";
	
	public static String PROPERTY_FILE = WEB_INF+"/lang/conf.properties";
	private static Hashtable<String,Properties> langTable;
	
	private static String  DEFAULT_LANG = "JA";
	
	public static void reload(){
		loaded = false;
		init();
	}
	public static void init(){
		if(loaded) return;
		
		LOG.debug("load lang dir : "+LANG_DIR);
		
		
		File dir = new File(LANG_DIR);
		if(!dir.isDirectory()) return ;
		
		File[] files = dir.listFiles();
		
		for(int i=0; i<files.length; i++){
			String fileName = files[i].getName();
			LOG.debug("fileName : "+fileName);
			if(fileName.startsWith("lang")){
				String locale = fileName.replace("lang_", "").replace(".properties", "");
				String[] keys = locale.split("_");
				if(keys != null){
					for(String key : keys){
						setLang(key.replace("_", "").toUpperCase(),files[i]);
					}
				}
			
			}
		}
		Enumeration enu = langTable.keys();
		while(enu.hasMoreElements()){
			LOG.debug(enu.nextElement().toString());
		}
		loaded = true;
	}
	public static void setLang(String key,File file){
		if(langTable == null ) langTable = new Hashtable();
		Properties property = new Properties();
		FileInputStream fis;
		try {
			fis = new FileInputStream(file);
	    	property.load(fis);
	    	langTable.put(key, property);
	    	
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}
	
	public static void setDefaultLang(String lang){
		DEFAULT_LANG = lang;
	}
	public static String get(String key){
		return get(DEFAULT_LANG,key);
	}
	public static String get(String lang,String key){
		if(!loaded) init();
		String locale = lang.toUpperCase();
		if(langTable.containsKey(locale)){
			Properties prop = langTable.get(locale);
			if(prop.containsKey(key)){
				return (String) prop.get(key);
			}
		}
		return key;
	}*/
	
	
	public String locale;
	Properties props;
	public Lang(String locale,Properties props){
		this.locale = locale;
		this.props = props;
	}
	public String get(String key){
		if(props.containsKey(key)){
			return (String) props.get(key);
		}else {
			return key;
		}
	}
	public String getLocale(){
		return locale;
	}
	public String getLocaleMoment(){
		switch(locale.toUpperCase()){
		case "EN" : return "en";
		case "JP" : return "ja";
		case "KO" : return "ko";
		}
		return "en";
	}
}
