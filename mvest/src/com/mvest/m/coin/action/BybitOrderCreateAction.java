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

public class BybitOrderCreateAction extends ActionModel {
	public static String API_KEY 		= null;
	public static String SECRET_KEY 	= null;
	public final static String SIDE_BUY		  = "Buy";			// LongOpen , ShortClose
    public final static String SIDE_SELL	  = "Sell";			// LongClose, ShortOpen	
    
    public final static String POSITION_IDX_BOTH  = "0";
    public final static String POSITION_IDX_LONG  = "1";			// Long
    public final static String POSITION_IDX_SHORT = "2";			// Short
    /**
      openLong(buy,long(1) Buy + 1 = open long
      openShort(sell,short(2) Sell + 2 = open short
      closeLong(sell,long(1) Sell + 1 = close long
      closeShort(buy,short(2) Buy + 2 = close short
     */
	
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
		
		String symbol  		=  getParameter("symbol");
		String side			= getParameter("side");
		String position_idx = getParameter("position_idx");
		String order_type 	= getParameter("order_type");
		double price	  	= Double.valueOf(getParameter("price"));
		double qty 		  	= Double.valueOf(getParameter("qty"));
		
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
				String orders = createOrder(symbol,order_type, side, position_idx, price, qty);
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
	public String createOrder(String symbol,String order_type, String side, String position_idx, double price, double qty) throws Exception{
		System.out.println(symbol+"," + order_type + "," + side+","+position_idx+","+price+","+qty);
		//String str = OrderRest.createOrder(API_KEY, SECRET_KEY, symbol, order_type, side, position_idx, price, qty);
		
		String str = OrderRest_V3.placeOrder(API_KEY, SECRET_KEY, symbol, order_type, side, position_idx, price, qty);
		
		JsonParser parser = new JsonParser();
        JsonElement el =  parser.parse(str);
        addJsonObject("response", el);
        return el.toString();
	}
 

}