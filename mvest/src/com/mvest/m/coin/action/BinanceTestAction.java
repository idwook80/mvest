package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.binance.client.RequestOptions;
import com.binance.client.SyncRequestClient;
import com.binance.client.model.market.MarkPrice;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mvest.m.company.Company;
import com.mvest.m.company.CompanyDao;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;
import org.apache.http.util.EntityUtils;

public class BinanceTestAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
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
			String jsonString = getPrice();
			
			  
			 Gson 			gson 					= 	new Gson();
	         String json = gson.toJson(jsonString);
			
			//addJsonObjectProperty("price", jsonString);
			//addJsonObjectProperty("price2", json);
			
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}

	public final static String API_KEY 		= "Gju5mxDvTQwRmIyfMT9BzqSlpomk0FSSpkzbQZAfXG1goB48j4bsRlydXontikUp";
	public final static String SECRET_KEY 	= "rCotzv08GlsISkVoujokuxsfAh3jeZedIQ6DsuKhNFwBfdsBrtU6WtB8KTm5Beq0";
	
	public String getPrice() {
	        RequestOptions options = new RequestOptions();
	        SyncRequestClient syncRequestClient = SyncRequestClient.create(API_KEY, SECRET_KEY,
	                options);
	        List<MarkPrice> list = syncRequestClient.getMarkPrice("BTCUSDT");
	        addJsonArray("prices", list);
	       return  list.toString();
    }
 

}