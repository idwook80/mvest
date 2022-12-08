package com.mvest.test.bybit;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;

public class OrderRest {
	 public static final String bybit_url  ="https://api.bybit.com";
	 
	  public final static String RECV_WINDOW 	  = "10000";
	 
	 /* * GET: get the active order list
	     * @throws NoSuchAlgorithmException
	     * @throws InvalidKeyException
	     * 
	     * Side=Buy,Reduce(false) 	: Open Long
	     * Side=Buy,Reduce(true) 	: Close Short
	     * Side=Sell,Reduce(true) 	: Close Long
	     * Side=Sell,Reduce(false) 	: Open Short
	     * 
	     */
	    public static String getActiveOrder(String api_key, String api_secret,String symbol,int page, int limit) throws NoSuchAlgorithmException, InvalidKeyException {
	        Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
	            @Override
	            public int compare(String s1, String s2) {
	                return s1.compareTo(s2);
	            }
	        });
	        String url = bybit_url + "/private/linear/order/list";
	        
	        map.put("api_key", api_key);
	        map.put("timestamp", Long.toString(ZonedDateTime.now().toInstant().toEpochMilli()));
	        map.put("symbol", symbol);
	        map.put("page", page);
	        map.put("limit", limit);
	        //map.put("order_status", "Created,New,Filled,Cancelled");
	        map.put("order_status", "Created,New");
	        String signature = BybitClient.genSign(api_secret,map);
	        map.put("sign", signature);
	        
	
	        String response = BybitClient.get(url, map);
	        if(response != null) {
	        
	        }
	        return response;
	        
	    }

	    /**
	     * POST: get the active order list
	     * @throws NoSuchAlgorithmException
	     * @throws InvalidKeyException
	     */
	    public static void cancelAllOrder (String api_key,String api_secret,String symbol) throws NoSuchAlgorithmException, InvalidKeyException {
	    	String url = bybit_url + "/private/linear/order/cancel-all";
	        Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
	            @Override
	            public int compare(String s1, String s2) {
	                return s1.compareTo(s2);
	            }
	        });
	        String tt = Long.toString(ZonedDateTime.now().toInstant().toEpochMilli());
	        map.put("api_key", api_key);
	        map.put("timestamp", tt);
	        map.put("symbol", "BTCUSDT");
	        String signature = BybitClient.genSign(api_secret,map);
	        map.put("sign", signature);
	        
	        String response = BybitClient.post(url, map);
	        if(response != null) {
	        	parsing(response);
	        }
	        
	    }
	    public static String cancelOrder (String api_key,String api_secret,String symbol,String order_id) throws NoSuchAlgorithmException, InvalidKeyException {
	    	String url = bybit_url + "/private/linear/order/cancel";
	        Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
	            @Override
	            public int compare(String s1, String s2) {
	                return s1.compareTo(s2);
	            }
	        });
	        String tt = Long.toString(ZonedDateTime.now().toInstant().toEpochMilli());
	        map.put("api_key", api_key);
	        map.put("timestamp", tt);
	        map.put("order_id", order_id);
	        map.put("symbol", symbol);
	        String signature = BybitClient.genSign(api_secret,map);
	        map.put("sign", signature);
	        
	        String response = BybitClient.post(url, map);
	        return response;
	    }
	    public static double parsing(String str) {
	    	JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        //System.out.println(el);
	        
	        
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        System.out.println(gson.toJson(el));
	        Map<String, Object> map  = gson.fromJson(str, Map.class);
	        //LinkedTreeMap result = (LinkedTreeMap)map.get("result");
	        
	        double ret_code = (Double)map.get("ret_code");
	        
	        return ret_code;
	        
	    }
	    
	    /**
	     * POST: place an active linear perpetual order
	     */
	    public static String createOrder(String api_key, String api_secret,
	    						String symbol, String order_type,
	    						String side, String position_idx, 
	    						double price,double qty) throws NoSuchAlgorithmException, InvalidKeyException {
	    	String url = bybit_url + "/private/linear/order/create";
	    	 Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
	            @Override
	            public int compare(String s1, String s2) {
	                return s1.compareTo(s2);
	            }
	        });
	    
	        String tt = Long.toString(ZonedDateTime.now().toInstant().toEpochMilli());
	        map.put("api_key", api_key);
	        map.put("timestamp", tt);
	        map.put("side", side);
	        map.put("position_idx",position_idx);
	        map.put("symbol", symbol);
	        map.put("order_type", order_type);
	        map.put("qty", qty);
	        map.put("price", price);
	        map.put("time_in_force", "GoodTillCancel");
	        //map.put("take_profit", "20000");
	        //map.put("stop_loss", "18000");
	        map.put("reduce_only", false);
	        map.put("close_on_trigger", false);
	        map.put("recv_window", RECV_WINDOW);
	        String signature = BybitClient.genSign(api_secret,map);
	        map.put("sign", signature);
	        System.out.println(map);
	        String response = BybitClient.post(url, map);
	        return response;
	       /* if(response != null) {
	        	  parsingOrder(response);
	        }*/
	    }
	    
	    public static void parsingOrder(String str) {
	    	JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        System.out.println(el);
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        Map<String, Object> map  = gson.fromJson(str, Map.class);
	        LinkedTreeMap result = (LinkedTreeMap)map.get("result");
	        
	        double ret_code = (Double)map.get("ret_code");
	        System.out.println(map);
	        System.out.println(ret_code);
	        
	        
	    }
}