<%@page import="com.remo.web.util.TimeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- <link href="<%=request.getContextPath() %>/remo/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/remo/css/my.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script> 
<script src="<%=request.getContextPath() %>/remo/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script>  --%>


<%
		String CF_GOOGLE_MAP_KEY="AIzaSyDaI6uHcZa1qC39MrHFgFYonn4bLO11mDg";
		String MAP_SRC =
				"https://maps.googleapis.com/maps/api/js?key="
				+ CF_GOOGLE_MAP_KEY
				+ "&callback=myMap";
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
var map;
var LAT = 37.6425437;
var LON = 127.2373717;
function initialize(){
	var myCenter = new google.maps.LatLng(LAT,LON);
	map  = new google.maps.Map(document.getElementById("google-map"),{zoom:16,center:myCenter});
}
$(document).ready(function($){
/* 	var myCenter = new google.maps.LatLng(35.6463809,139.6957242);
	map  = new google.maps.Map(document.getElementById("google-map"),{zoom:12,center:myCenter}); */
	//google.maps.event.addDomListener(window, 'load', initialize);
	initialize();
});
</script>
<div id="google-map" style="width:100%;min-height:450px;">
  <script src="<%=MAP_SRC %>"></script>
</div>
 