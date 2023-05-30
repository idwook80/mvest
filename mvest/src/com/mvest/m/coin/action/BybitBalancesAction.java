package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
import com.mvest.test.bybit.PositionRest;
import com.mvest.test.bybit.WalletRest;
import com.mvest.test.bybit.db.BybitWebUserDao;
import com.mvest.test.bybit.model.BybitWebUser;

public class BybitBalancesAction extends ActionModel {
	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		String id		= getParameter("id");
		String symbol   = getParameter("symbol");
		String coin		= getParameter("coin");
		
		if(isNull(symbol)) symbol = "BTCUSDT";
		if(isNull(coin))   coin   = "USDT";
		if(isNull(id)) return;
	 
		try {
			addJsonObjectProperty("exchange_usd", String.valueOf(ExchangeScraping.usd));
			 
			BybitWebUser user = (BybitWebUser) BybitWebUserDao.getInstace().select(id);
			
				if(!user.getId().startsWith("binance")) {
					try {
							JsonElement balance = getWalletBalanceJson(user.getApi_key(), user.getApi_secret(), coin);
							JsonElement positions = getPositions(user.getApi_key(), user.getApi_secret(),symbol);
							JsonElement kline 	= getKline_1(user.getApi_key(), user.getApi_secret(), symbol);
							user.balance 		= balance;
							user.positions		= positions;
							user.kline 			= kline;
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						setResultError(e.getMessage());
					}
				}else {
				}
				user.setApi_key("****");
				user.setApi_secret("****");
			
			addJsonObject("balance", user);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		outJsonObject();
  
		
	}
	public JsonElement getWalletBalanceJson(String api_key, String api_secret, String coin) {
		try {
			String str = WalletRest.getWalletBalanceJson(api_key, api_secret, coin);
			JsonParser parser 	= new JsonParser();
	        JsonElement el 		=  parser.parse(str);
	        
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        //return gson.toJson(el);
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        LinkedTreeMap result = (LinkedTreeMap)map.get("result");
	        LinkedTreeMap usdt  = (LinkedTreeMap) result.get("USDT");
	        //addJsonObject("response", el);
	        //addJsonObject("balances", el);
	        
	        return el;
	        
			//addJsonObjectProperty("balance", String.valueOf(balance));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public JsonElement getPositions(String api_key, String api_secret,String symbol) {
		try {
			String str = PositionRest.getActiveMyPosition(api_key, api_secret, symbol);
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        System.out.println(el);
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        ArrayList positions = (ArrayList)map.get("result");
	        //addJsonObject("positions", el);
	       // addJsonObject("positions", positions);
	       // System.out.println(el);
	        
	        return el;
	        
			//addJsonObjectProperty("balance", String.valueOf(balance));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public JsonElement getKline_1(String api_key, String api_secret, String symbol) {
		try {
			String str = KlineRest.getActiveKline_1(api_key, api_secret, symbol);
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        System.out.println(el);
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        
	        Map<String, Object> map  = gson.fromJson(gson.toJson(el), Map.class);
	        double ret_code = (Double)map.get("ret_code");
	       
	        ArrayList positions = (ArrayList)map.get("result");
	       // addJsonObject("kline_1", el);
	        
	        return el;
	        
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
 

}