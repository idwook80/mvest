<%@page import="com.remo.web.util.TimeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		String CF_GOOGLE_CALENDAR_KEY = "AIzaSyD_HpuZtzbi5F9_uF0wiS82seJQSoiO0DA";
		String CF_GOOGLE_CALENDAR_AUTH_KEY="client_secret.json";
		String CF_GOOGLE_CALENDAR_ID="3ru741k1ln1inc7vtiis3htgic@group.calendar.google.com";
		String CAL_SRC = 
				"https://calendar.google.com/calendar/embed?color=%23BE6D00&amp;src="
				+ CF_GOOGLE_CALENDAR_ID
				+ "&ctz=Asia%2FTokyo&mode=month&dates="
				+ TimeUtil.getCurrentTime("yyyyMMdd") + "/" + TimeUtil.getCurrentTime("yyyyMMdd");
%>
<script type=text/javascript>

function googleF(){
	var divTag = $("#naver-news-area1");
	
	var param = "start=1";
	$.ajax({
		type 		: "post",
		url			: "<%=request.getContextPath() %>/remo/naver/news",
		data		: param,
		dataType	: "json",
		success		: function(data){
				if(data.status == 200){
					divTag.find("#nna-ul").html("");
					divTag.find("#time-area").html("");
					var news = data.news;
					var time = data.time;
					divTag.find("#time-area").text(time);
					for(var i=0; i<news.length; i++){
						var item = news[i];
						var link = item.link;
						var title = item.news;
						divTag.find("#nna-ul").append("<li><a href=\""+link+"\" target=\"_blank\"><blockquote><small>"+title+"</small></blockquote></a></li>")
					}
				}else {
					 
				}
		},
		error		: function(request,status,error){
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	});
}
$(document).ready(function($){
	setInterval(function() {
	}, 1000*60);
});
</script>
 
<div id="google-calendar1"> 
   <iframe src="<%=CAL_SRC %>" style="border: 0" width="100%" height="450" frameborder="0" scrolling="no"></iframe>

</div>
 