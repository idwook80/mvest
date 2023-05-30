package com.mvest.m.coin.action;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;

public class ExchangeScraping {
	public static double usd = 0.0;
	
	public static void main(String[] args) {
		new ExchangeScraping();
	}
	public ExchangeScraping(){
		try {
			usd = getUsd();
			System.out.println("현재 환율 : "+ usd +"원");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void scraping() {
		try {
			usd = getUsd();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static double getUsd() throws IOException {
		
		String addr = "https://finance.naver.com/marketindex/";
		String url = addr;
		//System.out.println(url);
		//Document doc = Jsoup.connect("https://www.naver.com/").get();
		Document doc = Jsoup.connect(url).get();
		
		Elements test1 =  doc.getElementsByClass("head usd");
		String usd = test1.get(0).getElementsByClass("value").text();
		
		System.out.println(usd.replace(",", ""));
		return  Double.valueOf(usd.replace(",", ""));
	}

}
