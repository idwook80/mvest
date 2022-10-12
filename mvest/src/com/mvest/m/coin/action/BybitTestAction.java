package com.mvest.m.coin.action;

import java.io.IOException;
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
import com.mvest.test.bybit.WalletRest;

public class BybitTestAction extends ActionModel {
	public static String API_KEY 		= "HKVOISQYXKYOECTEYG";
	public static String SECRET_KEY 	= "DZSHAUZQCOGFZHNFGPGQHCSVHGNVXOXIZROH";
	
	public final static String BYBIT_MAIN_KEY="F05n0T6G79ivD4UZKW";
	public final static String BYBIT_MAIN_SECRET="QhYN61Cn9tKSIrfHxSMo3me9C6cfZrFLHEmv";
	public final static String BYBIT_SUB_KEY="HKVOISQYXKYOECTEYG";
	public final static String BYBIT_SUB_SECRET="DZSHAUZQCOGFZHNFGPGQHCSVHGNVXOXIZROH";
	
	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		String user		= getParameter("user");
		
		
		System.out.println(user);
		if(user.toUpperCase().equals("SUB")) {
			API_KEY = BYBIT_SUB_KEY;
			SECRET_KEY = BYBIT_SUB_SECRET;
		}else if(user.toUpperCase().equals("MAIN")) {
			API_KEY = BYBIT_MAIN_KEY;
			SECRET_KEY = BYBIT_MAIN_SECRET;
		}
	/*	if(isNotNull(orderby)) {
			orderby = "A."+orderby;
		}else {
			orderby  = "A.si_id";
		}
		if(isNotNull(sort)){
			orderby += " "+ sort;
		}else {
			orderby += " ASC";
		}*/
			if(isNull(orderby)) orderby = null;
		
		try {
			String str = getWalletBalanceJson();
	         addJsonObjectProperty("balance", str);
			/* Gson 			gson 					= 	new Gson();
	         String json = gson.toJson(jsonString);
			//addJsonObjectProperty("price", jsonString);
			//addJsonObjectProperty("price2", json);
*/			
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
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
	        addJsonObject("response", el);
	        addJsonObject("usdt", usdt);
	        System.out.println(el);
	        
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
 

}