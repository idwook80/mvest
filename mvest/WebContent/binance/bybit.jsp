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
	$("#today_date").text(today_date);
	marketAll();
	loadBalances();
	setInterval(function() {
		loadBalances();
	}, 1000*5);


});	
function loadBalances(){
	bybit('main');
	
	bybit('sub');
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
		param += "&user=" + user;
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/test";
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: param,
		dataType	: "json", 
		async		: false,
		beforeSend	: function(){/*  loadingShow(); */ },
		success		: function(res){
					/* loadingHide(); */
					var str 		= JSON.stringify(res,null,2);
					console.log(str);
					var result 		= res.result;
					var usdt = res.usdt;
					bybitSet(user, usdt);
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
function bybitSet(user, usdt){
	var className = ".bybit-area-"+user
	$(className).html('');
	$(className).append(bybitTag("잔고", usdt.wallet_balance.toFixed(2)) );
	$(className).append(bybitTag("실현가능",usdt.unrealised_pnl.toFixed(2)) );
	$(className).append(bybitTag("실현금액",usdt.realised_pnl.toFixed(2)) );
	$(className).append(bybitTag("예상잔고",usdt.equity.toFixed(2)) );
	$(className).append(bybitTag("이용가능",usdt.available_balance.toFixed(2)) );
	
	/* $(".bybit-area").append(bybitTag("used_margin",usdt.used_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("order_margin",usdt.order_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("position_margin",usdt.position_margin.toFixed(2)));
	$(".bybit-area").append(bybitTag("occ_closing_fee",usdt.occ_closing_fee.toFixed(2)));
	$(".bybit-area").append(bybitTag("occ_funding_fee",usdt.occ_funding_fee.toFixed(2)));
	
	$(".bybit-area").append(bybitTag("cum_realised_pnl",usdt.cum_realised_pnl.toFixed(2)));
	$(".bybit-area").append(bybitTag("given_cash",usdt.given_cash.toFixed(2)));
	$(".bybit-area").append(bybitTag("service_cash",usdt.service_cash.toFixed(2))); */
	
	
}
function bybitTag(key, value){
	 var tag 	= new StringBuffer();
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 tag.append("<span>" + key+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-danger'>$" + value+ "</span>");
	 else tag.append("<span class='text-primary'>$" + value+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-danger'>￦" + comma((value * 1400).toFixed(0))+ "</span>");
	 else tag.append("<span class='text-primary'>￦" + comma((value * 1400).toFixed(0))+ "</span>");
	 
	 tag.append("</li></div>");
	 
 	return tag.toString();
 	
}
</script>

<%@ include file="navbar.jsp" %> 

<div class="container-fluid">

	<div class="row">
			<span  class="text-dark" style="font-size:24px;font-weight:bold;margin-right:20px;">
			바이비트 잔고 정보
			</span>
			 <div class="col-md-12  col-sm-12 text-right"><span class="text-right text-dark"><strong>오늘 : </strong><strong id="today_date">2021-01-01</strong></span></div> 
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
										  <div class="col-sm-2"><span class=""><h4 class="text-light">예약버전</h4></span></div>
								  		   <div class="col-sm-10 text-right" style="padding:1px;" >
									  		   <span class="btn btn-success" style="margin:0;padding:1px;">
								  					 <small style="font-size:12px;"> 19,385.0<br>12.023</small>
									  			</span>
									  		    <span class="btn btn-danger" style="margin:0;padding:1px;">
									  					<small style="font-size:12px;">19285.0<br>-120.02</small>
									  			</span>
								  		   </div>
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
				  <!-- Right Column -->
				     	 <%-- <%@ include file="right.jsp" %>  --%>
				    <div class="col-sm-12">
				  		<div class="row">
			  					<ul class="list-group col-sm-12">
	  					
									  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
									   <span class="">
									  			<h4 class="text-light">자동버전</h4>	
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
				<div class="container-fluid">
				 <div class="row">
				  <!-- Right Column -->
				     	 <%-- <%@ include file="right.jsp" %>  --%>
				    <div class="col-sm-12">
				  		
				  		<div class="row">
			  					<ul class="list-group col-sm-12">
	  					
									  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
									   <span>종목</span>
									    <span>현재가</span>
									    <span>등락률</span>
									  </li>
									  
									  <div class="wins-body" style="display:inline-block">
				  					  </div>
							 	</ul>
				  			 
				  		</div>
				  		<br>
				  		<div class="row container-fluid">
				  		  <%@include file="../_paging.jsp" %>
				  		</div>
				     
					</div>
					  <!-- Right Column -->
							<%--  <%@ include file="right.jsp" %>  --%>
					  <!-- Right Column -->
				   </div>
				</div>
		</div>
	</div>
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
