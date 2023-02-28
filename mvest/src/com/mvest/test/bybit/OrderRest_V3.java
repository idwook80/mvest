package com.mvest.test.bybit;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;

public class OrderRest_V3 {
public static Logger LOG 			  =   LoggerFactory.getLogger(OrderRest_V3.class.getName());
	
    public final static String RECV_WINDOW 	  = "5000";	
	public static final String bybit_url  	  ="https://api.bybit.com";
	public static String getTimestamp() {
	   	return Long.toString(ZonedDateTime.now().toInstant().toEpochMilli());
	}
	 
	
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
     * POST: place an active linear perpetual order
     */
	public static String placeOrder(String api_key, String api_secret,
									String symbol, String order_type, String side,
									String position_idx,double price,double qty) throws NoSuchAlgorithmException, InvalidKeyException {
		String url = bybit_url + "/contract/v3/private/order/create";
		Map<String, Object> map = new TreeMap(
	        new Comparator<String>() {
	            @Override
	            // sort paramKey in A-Z
	            public int compare(String o1, String o2) {
	                return o1.compareTo(o2);
	        }
	    });
	    
	    map.put("category", "linear");
	    map.put("symbol", symbol);
	    map.put("side", side);
	    map.put("orderType", order_type);
	    map.put("qty", String.valueOf(qty));
	    map.put("price", String.valueOf(price));
	    map.put("positionIdx", position_idx);
	    map.put("timeInForce", "GoodTillCancel");
	    
	    String response = BybitClient_V3.post(url, map, api_key, api_secret, getTimestamp(), RECV_WINDOW);
	    if(response != null) {
	    	System.out.println(response);
	    	return response;
	    	/*return parsingPlaceOrder(response,map.get("symbol").toString()
	    								  ,map.get("side").toString()
	    								  ,map.get("price").toString()
	    								  ,map.get("qty").toString());*/
	    }
	    return null;
	}
    public static void parsingPlaceOrder(String str,String symbol, String side, String price, String qty) {
    	JsonParser parser = new JsonParser();
    	//System.out.println(str);
        JsonElement el =  parser.parse(str);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        LOG.info(gson.toJson(el));
        Map<String, Object> map  = gson.fromJson(str, Map.class);
        LinkedTreeMap result = (LinkedTreeMap)map.get("result");
        
        String order_id 	= result.get("orderId").toString();
        result.put("order_id", order_id);
        result.put("symbol", symbol);
        result.put("side", side);
        result.put("price", price);
        result.put("qty", qty);
        
       // Order order = new Order(result);
	 
        double ret_code = (Double)map.get("retCode");
        
       // if(ret_code == 0) return order;
       // return null;
    }
 
    public static String cancelOrder (String api_key,String api_secret,String symbol,String order_id) throws NoSuchAlgorithmException, InvalidKeyException {
    	String url = bybit_url + "/contract/v3/private/order/cancel";
        Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                return s1.compareTo(s2);
            }
        });
        map.put("category", "linear");
        map.put("orderId", order_id);
        map.put("symbol", symbol);
        
        String response = BybitClient_V3.post(url, map, api_key, api_secret, getTimestamp(), RECV_WINDOW);
        if(response != null) {
        	//parsingCancelOrder(response);
        	return response;
        }
        return null;
    }
    public static double parsingCancelOrder(String str) {
    	JsonParser parser = new JsonParser();
        JsonElement el =  parser.parse(str);
        //System.out.println(el);
        
        
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        System.out.println(gson.toJson(el));
        Map<String, Object> map  = gson.fromJson(str, Map.class);
        //LinkedTreeMap result = (LinkedTreeMap)map.get("result");
        
        double ret_code = (Double)map.get("retCode");
        
        return ret_code;
    }
    

    /**
     * POST: get the active order list
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     */
    public static void cancelAllOrder (String api_key,String api_secret,String symbol) throws NoSuchAlgorithmException, InvalidKeyException {
    	String url = bybit_url + "/contract/v3/private/order/cancel-all";
        Map<String, Object> map = new TreeMap<>(new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                return s1.compareTo(s2);
            }
        });
        map.put("category", "linear");
        map.put("symbol", symbol);
        
        String response = BybitClient_V3.post(url, map, api_key, api_secret, getTimestamp(), RECV_WINDOW);
        if(response != null) {
        	parsingCancelAllOrder(response);
        }
    }
    public static double parsingCancelAllOrder(String str) {
    	JsonParser parser = new JsonParser();
        JsonElement el =  parser.parse(str);
        //System.out.println(el);
        
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        System.out.println(gson.toJson(el));
        Map<String, Object> map  = gson.fromJson(str, Map.class);
        //LinkedTreeMap result = (LinkedTreeMap)map.get("result");
        
        double ret_code = (Double)map.get("retCode");
        
        return ret_code;
    }
}