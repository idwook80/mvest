package com.mvest.m.lottery.action;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.mvest.m.lottery.Lottery;
import com.mvest.m.lottery.LotteryDao;

import sun.util.calendar.BaseCalendar;

public class LotteryWin {
	public static void main(String[] args) {
		new LotteryWin();
	}
	public LotteryWin() {
		checkDate("2022-01-01");
	}
	public boolean checkDate(String str) {
		
		
		String[] sep = str.split("-");
		Calendar last = Calendar.getInstance();
		Calendar next = Calendar.getInstance();
		Calendar cal = Calendar.getInstance();
		
		last.set(Calendar.YEAR, Integer.valueOf(sep[0]));
		last.set(Calendar.MONTH, Integer.valueOf(sep[1])-1);
		last.set(Calendar.DAY_OF_MONTH, Integer.valueOf(sep[2]));
		last.set(Calendar.HOUR_OF_DAY, 20);
		last.set(Calendar.MINUTE,50);
		last.set(Calendar.SECOND, 0);
		next.set(Calendar.HOUR_OF_DAY, 20);
		next.set(Calendar.MINUTE,50);
		next.set(Calendar.SECOND, 0);
		
		
		System.out.println(str);
		System.out.println("현재:"+ cal.getTime());
		System.out.println("다음:"+ next.getTime());
		System.out.println("마지막:"+ last.getTime());
	
		System.out.println("현재 vs 다음  "+ cal.compareTo(next));
		System.out.println("현재 vs 마지막 "+cal.compareTo(last));
		
		
		int yyyy = cal.get(Calendar.YEAR);
		int mm 	 = cal.get(Calendar.MONTH)+1;
		int dd   = cal.get(Calendar.DAY_OF_MONTH);
		
		String checkDate = yyyy + "-"+ (mm <10 ? "0"+mm : mm) + "-"+(dd < 10 ? "0"+dd : dd);	
		
		
		int day = cal.get(Calendar.DAY_OF_WEEK);
		last.set(Calendar.HOUR_OF_DAY, 20);
		
		if(day== Calendar.SATURDAY && cal.compareTo(last) > 0 ) {
			return  cal.compareTo(next) > 0;
		}else {
			//cal.add(Calendar.DATE, day * -1);
		}
		
		System.out.println(checkDate + " , " + str + "  : " + checkDate.equals(str));
		return checkDate.equals(str);
		
	}
	public Lottery getLastWin() throws IOException {
		// TODO Auto-generated method stub
		System.out.println("요청!!!");
		String addr = "https://www.dhlottery.co.kr/gameResult.do?method=byWin&wiselog=C_A_1_1";
		String url = addr;
		System.out.println(url);
		Document doc = Jsoup.connect(url).get();
		
		 //System.out.println(doc.html());
		 Lottery win = new Lottery();
		 
		 
		String title = doc.title();
		Elements test1 =  doc.getElementsByClass("win_result");
		
		Elements test2 = test1.get(0).select("strong");
		String rr = test2.get(0).text().replace("회", "");
		
		String date_desc = test1.get(0).select(".desc").text();
		
		
		//System.out.println("title : "+ title);
		//System.out.println("test1 : "+ test1.html());
		//System.out.println("### bonus ###");
		
		//System.out.println(date_desc);
		String num_bonus = test1.get(0).select(".bonus").select(".ball_645").text();
		
		//System.out.println("Round : " + rr);
		
		Elements wins = test1.select(".ball_645");
		
		win.setDate(getDateFormatter(date_desc));
		win.setRound(rr);
		win.setN1(wins.get(0).text());
		win.setN2(wins.get(1).text());
		win.setN3(wins.get(2).text());
		win.setN4(wins.get(3).text());
		win.setN5(wins.get(4).text());
		win.setN6(wins.get(5).text());
		
		//System.out.println("Bonus  : " + num_bonus);
		win.setB1(num_bonus);
		
		try {
			Lottery check = (Lottery) LotteryDao.getInstace().select(win.getRound());
			if(check == null) LotteryDao.getInstace().insert(win);
		}catch(Exception e) {
			
		}
		
		return win;
	}
	
	public String getDateFormatter(String str) {
		String cur_date = str.replace("(", "").replace(")","").replace("추첨", "").trim();
		String yyyy  = cur_date.substring(0,4);
		String month = cur_date.substring(cur_date.indexOf("년")+1, cur_date.indexOf("월")).trim();
		String day = cur_date.substring(cur_date.indexOf("월")+1, cur_date.indexOf("일")).trim();
		
		return yyyy +  "-" + month + "-" + day +"일";
		
	}
	
	
	public Hashtable getWin(String round) throws IOException{
		// TODO Auto-generated method stub
		
		String addr = "https://www.dhlottery.co.kr/gameResult.do?method=byWin&wiselog=C_A_1_1";
		String url = addr;
		System.out.println(url);
		//Document doc = Jsoup.connect("https://www.naver.com/").get();
		Document doc = Jsoup.connect(url).get();
		
		 //System.out.println(doc.html());
		 
		 
		String title = doc.title();
		Elements test1 =  doc.getElementsByClass("win_result");
		
		int idx = 0;
		
		Elements test2 = test1.get(0).select("strong");
		String rr = test2.get(0).text().replace("회", "");
		
		String date_desc = test1.get(0).select(".desc").text();
		
		
		System.out.println("title : "+ title);
		System.out.println("test1 : "+ test1.html());
		System.out.println("### bonus ###");
		
		System.out.println(date_desc);

		String num_bonus = test1.get(0).select(".bonus").select(".ball_645").text();
		
		System.out.println("Round : " + rr);
		
		Elements wins = test1.select(".ball_645");
		for(Element w1 : wins) {
			System.out.println("No."+(++idx) + " : " + w1.text());
		}
		
		System.out.println("Bonus  : " + num_bonus);
		
		Elements test3 = test2.get(0).getElementsByClass("ball_645");
		//Elements test4 = test3.get(0).getAllElements();
		
		Hashtable todayMap = new Hashtable();
		todayMap.put("round", round);
		
		
		for(Element el : test3){
			System.out.println("LIne : "+el.text());
			
			String line = el.select("ball_645").text();
			
			System.out.println(line);
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
