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
	String user_id = request.getParameter("id") != null ? (String)request.getParameter("id") : "idwook80";
	
	

%>
<style>
a {
  text-decoration: none;
  color : white;
}
</style>
	
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
var current_price= 0;
var user_id = '<%=user_id %>';

$(function(){
	$("#input-form-today #to_date").val(today_date);
/* 	$("#today_date").text(today_date); */
 	
 	if(user_id){
 		//alert(user_id);
 	}
	marketAll();
	getLoadOrders();
	getLoadAlarms();
	loadBalances();
	getTime();
	setInterval(function() {
		//loadBalances();
	}, 1000*10);
	setInterval(function() {
		getTime();
	}, 1000);
	
	$("#user_selector").change(function(){
		//alert($(this).val());
		alert($(this).children("option:selected").text());
		user_id = $(this).val();
		getLoadOrders();
		getLoadAlarms();
	});
	$("#symbol_selector").change(function(){
		getLoadAlarms();
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

function getAlarms(id,bpage,blimit){
	var symbol		= $("#symbol_selector").val();
	
	var param 		= $("#pageForm").serialize();
		param 		+= "&id=" + id + "&bpage="+bpage+"&blimit="+blimit+"&symbol="+symbol;
		if(p_id == '1') param += "&position=S";
		else if(p_id == '2')  param += "&position=L";
		
		//alert(param);
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/alarms";
	
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
					var alarms = res.alarms;
					console.log(alarms);
					updatePaging(res.vo);
					//var result 		= res.result;
					//var orders 		= res.orders.result.data;
					//console.log(orders);
				 	updateAlarms(alarms);
					
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
var sortedAlarms;
function updateAlarms(alarms){
	sortedAlarms = alarms.sort(function(a, b){
		return  b.trigger- a.trigger;
	});
	$(".alarms-area").html('');
	
	$("#printf").val('');
   	 for(var i=0; i<sortedAlarms.length; i++){
			var alarm = sortedAlarms[i];
			var next = alarm.next;
			$(".alarms-area").append(getAlarmTag(alarm));
			//if(next) $(".alarms-area").append(getAlarmTag2(next));
   	 }
}
function isEmpty(str){
	
	if(typeof str == "undefined" || str == null || str == "")
		return true;
	else
		return false ;
}
function getAlarmTag(a){
	//console.log(a);
	 var tag 	= new StringBuffer();
	 
	 var alarm_id 		= a.alarm_id;
	 var parent_alarm_id= a.parent_alarm_id;
	 var alarm_kind 	= a.alarm_kind == "P" ?
			 				"<i class=\"fa fa-bell text-info\"></i>" 
			 				: "<i class=\"fa fa-handshake text-success\"></i>";
 		var alarm_kind 	= "<i class=\""+ (a.alarm_kind == "P" ? "fa fa-bell" : "fa fa-handshake")
 							+" "+(a.side == 'B' ? " text-success" : "text-danger")+"\"></i>" ;				
	
	 var trigger		= a.trigger;
	 var is_over		= a.is_over == "Y" ?
			 				"<i class=\"ml-2  fa fa-arrow-up text-success\"></i>" 
			 				: "<i class=\"ml-2 fa fa-arrow-down text-danger\"></i>"
			 				
	 var parent_order_id = a.parent_order_id == 'undefined' ? "-" : a.parent_order_id;
	 
	 
	 var position		= a.position == 'L' ? "Long" : "Short";
	 var side			= a.side == 'B' ? "Buy" : "Sell";
	 var price			= a.price;
	 var qty			= a.qty;
	 var symbol			= a.symbol;
	 var repeat			= a.repeat;
	 var user_id		= a.user_id;
	 var update_at		= a.update_at;
	 var next_id		= isEmpty(a.next_id) ? "-" : a.next_id;
	 var next_alarm_id	= a.next_alarm_id ==  "undefined" ? "-" : a.next_alarm_id;
	 var action		   =  "";
	 if( a.position == 'L'){
		 action =  a.side == 'B' ? "OpenLong" : "CloseLong";
	 }else if(a.position == 'S') {
		 action =  a.side == 'B' ? "CloseShort" : "OpenShort";
	 }
    
    var next = a.next;
    var actionString = (next) ? "make" : "";
    actionString += action + "("+ trigger + ","
    actionString += a.is_over == "Y" ? " OVER, " : " UNDER, ";
    actionString += price + ", "+qty+", ";
    actionString += (next) ? next.price+", " : "";
    actionString += (next) ? next.repeat : a.repeat;
    actionString += ")";
    actionString = actionString.charAt(0).toLowerCase() + actionString.slice(1);
    console.log(actionString);
    $("#printf").val($("#printf").val()+ actionString +";\n");
	// tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 if(a.alarm_kind == 'T' || !next) {
		 if(a.is_over == 'Y') tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-info\">");
		 else  tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-dark\">");
	 }
	 else  tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 
	 
	 tag.append("<div class=\"d-flex flex-row align-items-center\" style=\"min-width:200px;\">");
	 tag.append("  <div class=\"d-flex flex-column ml-2\">");
	 tag.append("		<div class=\"d-flex flex-row mt-1\">");
	 tag.append("	 <div><span class=\"d-flex flex-row mt-1\" style=\"min-width:20px;\">" + alarm_kind + "</span></div>");
	 /* tag.append("          <div><span class=\"ml-2\">0.528</span><i class=\"ml-2 fa fa-arrow-up text-danger\"></i></div>"); */
	 if(a.alarm_kind =='P') tag.append("<div><span class=\"ml-2 badge\" style=\"width:60px;\">" + trigger + "</span>" + is_over + "</div>");
	 else  					tag.append("<div><span class=\"ml-2 badge\" style=\"width:60px;\">"+trigger+"</span>" + is_over + getTradeActionTag(a.position, a.side)+"</div>");
	 tag.append("      </div>");
	 tag.append("  </div>");
	 tag.append("</div>");
   	
	 tag.append("<div class=\"d-flex flex-row align-items-center\">");
	 tag.append("  <div class=\"d-flex flex-column ml-2\">");
	 tag.append("     		<span class=\"d-flex flex-row mt-1 badge\" title=\""+actionString+"\">" + alarm_id+ "</span>");
	 if(next) tag.append("  <span class=\"d-flex flex-row mt-1 badge\"><i class=\"text-muted\">" + next.alarm_id + "</i></span>");
	 tag.append("  </div>");
	 tag.append("	</div>");
   	
	 tag.append("<div class=\"d-flex flex-row align-items-center\">");
	 tag.append("  <div class=\"d-flex flex-column ml-2\">");
	 tag.append("       <div class=\"d-flex flex-row mt-1\">");
	 tag.append("      	 <i class=\"fas fa-sign-out-alt\"></i>");
	/*  tag.append("       	 <span class=\"ml-2 badge badge-danger\">Open Short</span>"); */
	 tag.append( getActionTag(a.position, a.side));
	 tag.append("       </div>");
	 if(next){
	 	tag.append("    <div class=\"d-flex flex-row mt-1\">");
	  	tag.append("      	 <i class=\"fas fa-sign-in-alt\"></i>");
	  	/* tag.append("       	 <span class=\"ml-2 badge badge-danger\">Open Short</span>"); */
	  	tag.append(getActionTag(next.position, next.side));
	  	tag.append("      </div>");
	 }
	 tag.append(" </div>");
	 tag.append(" </div>");
   	
	 tag.append(" <div class=\"d-flex flex-row align-items-center\">");
	 tag.append("  <div class=\"d-flex flex-column ml-2\">");
	 tag.append("  		<div class=\"d-flex flex-row mt-1\">");
	/*  tag.append("           <span>0.5800</span><span class=\"ml-2\">0.5800</span>  "); */
     tag.append(getPriceQtyTag(a.side, price, qty));                      	  
	/*  tag.append("           <span>" + price + "</span><span class=\"ml-2\">" + qty + "</span>  "); */
	 tag.append("      </div>");
	 if(next){
		 tag.append("    	 <div class=\"d-flex flex-row mt-1\">");
		/*  tag.append("      	  <span>0.5800</span><span class=\"ml-2\">0.5800</span> "); */
		/*  tag.append("          <span>" + next.price + "</span><span class=\"ml-2\">" +next.qty+ "</span>  "); */
		 tag.append(getPriceQtyTag(next.side, next.price, next.qty));  
		 tag.append("     </div>");
	 }
	 tag.append(" </div>");
	 tag.append("</div>");
   	
	 tag.append(" <div class=\"d-flex flex-row align-items-center\">");
	 tag.append(" <div class=\"d-flex flex-column ml-2\">");
	 tag.append(" 		<div class=\"d-flex flex-row mt-1\">");
	/*  tag.append("           <span class=\"badge badge-primary badge-pill\">1</span> "); */
	 tag.append("           <span class=\"badge badge-primary badge-pill\">" + repeat + "</span> ");
	 tag.append("     </div>");
	 if(next){
		 tag.append("   	 <div class=\"d-flex flex-row mt-1\">");
		 /* tag.append("         <span class=\"badge badge-primary badge-pill\">99</span> "); */
		 tag.append("         <span class=\"badge badge-primary badge-pill\">" + next.repeat+ "</span> ");
		 tag.append("     </div>");
	 }
	 tag.append(" </div>");
	 tag.append("<div class=\"d-flex flex-column ml-2\">");
	 tag.append("   <i class=\"fa fa-ellipsis-h\"></i>");
	 tag.append("    </div>");
	 tag.append("</div>");
   	
	 tag.append("</li>");
	 return tag.toString();
}
function getPriceQtyTag(s, price, qty){
	 var tag 	= new StringBuffer();
	 tag.append("<div>");
	if(s == 'B'){
		tag.append("<span class=\"badge border border-success text-success\" style=\"width:100px;\">" + price + "</span>");
		tag.append("<span class=\"badge badge-success border border-success\" style=\"width:60px;\">" + qty + "</span> ");
	}else {
		tag.append("<span class=\"badge border border-danger text-danger\" style=\"width:100px;\">" + price + "</span>");
		tag.append("<span class=\"badge badge-danger border border-danger\" style=\"width:60px;\">" + qty + "</span> ");
	}
	 tag.append("</div>");
	return tag.toString();
}
function getTradeActionTag(p, s){
	if(s == 'B') return getActionTag(p, 'S');
	return getActionTag(p, 'B');
}
function getActionTag(p, s){
	 var position		= p == 'L' ? "Long" : "Short";
	 var side			= s == 'B' ? "Buy" : "Sell";
	 
	 var action		   = position;
	 if( p == 'L'){
		 action =  s == 'B' ? "Open Long" : "Close Long";
	 }else if(p == 'S') {
		 action =  s == 'B' ? "Close Short" : "Open Short";
	 }
	 var color 		= (action == 'Open Long' || action == 'Close Short') ? "success" : "danger"; 
	 var text_color	= "";
	 if(action == 'Close Long') color = "light text-danger";
	 else if(action == 'Close Short') color = "light text-success";
	 
	 var actionTag =  "  <span class=\"ml-2 badge badge-" + color + "\" style=\"width:80px;\">" + action+ " </span>";
	 return actionTag;
	 
}
function getOrders(id,bpage,blimit){
	var param 		= $("#pageForm").serialize();
		param 		+= "&id=" + id + "&bpage="+bpage+"&blimit="+blimit+"&symbol=XRPUSDT";
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/alarms";
	
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
					var alarms = res.alarms;
					//console.log(alarms);
					//updatePaging(res.vo);
					//var result 		= res.result;
					//var orders 		= res.orders.result.data;
					//console.log(orders);
				//	updateOrders(orders);
					
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

var sortOrders;
function updateOrders(orders){
	sortOrders = orders.sort(function(a, b){
		return  b.price- a.price;
	});
	$(".orders-area").html('');
	
   	 for(var i=0; i<sortOrders.length; i++){
			var order = sortOrders[i];
			$(".orders-area").append(getOrderTag(order));
			if(i < sortOrders.length - 1 && current_price > 0){
				var o2 = sortOrders[i+1];
				if(order.price > current_price && o2.price < current_price){
					$(".orders-area").append(getCurrentTag(current_price, order.price, o2.price));
				}
			}
		
   	 }
   	
}
function getOpenClose(side, reduce){
	if(side == 'Buy'){
		return !reduce;
	}else if(side == 'Sell'){
		return !reduce;
	}
	return false;
}
function getPosition_id(side, reduce){
	// 0 : one way, 1, Long , 2 : Short
	if(side == 'Buy'){
		return reduce ? 2: 1;
	}else if(side == 'Sell'){
		return reduce ? 1: 2;
	}
	return 0;
}
function getPosition(side, reduce){
	// Long   Buy,Reduce(false) : Open ,  Sell,Reduce(true)     : Close
	// Short  Buy,Reduce(true) 	: Close,  Sell,Reduce(false) 	: Open
	if(side == 'Buy'){
		return reduce ? "Close Short" : "Open Long";
	}else if(side == 'Sell'){
		return reduce ? "Close Long" : "Open Short";
	}
}
function getLoadAlarms(){
	getAlarms(user_id, 1,  50);
}
function getLoadOrders(){
	p_id = 0;
	getOrders(user_id,1,50);
	//getLoadAlarms();
	
}
function setReloadOrder(pid){
	p_id =pid;
	//updateOrders(sortOrders);
	getAlarms(user_id, 1,  50);
}

var p_id = 0; //1 short //2 long
var o_id = "all"; //open close

function getOrderTag(o){
	var side 	= o.side;
	var price 	= o.price;
	var qty	  	= o.qty;
	var reduce_only = o.reduce_only;
	var order_type	= o.order_type;
	var order_id	= o.order_id;
	var position_id = getPosition_id(side, reduce_only);
	var position	= getPosition(side, reduce_only);
	var is_open		= getOpenClose(side, reduce_only);
	var color 		= (position == 'Open Long' || position == 'Close Short') ? "success" : "danger"; 
	 var tcolor = position_id == 1  ? "badge badge-success" : "badge badge-danger";
	if(position_id != p_id){
	 var tag 	= new StringBuffer();
		 tag.append(" <a href=\"#\" class=\"list-group-item list-group-item-action flex-column align-items-start\">");
		 tag.append("  <div class=\"d-flex w-100 justify-content-between\">");
		 tag.append("  <strong class=\"mb-1  badge badge-"+color+"\" >"+position+" </strong>");
		 tag.append("  <strong style=\"text-align: right;\">"+comma(price)+"</strong>");
		 tag.append("  <strong style=\"text-align: right;\">"+comma(qty)+"</strong>");
		 tag.append("  <small class=\"btn btn-secondary\" onclick=\"del_order('"+order_id +"')\"><i class=\"fa fa-trash\"></i></small>");
		/*  tag.append("  <small class=\"btn btn-secondary\">취소</small>"); */
		 tag.append("   </div>");
	  
	     /* tag.append(" <div class=\"d-flex w-100 justify-content-between\">");
		 tag.append(" 	<small class=\""+tcolor+"\">"+(is_open ? "Open" : "Close")+"</small>");
		 tag.append("   <small>"+qty+"</small>");
		 tag.append("   <small>-125,000</small>");
		 tag.append("  </div>");  */
		 tag.append(" </a>");
		return tag.toString();
	}
	return "";
}
function del_order(order_id){
	if(order_id == null) return;
	var is_yes = confirm("Do you want to cancel?");
	if(!is_yes) return;
	var param 		= $("#pageForm").serialize();
	param 		+= "&user=" + user_id + "&order_id="+order_id + "&symbol=BTCUSDT";
	
	var REQ_TYPE 	= "post";
	var REQ_URL  	= "../bybit/order/cancel";
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
					console.log(str);
					var result 		= res.result;
					getLoadOrders();
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

 
function getCurrentTag(price, o1, o2){
	 var tag 	= new StringBuffer();
	 tag.append(" <a href=\"#\" class=\"list-group-item list-group-item-action flex-column align-items-start\">");
	 tag.append("  <div class=\"d-flex w-100 justify-content-between bg-warning\">");
	 tag.append("  <strong class=\"mb-1 text-left\" > "+comma(o1)+"</strong><small> (+"+ comma(o1-price)+")</small>");
	 tag.append("  <strong style=\"\">"+comma(price)+"</strong>");
	 tag.append("   <small> (-"+ comma(price-o2)+")</small> <strong class=\"mb-1 text-right\" > "+comma(o2)+"</strong>");
	 tag.append("   </div>");
  
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
					//bybitBalanceSet(user, usdt);
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
	current_price = close_price;
	
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
	setReloadOrder(p_id);
	

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
			getLoadOrders();
			getLoadAlarms();
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
function goPage(page){
	 $("#pageForm #curPage").val(page);
	//getBalanceList();
	getAlarms(user_id, page,  50);
 }
</script>

<%@ include file="navbar.jsp" %> 

<div class="container-fluid">

	<div class="row">
		<div class="col-sm-12  text-left">
			<span  class="text-dark" style="font-size:20px;font-weight:bold;;">
			<i class="fas fa-bell text-warning"></i><span style="padding-left:5px;">알람상태 	<strong id="today_date" style="font-size:10px;">0000-00-00</strong></span> 
			</span><br>
				<span style="font-size:12px;">
				현재가 : <span class="current_price"><i class="fas fa-arrow-up text-danger"></i><span>00000</span></span>
			 	, 1분거래량 : <span class="current_volume">0000</span>
			 	<i style="font-size:8px;">(<span id="today_time">00:00:00</span>)</i>
			 </span>
		</div>
		<div class="col-sm-6  text-left">
			 <form>
			  <div class="input-group mb-3">
			    <div class="input-group-prepend">
			      <span class="input-group-text">모드</span>
			    </div>
			      <select class="form-control" id="user_selector" name="user_selector">
			        <option value="idwook80" selected>모드80</option>
			        <option value="idwook01">모드01</option>
			        <option value="idwook02">모드02</option>
			      </select>
			  </div>
			</form>
		</div>
		<div class="col-sm-6  text-left">
			 <form>
			  <div class="input-group mb-3">
			    <div class="input-group-prepend">
			      <span class="input-group-text">심볼</span>
			    </div>
			      <select class="form-control" id="symbol_selector" name="symbol_selector">
			        <option value="BTCUSDT" selected>BTCUSDT</option>
			        <option value="XRPUSDT">XRPUSDT</option>
			      </select>
			  </div>
			</form>
		</div>
	 
 	</div>
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
										 <span class="text-right">
										  	<span class="btn btn-info" style='line-height:100%' onclick="setReloadOrder(0)">
										 	 	<span    class="" style="font-size:12px;"  >All</span>
										 	 </span>
										 	  <span class="btn btn-danger" style='line-height:100%'  onclick="setReloadOrder(1)">
										 	 	<span class="" style="font-size:12px;">Short</span>
										 	 </span>
										 	  <span class="btn btn-success" style='line-height:100%' onclick="setReloadOrder(2)">
										 	 	<span class="" style="font-size:12px;" >Long</span> 
										 	 </span>
										 	 
										 	 <span class="btn btn-light" style='line-height:100%'  onclick="showInputModal()">
										 	 	<span class="" style="font-size:12px;">Order</span>
										 	 </span>
										 	 
										 </span>
										 <span class="btn btn-light" style='line-height:100%'  onclick="getLoadAlarms()">
									 	 	<span class="" style="font-size:12px;">Reload</span>
									 	 </span>
	  								 </li>
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
	<div class="container-fluid">
	<div class="row">
	   <div class="col-sm-12">
  		<div class="row">
  		
			<div class="list-group col-sm-12 alarms-area">
			<!-- 
				  <div><li class="list-group-item d-flex justify-content-between align-items-center">
				     <div class="d-flex w-100 justify-content-between">
				      <span>alarm_id <br> alarm_id</span>
				      <span>symbol <br> alarm_id</span>
				      <span>trigger <br> alarm_id</span>
				      <span>is_over <br> alarm_id</span>
				      <span>position <br> alarm_id</span>
				      <span>side <br> alarm_id</span>
				       <span>repeat <br> alarm_id</span>
				        <span>alarm_kind <br> alarm_id</span>
				    </div>
				 </li></div> -->
			</div>
			 
			 <!--  
			<ul class="list col-sm-12 list-group">
              <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div class="d-flex flex-row align-items-center">
                        	<i class="fa fa-bell"></i> <i class="fa fa-handshake"></i> 	<i class="fa fa-check-circle checkicon"></i>
                        	<i class="fas fa-sign-out-alt "></i>  
                            
                          <div class="ml-2">
                                <div class="d-flex flex-row mt-1">
                                    <div><span class="ml-2">0.528</span><i class="ml-2 fa fa-arrow-up text-danger"></i></div>
                                   <div class="ml-3"><i class="fa fa-arrow-down"></i><span class="ml-2">6h</span></div>  
                                </div>
                                <div class="d-flex flex-row mt-1 text-black-50 date-time">
                                    <div><small><span class="ml-2">365</span></small></div>
                                   <div class="ml-3"><i class="fa fa-arrow-down"></i><span class="ml-2">6h</span></div> 
                                </div>
                            </div>
                        </div>
                        
                       <div class="d-flex flex-row align-items-center">
                        	 <div class="d-flex flex-column ml-2">
                        	 	<i class="fas fa-sign-out-alt"></i>
                        	 </div>
                           <div class="d-flex flex-column ml-2">
                                 <div class="profile-image">
                            		<span class="badge badge-danger">Open Short</span>
                               	</div>
                               	 <div class="d-flex flex-row mt-1 date-time">
                                    <div><small class="">0.5800</small><small class="ml-2">0.5800</small></div>
                                </div>
                           </div>
                           <span class="badge badge-primary badge-pill">99</span> 
                       </div>
                       
                       <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column mr-2">
                               <div class="profile-image">
                               	<img class="rounded-circle" src="https://i.imgur.com/xbxOs06.jpg" width="30">
                               	<img class="rounded-circle" src="https://i.imgur.com/KIJewDa.jpg" width="30">
                               	<img class="rounded-circle" src="https://i.imgur.com/wwd9uNI.jpg" width="30">
                               	</div>
                               <span class="date-time">11/4/2020 12:55</span>
                               </div>
                           <i class="fa fa-ellipsis-h"></i>
                       </div>
                </li>
                
                
                <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div class="d-flex flex-row align-items-center">
                        	 <span class="d-flex flex-row mt-1"><i class="fa fa-handshake" ></i></span>
                             <span class="d-flex flex-row mt-1"><span class="ml-2">XRPUSDT</span></span>
                       	</div>
                       	<div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                                     <div><span class="ml-2 badge">0.528</span><i class="ml-2 fa fa-arrow-up text-danger"></i></div>
                                </div>
                           </div>
                       	</div>
                       	 <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                               <span class="d-flex flex-row mt-1 badge">365</span>
                               <span class="d-flex flex-row mt-1 badge">365</span>
                           </div>
                       	</div>
                       	 <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                                 <div class="d-flex flex-row mt-1">
		                        	 <i class="fas fa-sign-out-alt"></i>
		                        	 <span class="ml-2 badge badge-danger">Open Short</span>
                                </div>
                                  <div class="d-flex flex-row mt-1">
			                        	 <i class="fas fa-sign-in-alt"></i>
			                        	 <span class="ml-2 badge badge-success">Close Long</span>
	                              </div>
                           </div>
                       	</div>
                       	  <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                                      <span class="badge border border-danger text-danger" style="width:100px;">0.5800</span>
                                 	  <span class="badge badge-danger" style="width:60px;">0.5800</span> 
                                </div>
                               	 <div class="d-flex flex-row mt-1">
                                 	  <span class="badge border border-success text-success" style="width:100px;">0.5800</span>
                                 	  <span class="badge badge-success" style="width:60px;">0.5800</span> 
                                </div>
                           </div>
                       	</div>
                        <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                                     <span class="badge badge-primary badge-pill">1</span> 
                                </div>
                               	 <div class="d-flex flex-row mt-1">
                                     <span class="badge badge-primary badge-pill">99</span> 
                                </div>
                           </div>
                           <div class="d-flex flex-column ml-2">
                             <i class="fa fa-ellipsis-h"></i>
                            </div>
                       	</div>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div class="d-flex flex-row align-items-center">
                             <span class="d-flex flex-row mt-1"><span class="ml-2">XRPUSDT</span></span>
                             <span class="d-flex flex-row mt-1"><i class="fa fa-handshake" ></i></span>
                       	</div>
                       	<div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                                     <div>
                                     <span class="ml-2 badge">0.528</span>
                                     <i class="ml-2 fa fa-arrow-up text-danger"></i>
                                     </div>
                                </div>
                                <div class="d-flex flex-row mt-1">
                                     <div>
                                     <span class="ml-2 badge">0.528</span>
                                     <span class="badge badge-danger">Open Short</span>
                                     </div>
                                </div>
                           </div>
                       	</div>
                        <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                                <div> 
		                         	<span class="ml-2 badge">365</span>
                                </div>
                           </div>
                       	</div>
                       	 <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                                <div> 
		                        	 <i class="fas fa-sign-out-alt"></i>
		                        	 <span class="badge badge-danger">Open Short</span>
                                
                                </div>
                           </div>
                       	</div>
                       	
                       	  <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                           			<div>
                                 	  <span class="badge border border-success text-success" style="width:100px;">0.5800</span>
                                 	  <span class="badge badge-success" style="width:60px;">0.5800</span> 
                                 	 </div>
                                </div>
                           </div>
                       	</div>
                        <div class="d-flex flex-row align-items-center">
                           <div class="d-flex flex-column ml-2">
                           		<div class="d-flex flex-row mt-1">
                                     <span class="badge badge-primary badge-pill">99</span> 
                                </div>
                           </div>
                           <div class="d-flex flex-column ml-2">
                             <i class="fa fa-ellipsis-h"></i>
                            </div>
                       	</div>
                </li> 
              </ul>    -->
  			 
  		</div>
	    </div>
	</div>
	</div>
	<hr>
	<%@include file="../_paging.jsp" %>
	
	
	<div class="container-fluid">
	<div class="row">
	   <div class="col-sm-12">
		<textarea id="printf" name="printf" rows="10"   style="width:100%;">
		</textarea>
		</div>
	</div>
	</div>
</div>
	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
 
 
 
<!-- The Modal Start-->
<div class="modal" id="input-modal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="#input-modal" onclick="hideInputModal()">&times;</button>
      </div>
      <div class="modal-header">
      	<ul class="nav nav-pills" style="width:100%;">
		  <li class="active"><a class="btn btn-success" data-toggle="pill" href="#home" style="width:100%;">Open</a></li>
		  <li> </li>
		  <li><a class="btn btn-danger" data-toggle="pill" href="#menu1">Close</a></li>
		</ul>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		 
       	 <style>
	     	#input-form-order .input-group-prepend .input-group-text{
	     	width:100px;
	     	}
	     </style>
		 <div class="col-sm-12" >
							<div class="card">
								<form class="card-body" id="input-form-order">
								  <input type="hidden" id="symbol" 		name="symbol" 	value="BTCUSDT">
								  <input type="hidden" id="user" 	name="user" 	value="">
								  <input type="hidden" id="side" 		name="side" 	value="Buy">
								  <input type="hidden" id="position_idx" name="position_idx" value="1">
								  
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text text-center">Order</span>
								    </div>
								    <input type="text" class="form-control" id="order_type" name="order_type" value="Limit">
								  </div>
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text text-center">Price</span>
								    </div>
								    <input type="text" class="form-control" id="price" name="price">
								  </div>
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text text-center">Qty</span>
								    </div>
								    <input type="text" class="form-control" id="qty" name="qty">
								  </div>
								</form>
							</div>
			</div>
						 
      </div>
      <!-- Modal footer -->
      <div class="modal-footer tab-content">
      		 
			  <div id="home" class="tab-pane active text-left">
			     <button type="button" class="btn btn-success" data-dismiss="input-modal" onclick="orderAction('Buy','1')">Open Long</button>
			     <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="orderAction('Sell', '2')">Open Short</button>
			  </div>
			  <div id="menu1" class="tab-pane fade text-right">
			 	 <button type="button" class="btn btn-success" data-dismiss="input-modal" onclick="orderAction('Buy','2')">Close Short</button>
			     <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="orderAction('Sell','1')">Close Long</button>
			  </div>
	  </div>

    </div>
  </div>
</div>
 <!-- The Modal End-->
<script type="text/javascript">
	function showInputModal(idx){
		selectToday(idx);
		showInputModal();
	}
	function showInputModal(){
		var user_id = $("#user_selector").val();
		$("#input-form-order #user").val(user_id);
		$("#input-modal").show();
		$(".modal-title").text("# " + user_id + " # Order Input");
	}
	function hideInputModal(){
		$("#input-modal").hide();
	}
	function orderAction(side, position_idx){
		 $("#input-form-order #side").val(side);
		 $("#input-form-order #position_idx").val(position_idx);
		 var msg = "";
		 if(side == 'Buy' && position_idx == '1') msg = 'Open Long';
		 if(side == 'Sell' && position_idx == '2') msg = 'Open Short';
		 if(side == 'Sell' && position_idx == '1') msg = 'Close Long';
		 if(side == 'Buy' && position_idx == '2')  msg = 'Close Short';
		 var price = $("#input-form-order #price").val();
		 var qty = $("#input-form-order #qty").val();
		 if(price == '' || qty == '') {
			 alert("Price & Qty Check!");
			 return;
		 }
		 orderCreate(msg);
	}
	function openLong(){
		 $("#input-form-order #side").val("Buy");
		 $("#input-form-order #position_idx").val("1");
		var param = $("#input-form-order").serialize();
		alert(param);
	}
	function openShort(){
		$("#input-form-order #side").val("Sell");
		$("#input-form-order #position_idx").val("2");
		alert('open short');
	}
	function closeLong(){
		$("#input-form-order #side").val("Sell");
		$("#input-form-order #position_idx").val("1");
		alert('close long');
	}
	function closeShort(){
		$("#input-form-order #side").val("Buy");
		$("#input-form-order #position_idx").val("2");
		alert('close short');
	}
	function orderCreate(msg){
		var is_yes = confirm("Do you want to " + msg + "?");
		if(!is_yes) return;
		var param = $("#input-form-order").serialize();
		
		var REQ_TYPE 	= "post";
		var REQ_URL  	= "../bybit/order/create";
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
						console.log(str);
						var result 		= res.result;
						getLoadOrders();
						if(status <= 100){
							hideInputModal();
						}else {
							ajaxLoadFail(result);
						}
			},
			error		: function() {
						ajaxError();
			}
		});
	}
</script>
 
</body>
    
    
    
</html>
