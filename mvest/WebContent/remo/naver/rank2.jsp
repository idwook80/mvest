<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.jsoup.*" %>
<%@ page language="java" import="org.jsoup.nodes.*" %>
<%@ page language="java" import="org.jsoup.select.*" %>

<%-- <script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script>  --%>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->

<%-- <link rel="stylesheet" href="<%=request.getContextPath() %>/remo/css/owl.carousel.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/remo/css/animate.css">
<script src="<%=request.getContextPath() %>/remo/js/owl.carousel.min.js"></script>
<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script> --%>
<script type=text/javascript>

function loadNaverRank2(){
	var divTag = $("#naver-rank-area2");
	
	var param = "start=11";
	$.ajax({
		type 		: "post",
		url			: "<%=request.getContextPath() %>/remo/naver/rank",
		data		: param,
		dataType	: "json",
		success		: function(data){
				if(data.status == 200){
					divTag.find("#naver-rank-ul2").html("");
					divTag.find("#naver-rank-carousel-inner2").html("");
					
					var time = data.time;
					divTag.find("#time").text(time);
					var ranks = data.ranks;
					for(var i=0; i<ranks.length; i++){
						var rank = ranks[i];
						var no = rank.no;
						var link = rank.link;
						var keyword = rank.keyword;
						divTag.find("#naver-rank-ul2").append("<li><a href=\""+link+"\" target=\"_blank\"><span class=\"btn btn-default btn-xs\" style=\"min-width:25px;margin:1px 0px;\" disabled>"+no+"</span><span> "+keyword+"</span></a></li>");
						if(i == 0) divTag.find("#naver-rank-carousel-inner2").append("<div class=\"item active\"><a href=\""+link+"\" target=\"_blank\"><span style=\"min-width:25px;margin:1px 0px;\">"+no+".</span><span> "+keyword+"</span></a></div>");
						else divTag.find("#naver-rank-carousel-inner2").append("<div class=\"item\"><a href=\""+link+"\" target=\"_blank\"><span style=\"min-width:25px;margin:1px 0px;\">"+no+".</span><span> "+keyword+"</span></a></div>");
					}
					$("#naver-rank-carousel2").carousel();
				}else {
					 
				}
		},
		error		: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	});
}
$(document).ready(function($){
	loadNaverRank2();
	setInterval(function() {
		loadNaverRank2(); 
	}, 1000*60); 
	$('#naver-rank-ul2').on('hidden.bs.collapse', function (e) {
		  $("#naver-rank-carousel2").css("display","");
	});
	$('#naver-rank-ul2').on('show.bs.collapse', function (e) {
		  $("#naver-rank-carousel2").css("display","none");
	});
	 $('.owl-carousel').owlCarousel(); 

	 $('.fadeOut').owlCarousel({
         items: 1,
         animateOut: 'fadeOut',
         loop: true,
         margin: 10,
       });
	 $('.custom1').owlCarousel({
		    animateOut: 'slideOutDown',
		    animateIn: 'flipInX',
		    items:1,
		    margin:30,
		    stagePadding:30,
		    smartSpeed:450,
		});
});
</script>
<style>
.vertical .carousel-inner {
}

.carousel.vertical .item {
   -webkit-transition: 0.6s ease-in-out top;
   -moz-transition: 0.6s ease-in-out top;
   -ms-transition: 0.6s ease-in-out top;
   -o-transition: 0.6s ease-in-out top;
   transition: 0.6s ease-in-out top;
}

.carousel.vertical .active {
   top: 0;
}

.carousel.vertical .next {
   top: 30px;
}

.carousel.vertical .prev {
   top: -30px;
}

.carousel.vertical .next.left,
.carousel.vertical .prev.right {
   top: 0;
}

.carousel.vertical .active.left {
   top: -30px;
}

.carousel.vertical .active.right {
   top: 30px;
}

.carousel.vertical .item {
   left: 0;
}
</style>
<div id="naver-rank-area2">
	<div class="panel panel-primary">
      <div class="panel-heading">
      	<div class="row">
	      	<div class="col-xs-4"><a href="#naver-rank-body2" data-toggle="collapse"><strong>Naver 11~20</strong></a></div>
	      	<div id="naver-rank-carousel2" class="custom1 owl-carousel slide col-xs-8" data-ride="carousel" data-interval="5000"> <!--  data-ride="carousel" -->
	      	  <!-- Wrapper for slides -->
			    <div id="naver-rank-carousel-inner2" class="carousel-inner" role="listbox" style="">
			    </div>
			    <!-- Left and right controls -->
			 </div>
		 </div>
      </div>
      <div class="panel-body collapse" id="naver-rank-body2">
      	<ul id="naver-rank-ul2" style="list-style-type:none;padding:0px;"></ul>
      	<div><small><i id="time"></i></small></div>
      </div>
    </div>
</div>
