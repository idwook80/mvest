package com.mvest.m.api.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.mvest.model.ActionModel;


public class NaverRankAction extends ActionModel{

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		Document doc = Jsoup.connect("https://www.naver.com/").get();
		String title = doc.title();
		/* Element rtk = doc.getElementById("rtk"); */
		Element rtk = doc.getElementById("ah_roll_area PM_CL_realtimeKeyword_rolling");
		/* Elements test= doc.getElementsByClass("ah_list PM_CL_realtimeKeyword_list_base"); */
		/* Elements test= doc.select("div").select(".ah_list PM_CL_realtimeKeyword_list_base").select("div").select(".ah_l"); */
		Elements test= doc.select("div.ah_list.PM_CL_realtimeKeyword_list_base").select("ul.ah_l").select("li");
		String time = doc.select("div.ah_list.PM_CL_realtimeKeyword_list_base").select("p.ah_time").first().text().replace("기준 도움말", "");
		
		/* if(rtk != null){
			String rtkHtml = rtk.html();
			System.out.println(rtkHtml);
		} */
		int start = 1;
		String startParam = request.getParameter("start") != null ?  request.getParameter("start")  : "1";
		try{
		start = Integer.parseInt(startParam);
		}catch(Exception e){
			start = 1;
		}
		List ranks = new ArrayList();
		if(test != null){
			int count = 1;
			for(Element el : test){
				/* System.out.print("LINE : ");
				System.out.println(el.html()); */
				String keyword =  el.select("span.ah_k").text();
				String no = el.select("span.ah_r").first().text();
				String link = el.select("a").attr("href");
				if(start <= count){
					ranks.add(new RankModel(no,link,keyword));
				}
				if(count >= 9+start ) break;
				count++;
			}
		}
		ResultDataModel model = new ResultDataModel();
		model.time =time;
		model.ranks = ranks;
		/*setCode(JsonDataModel.CODE_OK);
		setData(model);*/
	}
	/*public void testValues(String value){
		String [] types = {"UTF-8","EUC-KR","ISO-8859-1"};
		System.out.println("기본 글자 : " + value);

		String encode_result = null;

		//TEST1//

		System.out.println("------TEST 1------");

		try {

			for(String type : types){

			encode_result = URLEncoder.encode(value, type);

			System.out.println("encode with " + type +" : "+ URLEncoder.encode(value, type));

				for(String type2 : types){

					System.out.println("decode with " + type2 +" : "+ URLDecoder.decode(value, type2));		

				}
				System.out.println("--------------------");		

			}	

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		}
	}*/
	class ResultDataModel {
		String time;
		Object ranks;
	}
	class RankModel {
		String no;
		String link;
		String keyword;
		public RankModel(String no,String link,String keyword){
			this.no = no;
			this.link = link;
			this.keyword = keyword;
		}
		
		 
	}
}
