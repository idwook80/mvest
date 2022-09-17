<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.jsoup.*" %>
<%@ page language="java" import="org.jsoup.nodes.*" %>
<%@ page language="java" import="org.jsoup.select.*" %>

<%-- <link href="<%=request.getContextPath() %>/remo/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/remo/css/my.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script> 
<script src="<%=request.getContextPath() %>/remo/js/bootstrap.min.js"></script> --%>


<script src="<%=request.getContextPath() %>/remo/js/jquery-3.2.1.min.js"></script>
<script type=text/javascript>

function loadNaverRank1(){
	var divTag = $("#naver-rank-area1");
	
	var param = "start=1";
	$.ajax({
		type 		: "post",
		url			: "<%=request.getContextPath() %>/remo/naver/rank",
		data		: param,
		dataType	: "json",
		success		: function(data){
				if(data.status == 200){
					divTag.find("#naver-rank-ul1").html("");
					divTag.find("#naver-rank-carousel-inner1").html("");
					var time = data.time;
					divTag.find("#time").text(time);
					var ranks = data.ranks;
					for(var i=0; i<ranks.length; i++){
						var rank = ranks[i];
						var no = rank.no;
						var link = rank.link;
						var keyword = rank.keyword;
						divTag.find("#naver-rank-ul1").append("<li><a href=\""+link+"\" target=\"_blank\"><span class=\"btn btn-default btn-xs\" style=\"min-width:25px;margin:1px 0px;\" disabled>"+no+"</span><span> "+keyword+"</span></a></li>")
						if(i == 0) divTag.find("#naver-rank-carousel-inner1").append("<div class=\"item active\"><a href=\""+link+"\" target=\"_blank\"><span style=\"min-width:25px;margin:1px 0px;\">"+no+".</span><span> "+keyword+"</span></a></div>");
						else divTag.find("#naver-rank-carousel-inner1").append("<div class=\"item\"><a href=\""+link+"\" target=\"_blank\"><span style=\"min-width:25px;margin:1px 0px;\">"+no+".</span><span> "+keyword+"</span></a></div>");
					}
					$("#naver-rank-carousel1").carousel();
				}else {
					 
				}
		},
		error		: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		
	});
}
$(document).ready(function($){
	loadNaverRank1();
	setInterval(function() {
		loadNaverRank1();
	}, 1000*60);
});
</script>
<div id="naver-rank-area1">
	<div class="panel panel-primary">
      <div class="panel-heading">
      	<div class="row">
	      	<div class="col-xs-4"><a href="#naver-rank-body1" data-toggle="collapse"><strong>Naver 1~10</strong></a></div>
	      	<div id="naver-rank-carousel1" class="custom1 owl-carousel slide col-xs-8" data-ride="carousel" data-interval="5000"> <!--  data-ride="carousel" -->
	      	  <!-- Wrapper for slides -->
			    <div id="naver-rank-carousel-inner1" class="carousel-inner" role="listbox" style="">
			    </div>
			    <!-- Left and right controls -->
			 </div>
		 </div>
      </div>
      <div class="panel-body collapse" id="naver-rank-body1">
      	<ul id="naver-rank-ul1" style="list-style-type:none;padding:0px;"></ul>
      	<div><small><i id="time"></i></small></div>
      </div>
    </div>
</div>
