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
var coins = [];
var market_code ="";

function playSound ( soundname )
{
  var thissound = document.getElementById( soundname );
  thissound.play();
}
$(function(){
	$("#input-form-today #to_date").val(today_date);
/* 	$("#today_date").text(today_date); */
	marketAll();
	loadBalances();
	getTime();
	setInterval(function() {
		loadBalances();
	}, 1000*10);
	setInterval(function() {
		getTime();
	}, 1000);
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
function loadBalances(){
	bybit('main');

}
function marketAll(){
	$.ajax({
        url: "https://api.upbit.com/v1/market/all",
        dataType: "json"
      }).done(function(markets){
    	  updateCoins(markets);
       });
}
function updateCoins(markets){
	 for(var i=0; i<markets.length; i++){
			var item = markets[i];
			//console.log(Object.keys(item));
			
			if(item.market.startsWith('KRW')){
				coins.push(item);
			}
 	 }
	 setCoins();
	 var coin =  getCoins('KRW-XRP');
	 if(coin){
		 console.log(coin.market);
			console.log(coin.korean_name);
	 }
}
function setCoins(){
	
	for(var i=0; i<coins.length; i++){
		var item = coins[i];
		market_code += item.market;
		if(i < coins.length-1) market_code += ",";
	 }
	list();
}
function getCoins(market){
	for(var i=0; i<coins.length; i++){
		var item = coins[i];
		if(item.market == market){
			return item;
		}

	 
	 }
}


function list(){
		/* 
		var arr_krw_markets = 'KRW-XRP,KRW-ETH';
		$.ajax({
		          url: "https://api.upbit.com/v1/ticker?markets=" +arr_krw_markets,
		          dataType: "json"
		        }).done(function(tickers){ alert(JSON.stringify(tickers));  });
		 */
		 
		 var arr_krw_markets = 'KRW-BTC,KRW-ETH,KRW-XRP,KRW-ETC,KRW-BTG,KRW-BCH';
		 var all_market =  "https://api.upbit.com/v1/market/all";
		 var ticker  = "https://api.upbit.com/v1/ticker?markets=" + arr_krw_markets;
		 
  		var REQ_TYPE 	= "get";
  		var REQ_URL  	=  ticker;
  		$.ajax({
  			url			: REQ_URL,
  			dataType	: "json", 
  			beforeSend	: function(){/*  loadingShow(); */ },
  			success		: function(tickers){
  						/* loadingHide(); */
  						var str 		= JSON.stringify(tickers,null,2);
  						if(count == 0) {
  							//console.log(str);
  							count++;
  						}
  						updateList(tickers);
  			},
  			error		: function() {
  						ajaxError();
  			}
  		});
}

function binance(){
		var param 		= $("#pageForm").serialize();
		var REQ_TYPE 	= "get";
		var REQ_URL  	= "../binance/test";
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
						var result 		= res.result;
						var prices 		= res.prices;
						//console.log(prices[0].markPrice);
						var price = prices[0].markPrice.toFixed(2);
						
						$(".binance-price").text(price.toLocaleString());
						
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



function updateList(list){
	$(".wins-body").html('');
	 if(list){
    	 for(var i=0; i<list.length; i++){
			var item = list[i];
			$(".wins-body").append(getItemTag(item));
    	 }
    	
	 }
}
function getItemTag(item){
	 	 var tag 	= new StringBuffer();
	 	 var color = "text-dark";
	 	 var change = "";
	 	 var coin = getCoins(item.market);
	 	 var korean_name = coin.korean_name != null ? coin.korean_name : "";
	 	 
	 	 
	 	 if(item.change == "RISE" ){
	 		 color = "text-danger";
	 		change = "+";
	 	 }else if(item.change == "FALL"){
	 		 color = "text-primary";
	 		change = "-";
	 	 }else {
	 		chagne = "";
	 	 }
	 	 
	 	 
	 	 
	 	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
		 tag.append("<span>" + korean_name + "<br>"+ item.market+ "</span>");
		 tag.append("<span class=\""+color+"\">" + item.trade_price.toLocaleString() + "</span>");
		 tag.append("<span class=\""+color+"\">" + change +  (item.change_rate * 100).toFixed(2) + "%<br>" + change + item.change_price.toLocaleString() + "</span>");
		 tag.append("</li></div>");
		 
	 return tag.toString();
}
function getBinanceTag(str){
	 var tag 	= new StringBuffer();
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 tag.append("<span>" + korean_name + "<br>"+ item.market+ "</span>");
	 tag.append("<span class=\""+color+"\">" + item.trade_price.toLocaleString() + "</span>");
	 tag.append("<span class=\""+color+"\">" + change +  (item.change_rate * 100).toFixed(2) + "%<br>" + change + item.change_price.toLocaleString() + "</span>");
	 tag.append("</li></div>");
	 
 	return tag.toString();
}
function bybit(user){
	var param 		= $("#pageForm").serialize();
		param 		+= "&user=" + user;
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/test";
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
					var usdt = res.balances.result.USDT;
					var positions = res.positions.result;
					var kline_1		= res.kline_1.result;
					bybitBalanceSet(user, usdt);
					bybitPositions(user, positions);
					bybitKline_1(kline_1[0]);
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
var old_positions = [];
function bybitPositions(user, positions){
	
	var old_position = getPositions(positions[0]);
	
	for(var i=0; i<positions.length; i++){
		var old_pos	 = (old_position != null ? old_position[i] : null);
		var new_pos = positions[i];
		var entry_price = new_pos.entry_price;
		var side = new_pos.side;
		var size = new_pos.size;
		var position =  "long";
		if(side == 'Sell'){
			position = "short";
			size = size*-1;
		}
		
		var size2 = (size / (user == 'main' ? 0.15 : 0.001)) / 10;
		$("."+user+"-entry-price-" + position).text(comma(entry_price.toFixed(1)));
		$("."+user+"-size-" + position).text(size.toFixed(3) +'(' +size2.toFixed(1) + ")");
		
		var changed = (old_pos != null ? new_pos.size == old_pos.size : true);
		if(!changed){
		  	$("."+user+"-entry-price-" + position).fadeOut(100, function(){
				$(this).fadeIn(2000);
			});
			$("."+user+"-size-" + position).fadeOut(100, function(){
				$(this).fadeIn(2000);
			}); 
		}
	}
	setPositions(positions);
	if(user == 'main') bybit('sub');
}
function setPositions(positions){
	var exists = false;
	for(var i=0; i<old_positions.length; i++){
		var p = old_positions[i];
		if(positions[0].user_id == p[0].user_id) {
			exists = true;
			old_positions[i] = positions;
			break;
		}
	}
	if(!exists) old_positions.push(positions);
}
function getPositions(position){
	for(var i=0; i<old_positions.length; i++){
		var p = old_positions[i];
		if(position.user_id == p[0].user_id) return p;
	}
	return null;
}
function bybitBalanceSet(user, usdt){
	var className = ".bybit-area-"+user
	var count = 0;
	$(className).html('');
	$(className).append(bybitTag("실현잔고", usdt.wallet_balance.toFixed(2)) );
	$(className).append(bybitTag("실현금액", usdt.realised_pnl.toFixed(2)) );
	$(className).append(bybitTag("미실현액", usdt.unrealised_pnl.toFixed(2)) );
	$(className).append(bybitTag("예상잔고", usdt.equity.toFixed(2)) );
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
	
	
	
}
var wondollor = 140;
function bybitTag(key, value){
	 var tag 	= new StringBuffer();
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 tag.append("<span>" + key+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>$" + value+ "</span>");
	 else tag.append("<span class='text-danger p-value'>$" + value+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>￦" + comma((value * wondollor).toFixed(0))+ "</span>");
	 else tag.append("<span class='text-danger p-value'>￦" + comma((value * 1400).toFixed(0))+ "</span>");
	 
	 tag.append("</li></div>");
	 
 	return tag.toString();
 	
}
</script>

<%@ include file="navbar.jsp" %> 

<div class="container-fluid">

	<div class="row">
		<div class="col-sm-8  text-left">
			<span  class="text-dark" style="font-size:20px;font-weight:bold;;">
			<i class="fab fa-bitcoin text-warning"></i><span style="padding-left:5px;">버전 잔고 <strong id="today_date" style="font-size:10px;">0000-00-00</strong></span> 
			</span><br>
				<span style="font-size:12px;">
				현재가 : <span class="current_price"><i class="fas fa-arrow-up text-danger"></i><span>00000</span></span>
			 	, 1분거래량 : <span class="current_volume">0000</span>
			 	<i style="font-size:8px;">(<span id="today_time">00:00:00</span>)</i>
			 </span>
		</div>
	 	<!-- <div class="col-sm-4 text-right" style="font-size:10px;">
	 		<span class="text-right text-dark">
	 	 	<strong id="today_date">0000-00-00</strong>
	 		</span><br>
	 		<span><strong id="today_time">000000-00</strong></span>
	 	</div>  -->
 	</div>
	<hr>
	<div class="col-sm-12">
		<div class="row">
				<div class="container-fluid">
				 <div class="row">
				  <!-- Right Column -->
				     	 <%-- <%@ include file="right.jsp" %>  --%>
				    <div class="col-sm-12">
				  		<div class="row">
				  				
			  					<ul class="list-group col-sm-12">
									  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
										 <span><strong>예약버전</strong></span>
										 <span class="text-right">
										 	 <span class="btn btn-success" style='line-height:80%'>
										 	 	<span class="main-entry-price-long" style="font-size:12px;">19,105.0</span><br> 
										 	 	<span class="main-size-long" style="font-size:8px;">112.005</span>
										 	 </span>
										 	 
										 	  <span class="btn btn-danger" style='line-height:80%'>
										 	 	<span class="main-entry-price-short" style="font-size:12px;">19,105.0</span><br> 
										 	 	<span class="main-size-short" style="font-size:8px;">-112.005</span>
										 	 </span>
										 </span>
									
	  								 </li>
									  <div class="bybit-area-main" style="display:">
				  					  </div>
							 	</ul>
				  			 
				  		</div>
					</div>
					  <!-- Right Column -->
							<%--  <%@ include file="right.jsp" %>  --%>
					  <!-- Right Column -->
				   </div>
				</div>
		</div>
	</div>
	<hr>
	<div class="col-sm-12">
		<div class="row">
				<div class="container-fluid">
				 <div class="row">
				    <div class="col-sm-12">
				  		<div class="row">
			  					<ul class="list-group col-sm-12">
									  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
										 <span><strong>자동버전</strong></span>
										 <span class="text-right">
										 
										 	 <span class="btn btn-success" style='line-height:80%'>
										 	 	<span class="sub-entry-price-long" style="font-size:12px;">19,105.0</span><br> 
										 	 	<span class="sub-size-long"  style="font-size:8px;">112.005</span>
										 	 </span>
										 	 
										 	  <span class="btn btn-danger" style='line-height:80%'>
										 	 	<span class="sub-entry-price-short" style="font-size:12px;">19,105.0</span><br> 
										 	 	<span class="sub-size-short" style="font-size:8px;">-112.005</span>
										 	 </span>
										 </span>
									
	  								 </li>
									  <div class="bybit-area-sub" style="display:">
				  					  </div>
							 	</ul>
				  		</div>
				     
					</div>
					  <!-- Right Column -->
							<%--  <%@ include file="right.jsp" %>  --%>
					  <!-- Right Column -->
				   </div>
				</div>
		</div>
	</div>
		<hr>
	<div class="col-sm-12">
		<div class="row">
  					<ul class="list-group col-sm-12">
					
						  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
							 <span><strong>자동버전</strong></span>
							 <span class="text-right">
							 
							 	 <span class="btn btn-success" style='line-height:80%'>
							 	 	<span style="font-size:12px;">19,105.0</span><br> 
							 	 	<span style="font-size:8px;">112.005</span>
							 	 </span>
							 	 
							 	  <span class="btn btn-danger" style='line-height:80%'>
							 	 	<span style="font-size:12px;">19,105.0</span><br> 
							 	 	<span style="font-size:8px;">-112.005</span>
							 	 </span>
							 </span>
						
								 </li>
					  <div class="bybit-area-three" style="display:">
  					  </div>
				 	</ul>
			  			 
			     
		</div>
	</div>
	<hr>
	<div class="list-group col-sm-12 ">
				
				  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
				    <div class="d-flex w-100 justify-content-between">
				      <h5 class="mb-1" style="width: 100px;">Binance </h5>
				      <strong style="text-align: right;" class="binance-price">39,840,000</strong>
				      <h5 class="mb-1 text-danger">-0.42% </h5>
				    </div>
				  
					  <div class="d-flex w-100 justify-content-between">
					  	<small class="text-secondary">KRW-XRP</small>
					    <small>-125,000</small>
					   </div>
				  </a>
				  
				    <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
				    <div class="d-flex w-100 justify-content-between">
				      <span style="width: 100px;">이더리움클래식 </span>
				      <strong  style="text-align: right;">3900</strong>
				      <h5 class="mb-1 text-danger">-0.42% </h5>
				    </div>
				  
					  <div class="d-flex w-100 justify-content-between">
					  	
					  	<small class="text-secondary">KRW-XRP</small>
					    <small>-125,000</small>
					   </div>
				  </a>
				  <a href="#" class="list-group-item d-flex flex-row justify-content-between">
				    	 <div class="item">Item1</div>
						    <div class="item"><strong >39,840,000</strong></div>
						    <div class="item">Item4</div>
				  </a>
				    <a href="#" class="list-group-item d-flex flex-row justify-content-between">
				    	 <div class="item">이더리움클래식</div>
						    <div class="item"><strong>300</strong></div>
						    <div class="item">Item4</div>
				  </a>
				  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start active">
				    <div class="d-flex w-100 justify-content-between">
				      <h5 class="mb-1">List group item heading</h5>
				      <small class="text-muted">3 days ago</small>
				    </div>
				    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
				    <small class="text-muted">Donec id elit non mi porta.</small>
				  </a>
				
	
	</div>
	
	<!-- Container (Services Section) -->
<div id="services" class="container-fluid text-center">
  <h2>SERVICES</h2>
  <h4>What we offer</h4>
  <br>
  <div class="row slideanim">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-off logo-small"></span>
      <h4>POWER</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-heart logo-small"></span>
      <h4>LOVE</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-lock logo-small"></span>
      <h4>JOB DONE</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
  </div>
  <br><br>
  <div class="row slideanim">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-leaf logo-small"></span>
      <h4>GREEN</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-certificate logo-small"></span>
      <h4>CERTIFIED</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-wrench logo-small"></span>
      <h4 style="color:#303030;">HARD WORK</h4>
      <p>Lorem ipsum dolor sit amet..</p>
    </div>
  </div>
</div>
	
	
	
	
	<div>
							
		
		<script>
	
		</script>
	
	</div>
</div>
	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
</body>
    
    
    
</html>
