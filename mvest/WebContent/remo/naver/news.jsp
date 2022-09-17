<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.jsoup.*" %>
<%@ page language="java" import="org.jsoup.nodes.*" %>
<%@ page language="java" import="org.jsoup.select.*" %>

<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script> 
<script type=text/javascript>

function loadNaverNews1(){
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
						divTag.find("#nna-ul").append("<li><a href=\""+link+"\" target=\"_blank\"><small>"+title+"</small></a></li>")
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
	loadNaverNews1();
	setInterval(function() {
		loadNaverNews1();
	}, 1000*60);
});
</script>
<!-- <style>
.news-area ul li a {
  color: #000;
  background-color: #fff;
}

.news-area ul li a:hover {
  color: #555;
  background-color: #000;
}
</style> -->
<div id="naver-news-area1" class="news-area">
	<div id=""><strong><i id="time-area"></i></strong></div>
	<ul id="nna-ul" class="list-unstyled">
	</ul>
</div>
 