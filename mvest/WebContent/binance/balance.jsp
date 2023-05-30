<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.mvest.util.*" %>

<%
	request.setAttribute("G_PAGE_LEVEL", 30);
	Calendar today = Calendar.getInstance();
	today.setTime(new Date());
	int yyyy 		= today.get(Calendar.YEAR);
	int mm 			= today.get(Calendar.MONTH)+1;
	int dd			= today.get(Calendar.DATE);
	
	
	String year 	= request.getParameter("year");
	String month 	= request.getParameter("month");
	String date		= request.getParameter("date");
	
	try{
		if(year != null)  		yyyy 	= Integer.parseInt(year);
		if(month != null)  		mm  	= Integer.parseInt(month);
		if(date != null) 		dd 		= Integer.parseInt(date);
		
	}catch(Exception e){
		e.printStackTrace();
	}
	String tDate = yyyy+"-"+ ( mm <10 ? "0"+mm : mm ) +"-"+ ( dd <10 ? "0"+dd : dd) ;
	
	HashMap<String,Object> paramMap = new HashMap<String,Object>();
	paramMap.put("curPage", (request.getParameter("curPage") != null ? (String) request.getParameter("curPage") : "1") );
	paramMap.put("perPage", (request.getParameter("perPage") != null ? (String) request.getParameter("perPage") : "20") );
	paramMap.put("search_param", "");
	paramMap.put("keyword", "");
	paramMap.put("sort", "");
	paramMap.put("order", "");
	

%>
	
<%@ include file="common.jsp" %>
<body>
 <%=ParamUtil.DEFAULT_PAGE_FORM_START_TAG %>
 <%=ParamUtil.serializeForm(paramMap) %>
 <%=ParamUtil.DEFAULT_PAGE_FORM_END_TAG %>

<script type="text/javascript">
var wins;
var today_date = '<%=tDate %>';
var count = 0;
var market_code ="";
 
$(function(){
	$("#input-form-today #to_date").val(today_date);
/* 	$("#today_date").text(today_date); */
	getBalancesList();
	getTime();
	setInterval(function() {
		getBalancesList();
	}, 1000*10);
	setInterval(function() {
		getTime();
	}, 1000);
	$("#user_selector").change(function(){
		//alert($(this).val());
		alert($(this).children("option:selected").text());
		user_id = $(this).val();
		//getLoadOrders();
	});
});
function getTime(){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	var day = today.getDay();  // 요일
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	var seconds = today.getSeconds();  // 초
	var milliseconds = today.getMilliseconds(); // 밀리초
	$("#today_date").text((year)+"년 "+getTimeFormat(month)+"월 "+getTimeFormat(date) + "일");
	$("#today_time").text(getTimeFormat(hours)+":"+getTimeFormat(minutes)+":"+getTimeFormat(seconds));
}
function getTimeFormat(time){
	return time < 10 ? "0" + time : ""+time;
}
 
function getBalancesList(){
	var param 		= $("#pageForm").serialize();
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/balances/list";
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: param,
		dataType	: "json", 
		async		: true,
		beforeSend	: function(){/*  loadingShow(); */ },
		success		: function(res){
					/* loadingHide(); */
					var str 		= JSON.stringify(res,null,2);
					//console.log(str);
					var result 		= res.result;
					var balances	 = res.balances;
					updateBalances(balances);
					if(status <= 100){
					}else {
						ajaxLoadFail(result);
					}
		},
		error		: function() {
					ajaxError();
		}
	});
}
function updateBalances(balances){
	console.log(balances);
	$(".balances-area").html('');
	
	var kline		= balances[0].kline.result;
	bybitKline_1(kline[0]);
	for(var i=0; i<balances.length; i++){
		var balance = balances[i];
		$(".balances-area").append(getBalanceTag(balance));
	}
	for(var i=0; i<balances.length; i++){
		var b = balances[i];
		var className = ".bybit-area-"+b.id;
		//$(className).fadeOut();
		//$(className).fadeIn("slow");
	}
}
function getBalanceTag(b){
	var positions = b.positions;
	var usdt	  = b.balance.result.USDT;
	
	var tag 	= new StringBuffer();
	tag.append("<ul class=\"list-group col-sm-4\" data-toggle=\"collapse\" data-target=\"#"+b.user_name+"\">");
	tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center bg-secondary text-light\">");
	tag.append(" <span><strong>" + b.user_name +"</strong></span>");
	tag.append(" <span class=\"text-right\">");
		 
	tag.append(getPositionTag(b));
	tag.append(" </span>");
	
	tag.append("	 </li>");
	tag.append("<div  id=\""+b.user_name+"\" class=\"bybit-area-"+b.id+"\" style=\"display:\"> ");
	
	tag.append(getBybitBalanceTag(usdt));
	
	tag.append("	</div></ul>");
	return tag.toString();
}
function getPositionTag(b){
	var positions = b.positions;
	var default_qty = b.default_qty;
	var buy = positions.result[0];
	var sell = positions.result[1];
	var buySize = (buy.size / parseFloat(default_qty))/10;
	var sellSize = (sell.size / parseFloat(default_qty))/10;
	
	var tag 	= new StringBuffer();
	tag.append("	 	 <span class=\"btn btn-success\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">"+comma(buy.entry_price.toFixed(1))+"</span><br>");
	tag.append("	 	 	<span style=\"font-size:8px;\">"+buy.size+"(" +buySize.toFixed(1)+")</span>");
	tag.append("	 	 </span>");
		 	 
	tag.append(" 	  <span class=\"btn btn-danger\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">"+comma(sell.entry_price.toFixed(1))+"</span><br> ");
	tag.append("	 	 	<span style=\"font-size:8px;\">-"+sell.size+"("+sellSize.toFixed(1)+")</span>");
	tag.append("	 	 </span>");
	return tag.toString();
}
 
function bybitKline_1(kline_1){
	var open_price 	= kline_1.open;
	var close_price = kline_1.close;
	var volume = kline_1.volume;
	
	if(close_price < open_price){
		$(".current_price").html("<i class=\"fas fa-arrow-down text-danger\"></i><span class=\"text-danger\"> "+comma(close_price.toFixed(1))+"</span>");
	}else {
		$(".current_price").html("<i class=\"fas fa-arrow-up text-success\"></i><span class=\"text-success\"> "+comma(close_price.toFixed(1))+"</span>");
	}
	if(volume > 100){
		$(".current_volume").text(volume.toFixed(2));
	}else {
		$(".current_volume").text(volume.toFixed(2));
	}
	$(".current_price").fadeOut();
	$(".current_price").fadeIn("slow");
	$(".current_volume").fadeOut();
	$(".current_volume").fadeIn("slow");
}
function getBybitBalanceTag(usdt){
	 var tag 	= new StringBuffer();
	 tag.append(bybitTag("예  상", usdt.equity.toFixed(2)) );
	 tag.append(bybitTag("미실현", usdt.unrealised_pnl.toFixed(2)) );

	 tag.append(bybitTag("실  현", usdt.realised_pnl.toFixed(2)) );
	 tag.append(bybitTag("잔  고", usdt.wallet_balance.toFixed(2)) );
	
	/* $(className).append(bybitTag("이용가능",usdt.available_balance.toFixed(2)) ); */
	/* $(".bybit-area").append(bybitTag("used_margin",usdt.used_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("order_margin",usdt.order_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("position_margin",usdt.position_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("occ_closing_fee",usdt.occ_closing_fee.toFixed(2)));
	$(".bybit-area").append(bybitTag("occ_funding_fee",usdt.occ_funding_fee.toFixed(2)));
	
	$(".bybit-area").append(bybitTag("cum_realised_pnl",usdt.cum_realised_pnl.toFixed(2)));
	$(".bybit-area").append(bybitTag("given_cash",usdt.given_cash.toFixed(2)));
	$(".bybit-area").append(bybitTag("service_cash",usdt.service_cash.toFixed(2))); */
	
	/* $(className + " .p-value").slideUp(500,function(){
		$(this).slideDown(1000);
	}); */
	return tag.toString();
}
var wondollor = 130;
function bybitTag(key, value){
	 var tag 	= new StringBuffer();
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 tag.append("<span>" + key+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>$" + value+ "</span>");
	 else tag.append("<span class='text-danger p-value'>$" + value+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>￦" + comma((value * wondollor).toFixed(0))+ "</span>");
	 else tag.append("<span class='text-danger p-value'>￦" + comma((value * wondollor).toFixed(0))+ "</span>");
	 
	 tag.append("</li></div>");
	 
 	return tag.toString();
}

function getBalanceList(){
	
	var id = $("#user_selector").val();

	
	var param 		= $("#pageForm").serialize();
		param 		= "&id="+id;
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/balance/list";
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: param,
		dataType	: "json", 
		async		: true,
		beforeSend	: function(){/*  loadingShow(); */ },
		success		: function(res){
					/* loadingHide(); */
					var str 		= JSON.stringify(res,null,2);
					//console.log(str);
					var balances = res.balances;
					
					updateBalanceList(balances);
					if(status <= 100){
					}else {
						ajaxLoadFail(result);
					}
		},
		error		: function() {
					ajaxError();
		}
	});
}
function updateBalanceList(balances){
	console.log(balances);
	$(".balance-list-area").html('');
	
	for(var i=0; i<balances.length; i++){
		var b = balances[i];
		var p = balances[i+1];
		$(".balance-list-area").append(getBalanceListTag(b, p));
	}
}
function getBalanceListTag(b,p){
	var equity = parseFloat(b.equity);
	var pre	 = p ? (equity - parseFloat(p.equity)) : 0;
	var reg_date = b.reg_date;
	var id		 = b.id;
	var per     = 0;
	if(p) per = pre / ( parseFloat(p.equity)/ 100);
	
	 var tag 	= new StringBuffer();
	 tag.append("<a href=\"#\" class=\"list-group-item list-group-item-action flex-column align-items-start\">");
	 tag.append("<div class=\"d-flex w-100 justify-content-between\">");
	 tag.append("<pre class=\"mb-1\" style=\"text-align: left;\">"+reg_date+" </pre>");
	 tag.append("<strong style=\"text-align: center;\" class=\"binance-price\">$"+equity.toFixed(2)+"</strong>");
	 if(per < 0) tag.append("<strong class=\"mb-1 text-danger\">"+per.toFixed(2)+"% </strong>");
	 else tag.append("<strong class=\"mb-1 text-success\">"+per.toFixed(2)+"% </strong>");
	 tag.append(" </div>");
	 tag.append("<div class=\"d-flex w-100 justify-content-between\">");
	 tag.append("<small class=\"text-secondary\">"+id+"</small>");
	 if(pre < 0 ) tag.append(" <small class=\"text-danger\">"+pre.toFixed(2)+"</small>");
	 else tag.append(" <small class=\"text-success\">"+pre.toFixed(2)+"</small>");
	 
	 tag.append(" </div>");
	 tag.append(" </a>");
	 
	 return tag.toString();
}
</script>

<%@ include file="navbar.jsp" %> 

<div class="container-fluid" style="min-height:300px;">
	<div class="row">
		<div class="col-sm-12  text-left">
			<span  class="text-dark" style="font-size:20px;font-weight:bold;;">
			<i class="fab fa-bitcoin text-warning"></i><span style="padding-left:5px;">버전 잔고 <strong id="today_date" style="font-size:10px;">0000-00-00</strong></span> 
			</span><br>
				<span style="font-size:12px;">
				현재가 : <span class="current_price"><i class="fas fa-arrow-up text-danger"></i><span>00000</span></span>
			 	, 1분거래량 : <span class="current_volume">0000</span>
			 	<i style="font-size:8px;">(<span id="today_time">00:00:00</span>)</i>
			 </span>
		</div>
 	</div>
 	<hr>
 	<div class="row balances-area">
 	</div>
	<hr>
	<div class="row">
		<div class="col-sm-12  text-left">
			 <form>
			  <div class="input-group mb-3">
			    <div class="input-group-prepend">
			      <span class="input-group-text">사용자</span>
			    </div>
			      <select class="form-control" id="user_selector" name="user_selector">
			        <option value="idwook80" selected>모드80</option>
			        <option value="idwook01">모드01</option>
			        <option value="idwook02">모드02</option>
			      </select>
			       <div class="input-group-prepend">
			        <span class="btn btn-light" style='line-height:100%'  onclick="getBalanceList()">
			 	 	<span class="" style="font-size:12px;">조회</span>
			 	    </span>
			    </div>
			  </div>
			 
			</form>
		</div>
	<hr>
	<div class="container-fluid">
	<div class="row">
	   <div class="col-sm-12">
  		<div class="row">
			<div class="list-group col-sm-12 balance-list-area">
			 <!--  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
			    <div class="d-flex w-100 justify-content-between">
			      <h4 class="mb-1" style="width: 100px;">날짜 </h4>
			      <strong style="text-align: right;" class="binance-price">$123456</strong>
			      <h5 class="mb-1 text-danger">-0.42% </h5>
			    </div>
				  <div class="d-flex w-100 justify-content-between">
			  		<small class="text-secondary">사용자</small>
			   		 <small>-125,000</small>
			      </div>
			  </a> -->
			</div>
  		</div>
	    </div>
	</div>
	</div>
</div>
	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
</body>
    
    
    
</html>
