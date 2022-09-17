package com.mvest.m.mystock.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.mvest.m.mystock.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;


public class MyStockListAction extends ActionModel {

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
			int total = MyStockDao.getInstace().getListCount(where);
			Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
			addJsonObject("vo", vo);
			
			List<MyStock> stocks = MyStockDao.getInstace().getList(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
			
			for(MyStock c : stocks){
				String co_code = c.getCo_code();
				try{
					Hashtable priceMap = getPrice(co_code);
					c.setMs_today((String)priceMap.get("to_price"));
					c.setMs_yesterday((String)priceMap.get("to_yesterday"));
					c.setMs_previous_exe();
					c.setTo_date((String)priceMap.get("to_date"));
				}catch(IOException e){
					
				}
				
			}
			
			if(stocks != null) addJsonArray("stocks", stocks);
			addJsonObjectProperty("total", String.valueOf(total));
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}
	public Hashtable getPrice(String co_code) throws IOException{
		// TODO Auto-generated method stub
		
		String url = "https://finance.naver.com/item/main.nhn?code="+co_code;
		System.out.println(url);
		//Document doc = Jsoup.connect("https://www.naver.com/").get();
		Document doc = Jsoup.connect(url).get();
		
		 
		String title = doc.title();
		Elements test1 =  doc.getElementsByClass("new_totalinfo");
		Elements test2 = test1.get(0).select("dl");
		Elements test3 = test2.get(0).getAllElements();
		Elements test4 = test3.get(0).getAllElements();
		
		Hashtable todayMap = new Hashtable();
		todayMap.put("co_code", co_code);
		
		for(Element el : test4){
			String line = el.select("dd").text();
			if(line.indexOf("현재가") > -1) {
				int limit = line.indexOf("전일대비");
				String today_price = line.substring(0, limit);
				today_price  = today_price.replace("현재가", "").replace(",", "").trim();
				todayMap.put("to_price", today_price);
			}else if(line.indexOf("전일가") > -1){
				String yesterday_price  = line.replace("전일가", "").replace(",", "").trim();
				todayMap.put("to_yesterday", yesterday_price);
			}
		}
		
		
		
		Elements wc =  doc.getElementsByClass("wrap_company");
		String co_name = wc.select("h2").first().text();
		System.out.println("name : "+co_name);
		Elements dc = wc.select("div.description");
		String code = dc.select("span.code").first().text();
		System.out.println("code : "+code);
		String date = dc.select("span#time").first().text();
		date = date.substring(0, date.indexOf("기준")).trim();
		
		
		
		todayMap.put("co_name", co_name);
		todayMap.put("to_date", date.replace(".", "-"));
		
		System.out.println("Date :"+ todayMap.get("to_date"));
		System.out.println("Code :"+ todayMap.get("co_code"));
		System.out.println("Name :"+ todayMap.get("co_name"));
		System.out.println("Price :"+ todayMap.get("to_price"));
		System.out.println("Yesterday :"+ todayMap.get("to_yesterday"));
		
		return todayMap;
		
		/**
		for(Element el : test3){
			System.out.print("LINE : ");
			System.out.println(el.html());  
			String keyword =  el.select("dd").get(3).text();
			System.out.println("key : "+keyword);
			int limit = keyword.indexOf("전일대비");
			String today_price = keyword.substring(0, limit);
			today_price  = today_price.replace("현재가", "").replace(",", "").trim();
			System.out.println("현재가격 : "+today_price);
			int price = Integer.parseInt(today_price);
			System.out.println("현재가격 : "+price);
			break;
		}
		**/
		
	}
 

}
