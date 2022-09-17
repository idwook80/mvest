package com.mvest.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class ParamUtil {
	
	public static void setHeaders(Hashtable headers,HttpServletRequest request){
		Enumeration enu = request.getHeaderNames();
 		while(enu.hasMoreElements()){
 			String key = (String)enu.nextElement();
 			String value = request.getHeader(key);
 			headers.put(key, value);
 		}
 	}
	public static void setParameters(Hashtable params,HttpServletRequest request){
 		Enumeration enu = request.getParameterNames();
 		while(enu.hasMoreElements()){
 			String key = (String)enu.nextElement();
 			String value = request.getParameter(key);
 			params.put(key, value);
 		}
 	}
	public static String toString(Hashtable tb){
		String ret = "";
		if(tb == null || tb.isEmpty()) return ret;
		Enumeration enu = tb.keys();
		while(enu.hasMoreElements()){
			String key = (String) enu.nextElement();
			String value = (String) tb.get(key);
			ret += "["+key+","+value+"],";
		}
		return ret;
	}
	
	public  static String getParameter(HttpServletRequest request, String key){
		return getParameter(request, key, "");
	}
	public  static String getParameter(HttpServletRequest request, String key, String def){
		if(request == null) return def;
		return request.getParameter(key) != null ? request.getParameter(key) : def;
	}
	public static String getParameterUTF8(HttpServletRequest request, String key) throws UnsupportedEncodingException{
		return URLDecoder.decode(getParameter(request, key, "") , "UTF-8");
	}
	public static int getPageParameter(HttpServletRequest request,String key,int def){
		if(request.getParameter(key) == null) return def;
		try{
			return Integer.parseInt(request.getParameter(key).trim());
		}catch(Exception e){
			return def;
		}
	}
	public static String serialize(HttpServletRequest request){
		return serialize(request.getParameterMap());
	}
	public static String serialize(Map paramMap){
		String param = null;
		Iterator it = paramMap.keySet().iterator();
		while(it.hasNext()){
			String key = (String) it.next();
			Object valueObj = paramMap.get(key);
			if(valueObj instanceof String[]){
				String[] values = (String[]) valueObj;
				for(String value : values){
					if(param != null) param += "&";
					else param = "";
					param += key+"="+value;
				}
			}else {
				if(param != null) param += "&";
				else param = "";
				param += key+"="+valueObj;
			}
		
		}
		return param;
	}
	
	public static String serializeForm(HttpServletRequest request){
		return serializeForm(request.getParameterMap());
	}
	
	public static final String DEFAULT_PAGE_FORM_START_TAG 	= "<form id=\"pageForm\" name=\"pageForm\">";
	public static final String DEFAULT_PAGE_FORM_END_TAG 		= "</form>";
	public static String serializeForm(Map paramMap){
		String param = null;
		if(paramMap == null || paramMap.size() ==0) return "";
		Iterator it = paramMap.keySet().iterator();
		while(it.hasNext()){
			String key = (String) it.next();
			Object valueObj = paramMap.get(key);
			if(valueObj instanceof String[]){
				String[] values = (String[]) valueObj;
				for(String value : values){
					if(param != null ) param += "\n";
					else param = "";
					param += "<input type=\"hidden\" id=\""+key+"\" name=\""+key+"\" value=\""+value+"\" />";
				}
			}else {
				if(param != null ) param += "\n";
				else param = "";
				param += "<input type=\"hidden\" id=\""+key+"\" name=\""+key+"\" value=\""+valueObj+"\" />";
			}
		}
		return param;
	}
	protected static Gson 		gson 					= 	new Gson();
	public static JsonObject toJson(Object obj){
		String json = gson.toJson(obj);
		JsonParser parser = new JsonParser();
		return parser.parse(json).getAsJsonObject();
	}
	
}
