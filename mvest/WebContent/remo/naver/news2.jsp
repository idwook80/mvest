<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.jsoup.*" %>
<%@ page language="java" import="org.jsoup.nodes.*" %>
<%@ page language="java" import="org.jsoup.select.*" %>

<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script> 
<script type=text/javascript>

function loadImgNews1(){
	var divTag = $("#naver-news-img1");
	divTag.find("#time-area").text('');
	divTag.find("#total-area").text("");
	divTag.find("#nna-list").html('');
	divTag.find("#nna1-ul").html("");
	
	var param = "start=1";
	$.ajax({
		type 		: "post",
		url			: "<%=request.getContextPath() %>/remo/naver/news2",
		data		: param,
		dataType	: "json",
		success		: function(data){
				if(data.status == 200){
					divTag.find("#nna-list").html("");
					divTag.find("#nna1-ul").html("");
					divTag.find("#time-area").html("");
					divTag.find("#total-area").html("");
					var news = data.news;
					var time = data.time;
					var total = data.total;
					divTag.find("#time-area").text(time);
					divTag.find("#total-area").text("("+total+")");
					for(var i=0; i<news.length; i++){
						var item = news[i];
						var link = item.link;
						var title = item.news;
						var img = item.img;
						if(title != '' && link != ''){
							var html = "";
							if(i == 0) html += "<div class=\"item active\">";
							else  html += "<div class=\"item\">";
							html += getHtml(link,title,img);
							html += "</div>";
							divTag.find("#nna-list").append(html);
							divTag.find("#nna1-ul").append("<li><a href=\""+link+"\" target=\"_blank\"><small>"+title+"</small></a></li>");
							
						} 
					}
					/* $("#news-carousel1").carousel(); */
					
				}else {
					 
				}
		},
		error		: function(request,status,error){
			//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	});
}
function getHtml(link,title,img){
	var html = "";
	html +=  "<div class=\"thumbnail\">";
	html +=  " <a href=\""+link+"\" target=\"_blank\">";
	html +=  " <img src=\""+img+"\" alt=\"\" width=\"150\" height=\"102\" onError=\"javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;\"><br>";
   	html +=  " <p class=\"text-center\"><strong>"+title+"</strong></p>";
   	html +=  "</a></div>";
	
	/* var html = "<a href=\""+link+"\" target=\"_blank\">";
	html += " <img src=\""+img+"\" alt=\"\" width=\"150\" height=\"102\" onError=\"javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;\"><br>";
	html += "<em>"+title+"</em></a>"; */
	return html;
}
$(document).ready(function($){
 	loadImgNews1();  
  	setInterval(function() {
  		loadImgNews1();
	}, 1000*60*10); 
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
<div id="naver-news-img1" class="news-area" >
	<div class="row">
		<div class="col-xs-8 col-md-8"><strong><i id="time-area"></i></strong><i id="total-area"></i></div>
		<div class="col-xs-4 col-md-4 text-right"><a href="javascript:loadImgNews1();"><span class="glyphicon glyphicon-refresh"></span></a></div>
	</div>
	<div id="news-carousel1" class="carousel slide text-center" data-ride="carousel" data-interval="5000" style="width:100%;height:200px;"> <!--  data-ride="carousel" -->
     	  <!-- Wrapper for slides -->
		<!--  <ol class="carousel-indicators">
		    <li data-target="#news-carousel1" data-slide-to="0" class="active"></li>
		    <li data-target="#news-carousel1" data-slide-to="1"></li>
		    <li data-target="#news-carousel1" data-slide-to="2"></li>
		 </ol> -->
	    <div id="nna-list" class="carousel-inner" role="listbox">
	    	<!-- <div class="item active" ><div class="thumbnail"> <a href="https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=104&oid=421&aid=0003790697" target="_blank"> <img src="https://imgnews.pstatic.net/image/upload/item/2019/01/17/143102398_7.jpg?type=f270_166" alt="" width="150" height="102" onError="javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;"><br> <p><strong>셧다운 26일째…돈 안줘도 연방공무원 일하는 이유는?</strong></p></a></div></div>
	    	<div class="item"><div class="thumbnail"> <a href="https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=101&oid=055&aid=0000704327" target="_blank"> <img src="https://imgnews.pstatic.net/image/upload/item/2019/01/17/141013764_Untitled-1.jpg?type=f270_166" alt="" width="150" height="102" onError="javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;"><br> <p><strong>훼손된 지폐 얼마나 남아 있어야 교환 가능할까</strong></p></a></div></div>
	    	<div class="item"><div class="thumbnail"> <a href="https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=104&oid=003&aid=0009016538" target="_blank"> <img src="https://imgnews.pstatic.net/image/upload/item/2019/01/17/115316969_6.jpg?type=f270_166" alt="" width="150" height="102" onError="javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;"><br> <p><strong>中이 달에서 틔운 목화씨 싹 얼어 죽어…영하 170도 밤기온 때문</strong></p></a></div></div>
	    	<div class="item"><div class="thumbnail"> <a href="https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=102&oid=028&aid=0002439979" target="_blank"> <img src="https://imgnews.pstatic.net/image/upload/item/2019/01/17/105318285_3.jpg?type=f270_166" alt="" width="150" height="102" onError="javascript:this.src='https://imgnews.pstatic.net/image/news/2009/noimage_150x102.gif';this.style.width=150;this.style.height=102;"><br> <p><strong>"우리는 신고왕"···별난 집배원의 따스한 이야기</strong></p></a></div></div>
	    	 --> 
	    </div>
	    <!-- Left and right controls -->
	    <a class="left carousel-control" href="#news-carousel1" role="button" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#news-carousel1" role="button" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
	</div>
	<p>
	<div>
		<div class="row container-fluid" style="height:200px;overflow: scroll;">
			<ul id="nna1-ul" class="list-unstyled">
			</ul>     		 
     	</div>
	</div>
</div>
 