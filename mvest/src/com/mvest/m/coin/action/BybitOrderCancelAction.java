package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.mvest.model.ActionModel;
import com.mvest.test.bybit.OrderRest_V3;
import com.mvest.test.bybit.db.BybitDao;

public class BybitOrderCancelAction extends ActionModel {
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
		String id		= getParameter("user");
		String user		= getParameter("user");
		
		String order_id  =  getParameter("order_id");
		String symbol  =  getParameter("symbol");
		
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
				String orders = cancelOrder(symbol,order_id);
				setResultOk();
			}else {
				 setResultFail("Fail Order Cancel");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}
	public String cancelOrder(String symbol,String order_id) throws Exception{
		String str = OrderRest_V3.cancelOrder(API_KEY, SECRET_KEY, symbol, order_id);
		JsonParser parser = new JsonParser();
	    
        JsonElement el =  parser.parse(str);
        addJsonObject("cancel", el);
        return el.toString();
	}
 

}