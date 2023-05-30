package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;
import com.mvest.model.ActionModel;
import com.mvest.test.bybit.KlineRest;
import com.mvest.test.bybit.OrderRest;
import com.mvest.test.bybit.PositionRest;
import com.mvest.test.bybit.WalletRest;
import com.mvest.test.bybit.db.BybitDao;

import io.contek.invoker.bybit.api.rest.user.GetOrder;
import io.vavr.API;

public class BybitOrdersAction extends ActionModel {
	public static String API_KEY 		= null;
	public static String SECRET_KEY 	= null;
	
	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		String id		= getParameter("id");
		String user		= getParameter("user");
		
		String bpage	= getParameter("bpage");
		String blimit	= getParameter("blimit");
		String symbol   = getParameter("symbol");
		
		if(isNull(symbol)) symbol = "BTCUSDT";
		try {
			Map userMap = (Map)BybitDao.getInstace().select(id);
			if(userMap != null) {
				System.out.println(userMap);
				String web_id		= (String) userMap.get("id");
				String user_id 		= (String) userMap.get("user_id");
				String api_key 		= (String) userMap.get("api_key");
				String api_secret 	= (String) userMap.get("api_secret");
				
				if(web_id.equals(id)) {
					API_KEY 	= api_key.trim();
					SECRET_KEY	= api_secret.trim();
				}
			
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
 
	     if(isNull(orderby)) orderby = null;
		
		try {
			if(API_KEY != null) {
				int p = 1;
				int l = 20;
				if(bpage != null) p = Integer.parseInt(bpage);
				if(blimit != null) l = Integer.parseInt(blimit);
				String orders = getRoders(p, l, symbol);
				setResultOk();
			}else {
				 setResultFail("Not Found User");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}
	public String getRoders(String symbol) throws Exception{
		return getRoders(1,50, symbol); 
	}
	public String getRoders(int page, int limit, String symbol) throws Exception{
		String str = OrderRest.getActiveOrder(API_KEY, SECRET_KEY , symbol, page , limit);
		JsonParser parser = new JsonParser();
	   // Gson gson = new GsonBuilder().setPrettyPrinting().create();
        //return gson.toJson(el);
	    
        JsonElement el =  parser.parse(str);
        addJsonObject("orders", el);
        return el.toString();
	}
	public String getWalletBalanceJson() {
		try {
			String str = WalletRest.getWalletBalanceJson(API_KEY, SECRET_KEY, "USDT");
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        //return gson.toJson(el);
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        LinkedTreeMap result = (LinkedTreeMap)map.get("result");
	        LinkedTreeMap usdt  = (LinkedTreeMap) result.get("USDT");
	        //addJsonObject("response", el);
	        addJsonObject("balances", el);
	        
	        //addJsonObject("usdt", usdt);
	        //System.out.println(el);
	        
	        return el.toString();
	        
			//addJsonObjectProperty("balance", String.valueOf(balance));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public String getPositions() {
		try {
			String str = PositionRest.getActiveMyPosition(API_KEY, SECRET_KEY, "BTCUSDT");
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        System.out.println(el);
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        ArrayList positions = (ArrayList)map.get("result");
	        addJsonObject("positions", el);
	       // addJsonObject("positions", positions);
	       // System.out.println(el);
	        
	        return el.toString();
	        
			//addJsonObjectProperty("balance", String.valueOf(balance));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public double getWalletBalance() {
		try {
			double balance =  WalletRest.getWalletBalance(API_KEY, SECRET_KEY, "USDT");
			addJsonObjectProperty("balance", String.valueOf(balance));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public String getKline_1() {
		try {
			String str = KlineRest.getActiveKline_1(API_KEY, SECRET_KEY, "BTCUSDT");
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        System.out.println(el);
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        ArrayList positions = (ArrayList)map.get("result");
	        addJsonObject("kline_1", el);
	        
	        return el.toString();
	        
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
 

}