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
	 
		try {
			List<BybitWebUser> users = new ArrayList();
			
			if(isNotNull(id)) where = " id = '"+id +"'";
			users = (List) BybitWebUserDao.getInstace().getList(0,100,where, null);
			
			for(int i=0; i<users.size(); i++) {
				BybitWebUser user = users.get(i);
				try {
						JsonElement balance = getWalletBalanceJson(user.getApi_key(), user.getApi_secret());
						JsonElement positions = getPositions(user.getApi_key(), user.getApi_secret());
						JsonElement kline = getKline_1(user.getApi_key(), user.getApi_secret());
					user.balance = balance;
					user.positions = positions;
					user.kline 	= kline;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					setResultError(e.getMessage());
				}
			}
			addJsonArray("balances", users);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		outJsonObject();
  
		
	}
	public JsonElement getWalletBalanceJson(String api_key, String api_secret) {
		try {
			String str = WalletRest.getWalletBalanceJson(api_key, api_secret, "USDT");
			JsonParser parser = new JsonParser();
	        JsonElement el =  parser.parse(str);
	        
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
	public JsonElement getPositions(String api_key, String api_secret) {
		try {
			String str = PositionRest.getActiveMyPosition(api_key, api_secret, "BTCUSDT");
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
	
	public JsonElement getKline_1(String api_key, String api_secret) {
		try {
			String str = KlineRest.getActiveKline_1(api_key, api_secret, "BTCUSDT");
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