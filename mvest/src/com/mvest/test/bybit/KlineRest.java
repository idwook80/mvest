package com.mvest.test.bybit;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;

public class KlineRest {

	 public static final String bybit_url  ="https://api.bybit.com";
	 
	  /**
	     * GET: get the active order list
	     * @throws NoSuchAlgorithmException
	     * @throws InvalidKeyException
	     */
	    public static String getActiveKline_1(String api_key, String secret,String symbol) throws NoSuchAlgorithmException, InvalidKeyException {
	    	  Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
	              @Override
	              public int compare(String s1, String s2) {
	                  return s1.compareTo(s2);
	              }
	          });
	    	  
	    	String TIMESTAMP_SEC = Long.toString((ZonedDateTime.now().toInstant().toEpochMilli() / 1000) - ( 60*1 ));
	        map.put("api_key", api_key);
	        map.put("timestamp", Long.toString(ZonedDateTime.now().toInstant().toEpochMilli()));
	        map.put("symbol", symbol);
	        map.put("interval", "1");
	        map.put("from", TIMESTAMP_SEC);
	        map.put("limit", "1");
	        String signature = BybitClient.genSign(secret,map);
	        map.put("sign", signature);
	        
	        String url = "https://api.bybit.com/public/linear/kline";
	        String response = BybitClient.get(url, map);
	        /*if(response != null) {
	        	lineParsing(response);;
	        }*/
	        return response;
	    }
}
