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
var current_price= 0.0
var user_id = '<%=user_id %>';
var exchange_usd = 0.125;

$(function(){
	$("#input-form-today #to_date").val(today_date);
/* 	$("#today_date").text(today_date); */
 	getTime();
	setInterval(function() {
			getTime();
		}, 1000);
	
	getBalancesList();
	
 	setTimeout(function() {
 		setInterval(function() {
 			getBalancesList();
 		}, 1000*30);
 		getLoadOrders();
	}, 1000);

	
	$("#user_selector").change(function(){
		//alert($(this).val());
		//alert($(this).children("option:selected").text());
		user_id = $(this).val();
		getLoadOrders();
	});
	$("#symbol_selector").change(function(){
		//alert($(this).val());
		var symbol = $(this).val();
		alert(symbol);
		if(symbol == 'XRPUSDT') getBalances();
		getLoadOrders();
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
 
 
function getOrders( id, bpage , blimit){
	
	var symbol 		= $("#symbol_selector").val();
	
	var param 		= $("#pageForm").serialize();
		param 		+= "&id=" + id + "&bpage="+bpage+"&blimit="+blimit + "&symbol="+symbol;
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/orders";
	
	
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
					if(res.orders.result != 'undefined'){
						var orders 		= res.orders.result.data;
						updateOrders(orders);
					}
				
					setReloadOrder(p_id);
					
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
function getLoadOrders(){
	//p_id = 0;
	getBalancesList();
	getOrders(user_id,1,50);
}
function setReloadOrder(pid){
	p_id =pid;
	updateOrders(sortOrders);
}
function updateOrders(orders){
	sortOrders = orders.sort(function(a, b){
		return  b.price- a.price;
	});
	$(".orders-area").html('');
	var buy_entry = 0.0;
	var buy_size  = 0.0;
	var sell_size = 0.0;
	var sell_entry = 0.0;
	var symbol = $("#symbol_selector").val();
	
	if(balances != null && balances != 'undefined'){
		var id = $("#user_selector").val();
		for(var i=0; i<balances.length; i++){
			var b = balances[i];
			var positions = b.positions;
			if(positions != null){
				var default_qty = b.default_qty;
				var buy 		= positions.result[0];
				var sell 		= positions.result[1];
				var buySize 	= (buy.size / parseFloat(default_qty))/10;
				var sellSize 	= (sell.size / parseFloat(default_qty))/10;
				buy_entry = buy.entry_price;
				sell_entry = sell.entry_price;
				buy_size = buy.size;
				sell_size = sell.size;
			 	if(id == b.id) {
			 		break;
			 	}
			}
			
		}
	}

	
   	 for(var i=0; i<sortOrders.length; i++){
			var order = sortOrders[i];
			$(".orders-area").append(getOrderTag(order));
			if(i < sortOrders.length - 1 && current_price > 0){
				var o2 = sortOrders[i+1];
				if(order.price > current_price && o2.price < current_price){
					//$(".orders-area").append(getCurrentTag(current_price, order.price, o2.price));
					if(symbol == 'XRPUSDT'){
						$(".orders-area").append(getEntryPostionTag(current_price.toFixed(3), buy_entry.toFixed(3), sell_entry.toFixed(3), buy_size, sell_size));
						
					}else {
						$(".orders-area").append(getEntryPostionTag(current_price.toFixed(2), buy_entry.toFixed(2), sell_entry.toFixed(2), buy_size, sell_size));
					}
				
				}
			}
		
   	 }
	 $(".cur_price").fadeOut();
     $(".cur_price").fadeIn("slow");
   	 //$('[data-toggle="popover"]').popover(); 
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

var p_id = 0; //1 short //2 long
var o_id = "all"; //open close
function getOrderTag(o){
	var side 		= o.side;
	var price 		= o.price;
	var qty	  		= o.qty;
	var reduce_only = o.reduce_only;
	var order_type	= o.order_type;
	var order_id	= o.order_id;
	var position_id = getPosition_id(side, reduce_only);
	var position	= getPosition(side, reduce_only);
	var is_open		= getOpenClose(side, reduce_only);
	var create_time_iso = new Date(o.created_time);
	var tooltip = create_time_iso.yyyymmddhhmmss();
	
	
	var color 		= (position == 'Open Long' || position == 'Close Short') ? "success" : "danger"; 
	var text_color	= "";
	if(position == 'Close Long') color = "light text-danger";
	else if(position == 'Close Short') color = "light text-success";
	
	var tcolor = position_id == 1  ? "badge badge-success" : "badge badge-danger";
	
	if(position_id != p_id){
	 var tag 	= new StringBuffer();
	 	 tag.append("<div data-toggle=\"tooltip\" title=\""+tooltip+"\">");
	 	 tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center\">");
		 tag.append("  <strong class=\"mb-1  badge badge-" + color + "\" >" + position+ " </strong>");
		 tag.append("  <strong style=\"text-align: right;\">"+comma(price)+"</strong>");
		 tag.append("  <strong style=\"text-align: right;\">"+comma(qty)+"</strong>");
	     tag.append("  <span><small class=\"btn btn-secondary\" onclick=\"del_order('"+order_id +"', '"+tooltip+"')\"><i class=\"fa fa-trash\"></i></small>"); 
	     tag.append("  <small class=\"btn btn-info\" onclick=\"detail_order('"+order_id +"')\"><i class=\"fa fa-info\"></i></small></span>");
	     tag.append("</li>");
		 tag.append("</div>");
	     /* tag.append(" <div class=\"d-flex w-100 justify-content-between\">");
		 tag.append(" 	<small class=\""+tcolor+"\">"+(is_open ? "Open" : "Close")+"</small>");
		 tag.append("   <small>"+qty+"</small>");
		 tag.append("   <small>-125,000</small>");
		 tag.append("  </div>");  */
		return tag.toString();
	}
	return "";
}
function detail_order(order_id){
	//alert(order_id);
 	 for(var i=0; i<sortOrders.length; i++){
			var order = sortOrders[i];
			if(order_id == order.order_id){
				var clone = {}; //Object.assign({}, order);
				var created = new Date(order.created_time);
				var updated = new Date(order.updated_time);
				clone.order_id 	= order.order_id;
				clone.symbol  	= order.symbol;
				clone.side		= order.side;
				clone.price		= order.price;
				clone.qty		= order.qty;
				clone.date 		= created.yymmdd();
				clone.time 		= created.hhmmss();
				
				var str 		= JSON.stringify(clone,null,2);
				alert(str);
				//alert(JSON.stringify(order,null,2));
				
			}
			
	 }
}
function del_order(order_id, tooltip){
	if(order_id == null) return;
	var is_yes = confirm("Date : "+ tooltip+ " \nDo you want to send cancel order?");
	if(!is_yes) return;
	var symbol 		= $("#symbol_selector").val();
	var param 		= $("#pageForm").serialize();
	param 		+= "&user=" + user_id + "&order_id="+order_id + "&symbol="+symbol;
	
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
function getEntryPostionTag(price, buy, sell, buy_size, sell_size){
	 var tag 	= new StringBuffer();
	 var plus   = price - buy;
	 var minus  = sell - price;
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	
	 tag.append(" <div class=\"d-flex w-100 justify-content-between\">");
	 tag.append("  <span class=\"btn border-danger text-danger\" style=\"font-weight=bold\" onclick=\"setReloadOrder(1)\"><small class=\"text-dark\">"+sell_size+"</small><br>"+comma(sell)+"<br><small class=\"text-dark\">("+ comma(minus.toFixed(2))+")</small></span>");
	 //tag.append("  <span class=\"btn border border-warning text-success\" style=\"display:flex;justify-content:center;align-items:center;\"> ");
	 tag.append("  <span class=\"btn border border-primary text-dark cur_price\" style=\"\"> ");
	 tag.append("  <small class=\"text-success\"><i class=\"fas fa-arrow-up\"></i>"+comma(price)+"</small><br>");
	 tag.append("  <strong calss=\"\" style=\"\">"+comma(price)+"</strong>");
	 tag.append("  <br><small class=\"text-danger\"><i class=\"fas fa-arrow-down\"></i>"+comma(price)+"</small>");
	 tag.append("  </span>");
	 
	 tag.append("  <span class=\"btn border-success text-success\" style=\"font-weight=bold\" onclick=\"setReloadOrder(2)\"><small class=\"text-dark\">"+buy_size+"</small><br>"+comma(buy)+"<br><small class=\"text-dark\">("+ comma(plus.toFixed(2))+")</small></span>");
	 tag.append("  </div>");   
	 tag.append("</li></div>");
	 
	return tag.toString();
}
function getCurrentTag(price, o1, o2){
	 var tag 	= new StringBuffer();
	 var plus   = o1-price;
	 var minus  = price-o2;
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center bg-warning\">");
	
	 tag.append(" <div class=\"d-flex w-100 justify-content-between\">");
	 tag.append("  <span><strong class=\"mb-1 text-left\" > "+comma(o1)+"</strong><br><small> (+"+ comma(plus.toFixed(3))+")</small></span>");
	 tag.append("  <span><strong style=\"\">"+comma(price)+"</strong></span>");
	 tag.append("  <span><strong class=\"mb-1 text-right\" > "+comma(o2)+"</strong><br><small> (-"+ comma(minus.toFixed(3))+")</small></span>");
	 tag.append("  </div>");   
	 tag.append("</li></div>");
	 
	return tag.toString();
}
function getBalances(){
	var symbol 		= $("#symbol_selector").val();
	var user_id		= $("#user_selector").val();
	
	var param 		= $("#pageForm").serialize();
	param += "&symbol=" + symbol + "&id="+user_id;
	
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../bybit/balances";
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
					var balance = res.balance;
					
					//console.log(balance);
					//var result 		= res.result;
					//var balances	 = res.balances;
					//exchange_usd = parseFloat(res.exchange_usd)/10000;
					//exchange_usd = exchange_usd - (exchange_usd/100*2);
					if(balances != 'undefined'){
						for(var i=0; i<balances.length; i++){
							var b = balances[i];
							if(balance.id == b.id){
								//console.log(b.id);
								 balances[i] = balance;
								 //console.log(b);
							}
						}
						//console.log(balances);
					}else {
						//console.log(balances);
					}
					//updateBalances(balances);
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

function getBalancesList(){
	var symbol 		= $("#symbol_selector").val();
	var param 		= $("#pageForm").serialize();
	param += "&symbol=" + symbol;
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
					var result 		= res.result;
					var balances	 = res.balances;
					exchange_usd = parseFloat(res.exchange_usd)/10000;
					exchange_usd = exchange_usd - (exchange_usd/100*2);
					
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
	//console.log(balances);
	balances = bs;
		
	$(".balances-area").html('');
	total_balance = 0.0;
	
	var kline		= balances[0].kline.result;
	bybitKline_1(kline[0]);
	for(var i=0; i<balances.length; i++){
		var balance = balances[i];
		$(".balances-area").append(getBalanceTag(balance));
	}
	for(var i=0; i<balances.length; i++){
		var b = balances[i];
		var className = ".bybit-area-"+b.id;
	}
	getBalanceBinance();
}
function getBalanceBinance(){
	var param 		= $("#pageForm").serialize();
	var REQ_TYPE 	= "get";
	var REQ_URL  	= "../binance/balance?id=binance01";
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
					setBalanceBinanceTag(res.Balance);
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
var total_balance = 0.0;
var balances;
function updateBalances(bs){
	balances = bs;
	getBalanceBinance();
}
function updateBalancess(balances){
	//this.balances = bs;
	$(".balances-area").html('');
	total_balance = 0.0;
	
	var kline		= balances[0].kline.result;
	bybitKline_1(kline[0]);
	for(var i=0; i<balances.length; i++){
		var b = balances[i];
		$(".balances-area").append(getBalanceTag(b));
	}

	$(".t_equity").text(comma(total_balance.toFixed(2)));
	$(".t_equity_won").text(comma((total_balance * exchange_usd).toFixed(0)));
    $(".t_exchange_won").text("("+comma((10000 * exchange_usd).toFixed(0))+")"); 
	
	//getBalanceBinance();
}
function getBalanceTag(b){
	//console.log(b);
	//if(b.id.startsWith('binance')) return;
	var positions = b.positions;
	var usdt	  = b.balance.result.USDT;
	
	var tag 	= new StringBuffer();
	tag.append("<ul class=\"list-group col-sm-6\" data-toggle=\"collapse\" data-target=\"#"+b.user_name+"\">");
	tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center bg-secondary text-light\">");
	tag.append(" <span><strong>" + b.user_name +"</strong></span>");
	tag.append(" <span class=\"text-right\">");
		 
	if(positions) tag.append(getPositionTag(b));
	else tag.append(getPositionTagNull());
	tag.append(" </span>");
	
	tag.append("	 </li>");
	tag.append("<div  id=\""+b.user_name+"\" class=\"bybit-area-"+b.id+"\" style=\"display:\"> ");
	
	tag.append(getBybitBalanceTag(usdt));
	
	tag.append("	</div></ul>");
	return tag.toString();
}
function setBalanceBinanceTag(b){
	var temp 		={};
	temp.user_name 	= "binance01";
	temp.id 		= "binance01";
	temp.positions	= null;
	temp.balance	= {};
	temp.balance.result	= {};
	temp.balance.result.USDT = b;
	
	if(balances != null && balances != 'undefined'){
		balances.push(temp);
		updateBalancess(balances);
	}

}
function setBalanceBinanceTags(b){
	//console.log(b);
	var temp = null;
	b.user_name 	= "binance01";
	b.id 			= "binance01";
	var usdt	  	= b;
	total_balance 	+= usdt.equity;
	usdt.wallet_balance  = total_balance;
	$(".t_equity").text(comma(total_balance.toFixed(2)));
	$(".t_equity_won").text(comma((total_balance * exchange_usd).toFixed(0)));
	
	var tag 	= new StringBuffer();
	tag.append("<ul class=\"list-group col-sm-6\" data-toggle=\"collapse\" data-target=\"#"+b.user_name+"\">");
	tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center bg-secondary text-light\">");
	tag.append(" <span><strong>" + b.user_name +"</strong></span>");
	tag.append(" <span class=\"text-right\">");
		 
	tag.append(getPositionTagNull());
	tag.append(" </span>");
	
	tag.append("	 </li>");
	tag.append("<div  id=\""+b.user_name+"\" class=\"bybit-area-"+b.id+"\" style=\"display:\"> ");
	
	tag.append(getBybitBalanceTag(usdt));
	
	tag.append("	</div></ul>");
	$(".balances-area").append(tag.toString());
}
function getPositionTag(b){
	var positions 	= b.positions;
	var default_qty = b.default_qty;
	var buy 		= positions.result[0];
	var sell 		= positions.result[1];
	if(buy == null || buy == 'undefined') return getPositionTagNull();
	if(sell == null || sell == 'undefined') return getPositionTagNull();
	var buySize 	= (buy.size / parseFloat(default_qty))/10;
	var sellSize 	= (sell.size / parseFloat(default_qty))/10;
	
	var tag 	= new StringBuffer();
		 	 
	tag.append(" 	  <span class=\"btn btn-danger\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">"+comma(sell.entry_price.toFixed(1))+"</span><br> ");
	tag.append("	 	 	<span style=\"font-size:8px;\">-"+sell.size+"("+sellSize.toFixed(1)+")</span>");
	tag.append("	 	 </span>");
	
	tag.append("	 	 <span class=\"btn btn-success\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">"+comma(buy.entry_price.toFixed(1))+"</span><br>");
	tag.append("	 	 	<span style=\"font-size:8px;\">"+buy.size+"(" +buySize.toFixed(1)+")</span>");
	tag.append("	 	 </span>");
	
	return tag.toString();
}

function getPositionTagNull(){
	var tag 	= new StringBuffer();
		 	 
	tag.append(" 	  <span class=\"btn btn-danger\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">###.##</span><br> ");
	tag.append("	 	 	<span style=\"font-size:8px;\">-##(##)</span>");
	tag.append("	 	 </span>");
	
	tag.append("	 	 <span class=\"btn btn-success\" style='line-height:80%'>");
	tag.append("	 	 	<span style=\"font-size:12px;\">###.##</span><br>");
	tag.append("	 	 	<span style=\"font-size:8px;\">##(##)</span>");
	tag.append("	 	 </span>");
	return tag.toString();
}
 
 var kline_1 = null;
function bybitKline_1(k){
	if(k == 'undefined') return;
	
	var open_price 	= k.open;
	var close_price = k.close;
	var volume = k.volume;
	var open_time 	= new Date(k.open_time *1000);
	var start_at 	= new Date(k.start_at*1000);
 	if(kline_1 != null){
 		if(kline_1.open_time == k.open_time){
 			
 		}else {
 			var pre_open_time 	= new Date(kline_1.open_time *1000);
 			//console.log(pre_open_time.yyyymmddhhmmss() +  " - " + open_time.yyyymmddhhmmss());
 			//console.log(kline_1);
 		}
 	}else {
 		//console.log(open_time.yyyymmddhhmmss());
 		//console.log(k);
 	}
	
	current_price = close_price;
	
	if(close_price < open_price){
		$(".current_price").html("<i class=\"fas fa-arrow-down text-danger\"></i><span class=\"text-danger\"> "+comma(close_price)+"</span>");
	}else {
		$(".current_price").html("<i class=\"fas fa-arrow-up text-success\"></i><span class=\"text-success\"> "+comma(close_price)+"</span>");
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
	kline_1 = k;

	setReloadOrder(p_id);
}
function getBybitBalanceTag(usdt){
	 var tag 	= new StringBuffer();
	 total_balance += usdt.equity;
	 tag.append(bybitTag("예상잔고", usdt.equity.toFixed(2)) );
	return tag.toString();
}
function bybitTag(key, value){
	 var tag 	= new StringBuffer();
	 tag.append("<div><li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	 tag.append("<span>" + key+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>$" + comma(value)+ "</span>");
	 else tag.append("<span class='text-danger p-value'>$" + comma(value)+ "</span>");
	 
	 if(value > 0) tag.append("<span class='text-success p-value'>￦" + comma((value * exchange_usd).toFixed(1))+ "</span>");
	 else tag.append("<span class='text-danger p-value'>￦" + comma((value * exchange_usd).toFixed(1))+ "</span>");
	 
	 tag.append("</li></div>");
	 
 	return tag.toString();
}
</script>

<%@ include file="navbar.jsp" %> 

<div class="container-fluid">

	<div class="row">
		<div class="col-sm-8  text-left">
			<span  class="text-dark" style="font-size:20px;font-weight:bold;;">
				<i class="fab fa-bitcoin text-warning"></i>
				<span style="padding-left:5px;">현재 상태
				<strong id="today_date" style="font-size:10px;">0000-00-00</strong>
				</span> 
			</span><br>
			<span  class="text-dark" style="font-size:20px;font-weight:bold;;">
				<i class="text-warning">$</i>
				<span class="t_equity text-success"></span> 
				<i class="text-warning" style="padding-left:3px;">￦</i>
				<span class="t_equity_won text-success"></span>
				
				<span class="t_exchange_won text-success" style="font-size:10px;">환율</span> 
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
	<div class="col-sm-12">
		<div class="row">
				<div class="container-fluid">
				 <div class="row">
				  <!-- Right Column -->
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
				    <div class="col-sm-12">
				  		<div class="row">
				  				
			  					<ul class="list-group col-sm-12">
									  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-light">
										 <span class="text-right">
										  	<span class="btn btn-info" style='line-height:100%' onclick="setReloadOrder(0)">
										 	 	<span    class="" style="font-size:12px;"  >전체</span>
										 	 </span>
										 	 <span class="btn btn-danger" style='line-height:100%' onclick="setReloadOrder(1)">
										 	 	<span class="" style="font-size:12px;" >Short</span> 
										 	 </span>
										 	 
										 	  <span class="btn btn-success" style='line-height:100%'  onclick="setReloadOrder(2)">
										 	 	<span class="" style="font-size:12px;">Long</span>
										 	 </span>
										 </span>
										  <span class="btn btn-light" style='line-height:100%'  onclick="getLoadOrders()">
									 	 	<span class="" style="font-size:12px;">조회</span>
									 	 </span>
									
	  								 </li>
							 	</ul>
							 	 <div class="list-group col-sm-12 orders-area">
						   		</div>
				  			 
				  		</div>
				  		<div class="row">
				  			
				  		
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
