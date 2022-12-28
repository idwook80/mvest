package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.binance.client.RequestOptions;
import com.binance.client.SyncRequestClient;
import com.binance.client.model.trade.AccountInformation;
import com.binance.client.model.trade.Asset;
import com.binance.client.model.trade.Order;
import com.binance.client.model.trade.Position;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;
import com.mvest.model.ActionModel;
import com.mvest.test.bybit.OrderRest;
import com.mvest.test.bybit.WalletRest;
import com.mvest.test.bybit.db.BybitDao;
import com.mvest.test.bybit.model.BybitBalance;

public class BinanceBalanceAction extends ActionModel {
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
				getAccountInformation();
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
	
	public void getAccountInformation() {
		RequestOptions options = new RequestOptions();
		SyncRequestClient syncRequestClient = SyncRequestClient.create(API_KEY, SECRET_KEY, options);
			AccountInformation ai = syncRequestClient.getAccountInformation();
			
			List<Asset> assets = ai.getAssets();
			Asset usdt = null;
			for(Asset a : assets) {
				if(a.getAsset().equals("USDT")) {
					usdt = a;
				}
			}
			List<Position> positions = ai.getPositions();
			double equity = ai.getTotalMarginBalance().doubleValue();
			BybitBalance b = new BybitBalance();
			b.setEquity(equity);
			
			addJsonObject("Balance", b);
			addJsonObject("AccountInformation", ai);
			
			//return ai.getTotalMarginBalance().doubleValue();
		  
	}
	 
 

}