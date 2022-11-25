package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.binance.client.RequestOptions;
import com.binance.client.SyncRequestClient;
import com.binance.client.model.trade.Order;
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

public class BinanceCancelOrderAction extends ActionModel {
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
		
		
		String symbol				= getParameter("symbol", "BTCUSDT");
		String orderId 				= getParameter("orderId");
		
		String origClientOrderId 	= getParameter("origClientOrderId");
		
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
			if(API_KEY != null || isNull(orderId) || isNull(origClientOrderId)) {
				cancelOrder(symbol, Long.valueOf(orderId), origClientOrderId);
				setResultOk();
			}else {
				 setResultFail("Not Found User & Parameter Error");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}
	
	public void cancelOrder(String symbol, Long orderId, String origClientOrderId) {
		RequestOptions options = new RequestOptions();
		SyncRequestClient syncRequestClient = SyncRequestClient.create(API_KEY, SECRET_KEY, options);
		Order order = syncRequestClient.cancelOrder(symbol, orderId, origClientOrderId);
		addJsonObject("order", order);
		  
	}

}