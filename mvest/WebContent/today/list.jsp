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
	paramMap.put("perPage", (request.getParameter("perPage") != null ? (String) request.getParameter("perPage") : "10") );
	paramMap.put("search_param", "");
	paramMap.put("keyword", "");
	paramMap.put("sort", "");
	paramMap.put("order", "");
	
	paramMap.put("co_code", (request.getParameter("co_code") != null ? (String) request.getParameter("co_code") : ""));
	paramMap.put("co_name", (request.getParameter("co_name") != null ? (String) request.getParameter("co_name") : ""));
	paramMap.put("to_date", (request.getParameter("to_date") != null ? (String) request.getParameter("to_date") : ""));
	paramMap.put("to_date_start", (request.getParameter("to_date_start") != null ? (String) request.getParameter("to_date_start") : ""));
	paramMap.put("to_date_end", (request.getParameter("to_date_end") != null ? (String) request.getParameter("to_date_end") : ""));

%>
<%@ include file="common.jsp" %>
<body>
 <%=ParamUtil.DEFAULT_PAGE_FORM_START_TAG %>
 <%=ParamUtil.serializeForm(paramMap) %>
 <%=ParamUtil.DEFAULT_PAGE_FORM_END_TAG %>

<script type="text/javascript">
var today_date = '<%=tDate %>';
var today
var stocks;
var total_purchase 	= 0;
var total_evaluation 	= 0;
var total_profit		= 0;
var load_interval_min 	= 1000*60*30;

     $(function () {
    	 $("#input-form-today #to_date").val(today_date);
    	 $("#today_date").text(today_date);
    	 loadStocks();
    	 list();
    	 setInterval(function() {
    		 loadStocks();
		}, load_interval_min);
     });
     
      function loadStocks(){
    	 var now = new Date();
 		 var hour = now.getHours();
 		 var minutes = now.getMinutes();
 		 var day = now.getDay();
 		 
 		 if((day > 0 && day < 6) && (hour > 8 && hour < 16)){
 				load_interval_min = 1000 * 60 * 1;
 		 }else {
 			load_interval_min = 1000*60*30;
 		 }
 		/*  console.log(day + ","+hour + "," + minutes); */
 		 console.log(load_interval_min);
    	  
  		var REQ_TYPE 	= "get";
  		var REQ_URL  	= "../mystock/list?perPage=100";
  		var param 		= "";
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
  						var status 		= result.status;
  						var message 	= result.message;
  						var data		= result.data;
  						
  						//alert(result.result+"\n"+message);
  						
  						if(status <= 100){
  							var stocks = res.stocks;
  							updateStocks(stocks);
  						}else {
  							ajaxLoadFail(result);
  						}
  					 	
  			},
  			error		: function() {
  						ajaxError();
  			}
  		});
      }
      function updateStocks(list){
    	  this.stocks = list;
    	  console.log(list);
    	 
    	  $("#sel1").html('');
    	  $("#sel1").append("<option value=\"\"></option>");
    	  $("#company-body").html('');
    	  
    	  total_purchase 	= 0;
 		  total_evaluation  = 0;
 		  total_profit 		= 0;
 		 
    	  for(var i=0; i<list.length; i++){
    		  var item = list[i];
    		  $("#sel1").append("<option value="+item.co_code+">"+item.co_name+"</option>");
    		  $("#company-body").append(getStockTag(item,i));
    		  
    	  }
    	  total_profit = total_evaluation - total_purchase;
    	 var color = "";
    	 color = total_profit < 0 ? "blue" : total_profit == 0 ? "" : "red";
    	 if(total_profit < 0) color = "blue";
    	 
    	  $("#total-count").html(comma(total_purchase) + " , " + comma(total_evaluation) + " = <span style=\"color:"+color+";\">" + (comma(total_profit)) + "<span>");
    	  
      }
      function getStockTag(item, idx){
    	  
	     var tag 	= new StringBuffer();
	     var bal =  parseInt(item.ms_balance);
		 var avg = parseInt(item.ms_average);
		 var price = parseInt(item.ms_today);
		 var purchase = bal*avg;
		 var evaluation = Math.floor( (price*bal) - (price*bal) * 0.0025);
			
		 var profit = evaluation - purchase;
		 var perProfit = (price - avg) / ( avg / 100);
			 
		 total_purchase 	+= (bal*avg);
   		 total_evaluation 	+= (bal*price)
   		 total_profit 		+= profit;
   		 
   		 var previous = parseFloat(item.ms_previous);
		 var color = previous < 0 ? "blue" : previous == 0 ? "gray" : "red";
			 var arrow = previous < 0 ? "fas fa-arrow-down" : previous == 0 ? "" : "fas fa-arrow-up";
			 var updown = previous < 0 ? "fas fa-caret-down" : previous == 0 ? "" : "fas fa-caret-up";
			 
   		 var per = 0.01;
   		 var tmp  = Math.round(avg * per) + avg;
   		 
   		 while(tmp < price){
   			 per += 0.01;
   			 tmp  = Math.round(avg * per) + avg;
   			 if(per > 0.20) break;
   		 }
			 
		  	 color = previous < 0 ? "blue" : previous == 0 ? "black" : "red";
		  	 
		  	 var ms_y = parseInt(item.ms_yesterday);
		  	 var ration = (previous)/(ms_y/100);
		  	 
		  	 var isOnOff = "";
		  	 var isEmg = false;
		  	 if((ration > 1 && ration < 2) || (ration < -1 && ration  > -2) ){
		  		isOnOff = "onOff slow";
		  		isEmg = true;
		  	 }else if(ration > 2 || ration < -2){
		  		isOnOff = "onOff";
		  		isEmg = true;
		  	 }
    	  	 isEmg = false;
    	  	
	    	 tag.append("<tr class=\"text-center\" onclick=\"selectStock("+idx+");\">"); 
	    	 if(isEmg) {
	    		 var ss = idx%3;
	    		 tag.append("<td class=\"emg"+(ss+1)+"\">");
	    	 }else tag.append("<td>");
			 tag.append("<div><br></div>");
			 tag.append("<div style=\"padding-top:2px;\">" + item.co_name + "</div>");
			 tag.append("</td>");
			 
			 tag.append("<td>");
			 tag.append("<div><br></div>");
			 tag.append("<div style=\"padding-top:2px;\">" +  comma(item.ms_balance) + "</div>");
			 tag.append("</td>");
			 
			 
			 tag.append("<td>");
			 tag.append("<div><br></div>");
			 tag.append("<div style=\"padding-top:2px;\">" +  comma(item.ms_average) + "</div>");
			 tag.append("</td>");
			 
			 tag.append("<td>");
			 tag.append("<div><select class=\"custom-select\">");
			 var tmp =0;
			 for(var i=0.01; i<0.05;){
				 var val = (parseInt(item.ms_average) * i)  + parseInt(item.ms_average);
				 var isSelect = false;
				 
				 tag.append("<option  >"+ (i*100).toFixed(0) +"% "+comma(String(val.toFixed(0)))+"</option>");
				 i += 0.01;
			 }
			
			 tag.append("<d/iv></select>");
			 tag.append("</td>");
			 
			 
		  	 
		  	 tag.append("<td>");
		  	 tag.append("<div style=\"color:gray;font-size:10px;\">" + comma(item.ms_yesterday) + "</div>");
		  	 tag.append("<div class=\""+isOnOff+"\" style=\"padding-top:2px;color:" + color + ";\" ><strong>" + comma(item.ms_today)  + "</strong></div>");
		  	 tag.append("</td>");
		  	 
		  	 tag.append("<td>");
		  	 
		  	 tag.append("<div style=\"color:" + color + ";font-size:10px;\">" + ration.toFixed(2) + "%</div>");
		  	 
		  	tag.append("<div><span class='" + updown + "' style=\"color:" + color + ";\"></span><span style=\"font-size:12px;color:"+color+"\">"+comma(item.ms_previous) +"</span></div>");
		  	 tag.append("</td>");
		  	 
		  	 
		  	 
			 color = profit < 0 ? "blue" : profit == 0 ? "gray" : "red";
		  	 tag.append("<td>");
		  	 tag.append("<div>" +  comma(purchase) + "</div>");
		  	 tag.append("<div style=\"padding-top:4px;color:" + color + ";\">" +  comma(evaluation) + "</div>");
		  	 tag.append("</td>");
		  	 
		  	 
			 /* tag.append("<td><span class=\"badge badge-pill badge-danger\" style=\"font-size:5px;\">"+(per*100).toFixed(0)+"%</span> " +  comma(tmp) + "</td>"); */
			
			 color = profit < 0 ? "blue" : profit == 0 ? "gray" : "red";
			 tag.append("<td style=\"color:" + color + ";\">");
			 tag.append("<div>"+perProfit.toFixed(2)+"%</div>");
			 tag.append("<div style=\"padding-top:4px;\">" + comma(String(profit)) + "</div>");
			 tag.append("</td>");
			 
			 
			 tag.append("<td>");
			 tag.append("<div class=\"row\">");
				 
				 tag.append("<div class=\"col\">");
				 tag.append(getBuyTag(item.ms_buy_1, item.ms_today));
				 tag.append(getBuyTag(item.ms_buy_2, item.ms_today));
				 tag.append("</div>");
				 
				 tag.append("<div class=\"col\">");
				 tag.append(getSellTag(item.ms_sell_1, item.ms_today));
				 tag.append(getSellTag(item.ms_sell_2, item.ms_today));
				 tag.append("</div>");
				 
			 tag.append("</div>");
			 tag.append("</td>");
			 
			 tag.append("<td class=\"text-right\" style=\"padding:0; padding-top:2px;\">");
			 tag.append("<div class=\"btn-group-vertical\" >");
			 tag.append("<button type=\"button\" style=\"margin:2px;\" class=\"btn btn-secondary btn-sm\" onclick=\"showTrModal("+idx+")\"><i class=\"fas fa-exchange-alt\"></i></button>");
			 tag.append("<button type=\"button\" style=\"margin:2px;\" class=\"btn btn-secondary btn-sm\" onclick=\"showTrModal("+idx+")\"><i class=\"fas fa-edit\"></i></button>");
			 tag.append("</div>")
			 tag.append("</td>");
			 
			 tag.append("</tr>");
			 
	    	 return tag.toString();
      }
      
      function getSellTag(sell, price){
    	  var tag 	= new StringBuffer();
    	  var color = "black";
    	  var value = "-";
    	  
    	  
    	  if(sell != ""){
    		 
    		  var max_sell = parseInt(sell) + Math.round(parseInt(sell) * 0.0025);
    		  var min_sell = parseInt(sell) + Math.round(parseInt(sell) * -0.0025);
    		  max_sell = (max_sell/10).toFixed(0) * 10;
    		  min_sell = (min_sell/10).toFixed(0) * 10;
    		  
    		  value = comma(String(min_sell)) + " ~ " +comma(String(max_sell));
    		  
    		  if(min_sell < parseInt(price)){
    			  value = "<i class='fas fa-hand-point-right onOff slow'></i><strong>" + value + "</strong>";
    			  color = "red";
    		  }
    		
    	  }
    	  tag.append("<div style=\"padding-top:2px;color:"+color+"\">"+  value + "</div>");
    	  return tag.toString();
      }
      
      function getBuyTag(buy, price){
    	  var tag 	= new StringBuffer();
    	  var color = "black";
    	  var value = "-";
    	  
    	  
    	  if(buy != ""){
    		  var max_buy = parseInt(buy) + Math.round(parseInt(buy) * 0.0025);
    		  var min_buy = parseInt(buy) + Math.round(parseInt(buy) * -0.0025);
    		  max_buy = (max_buy/10).toFixed(0) * 10;
    		  min_buy = (min_buy/10).toFixed(0) * 10;
    		  
    		  
    		  value = comma(String(max_buy)) + " ~ " +comma(String(min_buy));
    		  
    		  if(max_buy > parseInt(price) ){
    			  value = "<i class='fas fa-hand-point-right onOff slow'></i><strong>" + value + "</strong>";
    			  color = "blue";
    		  } 
    		  
    		
    	  }
    	  tag.append("<div style=\"padding-top:2px;color:"+color+"\">"+  value + "</div>");
    	  return tag.toString();
      }
      function selectStock(idx){
    	  var co = stocks[idx];
    	  $("#pageForm #co_code").val(co.co_code);
    	  list();
    	  $("#input-form-today #to_date").val(co.to_date);
    	  $("#input-form-today #to_balance").val(comma(co.ms_balance));
    	  $("#input-form-today #to_average").val(comma(co.ms_average));
    	  $("#input-form-today #to_price").val(comma(co.ms_today));
    	  $("#input-form-today #co_name").val(co.co_name);
    	  $("#input-form-today #co_code").val(co.co_code);
    	  setStockItem(idx);
    	  
      }
	  function list(){
	    		var param 		= $("#pageForm").serialize();
	    		var REQ_TYPE 	= "get";
	    		var REQ_URL  	= "../today/list";
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
	    						var status 		= result.status;
	    						var message 	= result.message;
	    						var data		= result.data;
	    						
	    						//alert(result.result+"\n"+message);
	    						
	    						if(status <= 100){
	    							var todays = res.todays;
	    							console.log(todays);
	    							/* updateTotal(res.total);*/
	    							updateList(todays);
	    							updatePaging(res.vo); 
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
		  	this.todays = list;
	    	 $("#today-body").html('');
	    	 if(list){
		    	 for(var i=0; i<list.length; i++){
					var item = list[i];
					$("#today-body").append(getItemTag(item,i));
		    	 }
		    	
	    	 }
	    	 //updateTodayList(list);
	  }
	  function getItemTag(item,idx){
		  var tag 	= new StringBuffer();
	    	// var link 	= "../group/group_site_list.jsp?gr_id="+g.gr_id+"&list_page="+$("#pageForm #curPage").val();
	    	 var profit = parseFloat(item.to_profit);
	    	 var color = profit < 0 ? "blue" : profit == 0 ? "gray" : "red";
	     
	    		/*   tag.append("<tr class=\"text-center\" onclick=\"selectToday("+idx+");\">"); */
	    	 tag.append("<tr class=\"text-center\">");
			 tag.append("<td>" + item.to_id + "</td>");
			 tag.append("<td>" + item.to_date + "</td>");
			 tag.append("<td>" + item.co_code + "</td>");
			 tag.append("<td>" + item.co_name + "</td>");
			 
			 tag.append("<td>" + comma(item.to_balance) + "</td>");
			 tag.append("<td style=\"color:"+color+";\">" + comma(item.to_average) + "</td>");
			 tag.append("<td>" + comma(item.to_price) + "</td>");
			 tag.append("<td style=\"color:"+color+";\">" + comma(item.to_price - item.to_average) + "</td>");
			 
			 tag.append("<td>" + comma(item.to_purchase) + "</td>");
			 tag.append("<td>" + comma(item.to_evaluation) + "</td>");
			
			 tag.append("<td style=\"color:"+color+";\">" + comma(item.to_profit) + "</td>");
			 if(profit < 0){
				 tag.append("<td style=\"color:blue;\"><i class='fas fa-arrow-down'></i></td>");
			 }else {
				 tag.append("<td style=\"color:red;\"><i class='fas fa-arrow-up'></i></td>");
			 }
			 
			 var ration = parseFloat(item.to_ration);
			 tag.append("<td style=\"color:"+color+";\">" + ration.toFixed(2)+ "%</td>");
			 
			 tag.append("</tr>");
			 
	    	 return tag.toString();
	  }
	  
	  function selectToday(idx){
		 var to = todays[idx];
		  
		 $("#input-form-today #to_id").val(to.to_id);
		 $("#input-form-today #to_date").val(to.to_date);
		 $("#input-form-today #co_code").val(to.co_code);
		 $("#input-form-today #co_name").val(to.co_name);
		 
		 $("#input-form-today #to_balance").val(comma(to.to_balance));
		 $("#input-form-today #to_average").val(comma(to.to_average));
		//$("#input-form-today #to_price").val(comma(to.to_price));
		 
		 $("#input-form-today #to_purchase").val(comma(to.to_purchase));
		 $("#input-form-today #to_evaluation").val(comma(to.to_evaluation));
		 
		 $("#input-form-today #to_profit").val(comma(to.to_profit));
		 $("#input-form-today #to_ration").val(comma(to.to_ration));
		  
		  
		  
		  
	  }
	  
	  function goPage(page){
      	 $("#pageForm #curPage").val(page);
      	 list();
       }
	  function changedItem(){
		  var co_code = $("#sel1 option:selected ").val();
		  var to_date = $("#in_date").val();
		  
		  $("#pageForm #to_date").val(to_date);
		  $("#pageForm #co_code").val(co_code);
		  list();
	  }
	  
	  
	  function addToday(){
		var param 		= $("#input-form-today").serialize();
  		var REQ_TYPE 	= "post";
  		var REQ_URL  	= "../today/add";
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
  						var status 		= result.status;
  						var message 	= result.message;
  						var data		= result.data;
  						
  						alert(result.result+"\n"+message);
  						
  						if(status <= 100){
  							changedItem();
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
	  function addAllToday(){
		  
		  var isOk = confirm("오늘 전체 결과를 업로드 합니까?");
		  if(!isOk) return;
		  
		  
    	  for(var i=0; i<stocks.length; i++){
    		  var co = stocks[i];
    		  
    		  var param = "to_date=" + co.to_date;
    		  param += "&to_balance=" + co.ms_balance;
    		  param += "&to_average=" + co.ms_average;
    		  param += "&to_price=" + co.ms_today;
    		  param += "&co_name=" + co.co_name;
    		  param += "&co_code=" + co.co_code;
    		  
    		console.log(param);
    		var REQ_TYPE 	= "post";
   	  		var REQ_URL  	= "../today/add";
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
   	  						var status 		= result.status;
   	  						var message 	= result.message;
   	  						var data		= result.data;
   	  						
   	  						
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
    	  alert("완료되었습니다.");
	  }
  </script>
<%@ include file="navbar.jsp" %>
 <style>
 	tr {
		   line-height: 10px;
		}
	#company-body tr {
		line-height:10px;
	}
	#company-body td {
		line-height: 10px;
		height:10px;
	}
	/****************************** ON & OFF CSS animation ***********************************/
.onOff {
	-webkit-animation: onOff-css 1s 1s 1 linear normal both;
    -moz-animation: 	onOff-css 1s 1s 1 linear normal both;
    -ms-animation: 		onOff-css 1s 1s 1 linear normal both;
    -o-animation: 		onOff-css 1s 1s infinite linear normal both;   
	animation: 			onOff-css 2s 0s infinite linear normal;
}
.onOff.slow {
	-webkit-animation: onOff-slow-css 3s 1s 2 linear normal both;
    -moz-animation: 	onOff-slow-css 3s 1s 2 linear normal both;
    -ms-animation: 		onOff-slow-css 3s 1s 2 linear normal both;
    -o-animation: 		onOff-slow-css 3s 1s infinite linear normal both;   
	animation: 			onOff-slow-css 3s 1s infinite linear normal;
}
@keyframes onOff-css {  
	0%  { opacity: 0.8; }
	25% { opacity: 0;}
	50% { opacity: 0.8;}
	75% { opacity: 0;}
   100% { opacity: 0.8; }
}
@keyframes onOff-slow-css {  
	0%  { opacity: 1; }
	25% { opacity: 0.2;}
	50% { opacity: 1;}
	75% { opacity: 0.2;}
   100% { opacity: 1; }
}
@keyframes emg-css {  
	0%  { border:1px solid red; }
	25% { border:1px solid white;}
	50% { border:1px solid blue;}
	75% { border:1px solid white;}
   100% { border:1px solid green; }
}

.emg1 {
	-webkit-animation: emg-css 1s 1s 1 linear normal both;
    -moz-animation: 	emg-css 1s 1s 1 linear normal both;
    -ms-animation: 		emg-css 1s 1s 1 linear normal both;
    -o-animation: 		emg-css 1s 1s infinite linear normal both;   
	animation: 			emg-css 1s 0s infinite linear normal;
}
.emg2 {
	-webkit-animation: emg-css 1s 1s 1 linear normal both;
    -moz-animation: 	emg-css 1s 1s 1 linear normal both;
    -ms-animation: 		emg-css 1s 1s 1 linear normal both;
    -o-animation: 		emg-css 1s 1s infinite linear normal both;   
	animation: 			emg-css 2s 0s infinite linear normal;
}
.emg3 {
	-webkit-animation: emg-css 1s 1s 1 linear normal both;
    -moz-animation: 	emg-css 1s 1s 1 linear normal both;
    -ms-animation: 		emg-css 1s 1s 1 linear normal both;
    -o-animation: 		emg-css 1s 1s infinite linear normal both;   
	animation: 			emg-css 3s 0s infinite linear normal;
}
  	
	
	
</style>
<div class="container-fluid row">
		 <!-- Left Column -->
		 <%@ include file="right.jsp" %>  
  
		<!-- Center Column -->
		<div class="col-sm-10">
		
			<!-- Alert -->
			<!-- <div class="alert alert-success alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<strong>Synergize:</strong> Seamlessly visualize quality intellectual capital!
				<p>
				<p><button class="btn btn-outline-primary">Read More</button>
			</div>	 -->	
			<!-- Articles -->
			<div class="row">
				<div class="title container-fluid">
					<div class="row">
					    <div class="col-sm-6"><h4> <span class="badge badge-secondary"><i class='fas fa-calendar-day'></i> 오늘 현황</span></h4></div>
					    <div class="col-sm-6 text-right"><span class="text-right text-dark"><strong>Today : </strong><strong id="today_date">2021-01-01</strong></span></div>
				   	</div>
				   <hr>
				 	<div class="table-responsive" style="min-height:400px;">
						  <table class="table table-hover table-striped">
						    <thead class="thead-dark">
						      <tr class="text-center" >
						      	<!-- <th>Date</th> -->
						       <!--  //<th>ID</th> -->
						        <th>종목</th>
						        <th>잔고</th>
						        <th>평균</th>
						        <th>평균대비</th>
						        <th>가격</th>
						        <th>대비</th>
						        <th>합계</th>
						        <th>수익</th>
						        <th style="width:30%;">비율</th>
						        <th style="margin:0px;padding:0px;">
						        	<button class="btn btn-sm btn-secondary" onclick="addAllToday()" style="margin:0px;"><i class="fas fa-upload"></i></button>
						        </th>
						      </tr>
						    </thead>
						    <tbody id="company-body">
						    </tbody>
						  </table>
				     </div>
				      <hr>	
				      
				      <div class="container-fluid text-right" >
					    <span class="" id="list-total" style="float:left;">Total (<span id="total-count">0</span>)</span>
					   <form class="form-inline" style="float:right;margin-bottom:10px;">
						   <div class="form-group" style="padding: 5px;">
						      <label for="date">Date:</label>
						    	<input type="text" class="form-control" id="in_date" >
						  </div>
						   <div class="form-group" style="padding: 5px;">
						      <select  id="sel1" onchange="changedItem()" class="form-control">
						    	<option value="all"></option>
						  		</select>
						  </div>
						  <div class="form-group" style="padding: 5px;">
						      	<button type="button" class="btn btn-success form-control" data-toggle="modal" data-target="#groupModal" onclick="showInputModal()">추가</button>
						        <button type="button" class="btn btn-warning form-control" data-toggle="modal" data-target="#groupModal" onclick="showInputModal()">수정</button>
						      	<button type="button" class="btn btn-danger form-control" data-toggle="modal" data-target="#groupModal" onclick="addModal()">삭제</button>
						      	<button type="button" class="btn btn-info form-control" data-toggle="modal" data-target="#groupModal" onclick="changedItem()">정보</button>
						  </div>
						</form>
					  </div>
					  
					    <div class="table-responsive" style="min-height:400px;">
						  <table class="table table-hover table-striped">
						    <thead class="thead-dark">
						      <tr class="text-center">
						        <th>번호</th>
						        <th>날짜</th>
						        <th>코드</th>
						        <th>종목</th>
						        <th>잔고</th>
						        <th>평균가</th>
						        <th>현재가</th>
						        <th>대비</th>
						        <th>구입</th>
						        <th>평가</th>
						        <th>수익</th>
						        <th><i class='fas fa-arrow-up'></i><i class='fas fa-arrow-down'></i></th>
						        <th>수익률</th>
						      </tr>
						    </thead>
						    <tbody id="today-body">
						    </tbody>
						  </table>
						   <%@include file="../_paging.jsp" %>
				  		</div>
				     
				     
				    
				
				</div>
			</div>
		 	
		    <%@ include file="chart.jsp" %> 
			<hr>
			<div class="row">
				<article class="col-xs-12">
					<h2>Proactively Envisioned</h2>
					<p>Seamlessly visualize quality intellectual capital without superior collaboration and idea-sharing. Holistically pontificate installed base portals after maintainable products. Proactively envisioned multimedia based expertise and cross-media growth strategies.</p>
					<p><button class="btn btn-outline-primary">Read More</button></p>
					<p class="pull-right"><span class="tag tag-default">keyword</span> <span class="tag tag-default">tag</span> <span class="tag tag-default">post</span></p>
					<ul class="list-inline">
						<li class="list-inline-item"><a href="#">Yesterday</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-comment"></span> 21 Comments</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-share"></span> 36 Shares</a></li>
					</ul>
				</article>
			</div>
			<hr>      
			<div class="row">
				<article class="col-xs-12">
					<h2>Completely Synergize</h2>
					<p>Completely synergize resource taxing relationships via premier niche markets. Professionally cultivate one-to-one customer service with robust ideas. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>
					<p><button class="btn btn-outline-danger">Read More</button></p>
					<p class="pull-right"><span class="tag tag-default">keyword</span> <span class="tag tag-default">tag</span> <span class="tag tag-default">post</span></p>
					<ul class="list-inline">
						<li class="list-inline-item"><a href="#">2 Days Ago</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-comment"></span> 12 Comments</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-share"></span> 18 Shares</a></li>
					</ul>
				</article>
			</div>
		</div>
		
		<!--/Center Column-->
	  <!-- Right Column -->
    	<%--  <%@ include file="right.jsp" %>  --%>
    	 <!--/ Right Column -->

	</div>
	<!--/container-fluid-->
	
	<!-- Tail Column -->
     <%@ include file="tail.jsp" %>
     
     
    
    
    
    <!-- The Modal -->
<div class="modal" id="input-modal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="#input-modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        	 <style>
					     	#input-form-today .input-group-prepend .input-group-text{
					     	width:100px;
					     	}
					     </style>
						<div class="col-sm-12" >
							<div class="card">
							<div class="card-header p-b-0 bg-dark">
								<h5 class="card-title text-light"><i class="fa fa-cog" aria-hidden="true"></i> Input Today</h5>
							</div>
							<form class="card-body" id="input-form-today">
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text">No</span>
								    </div>
								    <input type="text" class="form-control" id="to_id" name="to_id">
								    
								    <div class="input-group-prepend">
								       <span class="input-group-text">Date</span>
								    </div>
								    <input type="text" class="form-control" id="to_date" name="to_date">
								  </div>
								  
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Code</span>
								    </div>
								    <input type="text" class="form-control" id="co_code" name="co_code">
								    
								    <div class="input-group-prepend">
								       <span class="input-group-text">Name</span>
								    </div>
								    <input type="text" class="form-control" id="co_name" name="co_name">
								  </div>
								  
								  
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Balance</span>
								    </div>
								    <input type="text" class="form-control" id="to_balance" name="to_balance">
								    
								     <div class="input-group-prepend">
								       <span class="input-group-text">Average</span>
								    </div>
								    <input type="text" class="form-control" id="to_average" name="to_average">
								  </div>
								  
								   <div class="input-group mb-3">
								    <div class="input-group-prepend">
								       <span class="input-group-text">Price</span>
								    </div>
								    <input type="text" class="form-control" id="to_price" name="to_price">
								  </div>
								  
								  <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Purchase</span>
								    </div>
								    <input type="text" class="form-control" id="to_purchase" name="to_purchase">
								    
								     <div class="input-group-prepend">
								       <span class="input-group-text">Evaluation</span>
								    </div>
								    <input type="text" class="form-control" id="to_evaluation" name="to_evaluation">
								    
								  </div>
								  
								   <div class="input-group mb-3">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Profit</span>
								    </div>
								    <input type="text" class="form-control" id="to_profit" name="to_profit">
								    
								     <div class="input-group-prepend">
								       <span class="input-group-text">Ration</span>
								    </div>
								    <input type="text" class="form-control" id="to_ration" name="to_ration">
								  </div>
							 
								</form>
							</div>
						</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-success" data-dismiss="input-modal" onclick="addToday()">Ok</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="hideInputModal()">Close</button>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
	function showInputModal(idx){
		selectToday(idx);
		showInputModal();
	}
	function showInputModal(){
		$("#input-modal").show();
	}
	function hideInputModal(){
		$("#input-modal").hide();
	}
</script>


   <!-- The Modal -->
<div class="modal" id="tr-modal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header bg-dark">
     
        <h4 class="modal-title text-light"><i class="fa fa-cog" aria-hidden="true"></i> 매수/매도</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body col-sm-12">
        	 <style>
		     	#tr-form-today .input-group-prepend .input-group-text{
		     	width:100px;
		     	}
		     </style>
					 
			<form class="card-body" id="tr-form-today">
					<input type="hidden" id="tr_type" name="tr_type" value="buy" />
				 	<div class="input-group mb-3">
					     <div class="input-group-prepend">
					       <span class="input-group-text">Date</span>
					    </div>
					    <input type="text" class="form-control" id="tr_date" name="tr_date">
					    
					    <div class="input-group-prepend">
					       <span class="input-group-text">Bank</span>
					    </div>
					    <input type="text" class="form-control" id="bk_id" name="bk_id">
					  </div>
					  
					  <div class="input-group mb-3">
					     <div class="input-group-prepend">
					       <span class="input-group-text">종목코드</span>
					    </div>
					    <input type="text" class="form-control" id="co_code" name="co_code">
					    
					    <div class="input-group-prepend">
					       <span class="input-group-text">종목명</span>
					    </div>
					    <input type="text" class="form-control" id="co_name" name="co_name">
					  </div>
					  
					  <div class="input-group mb-3">
					    
					    <div class="input-group-prepend">
					       <span class="input-group-text">수량</span>
					    </div>
					    <input type="text" class="form-control comma-enable" id="tr_quantity" name="tr_quantity">
					    
					    <div class="input-group-prepend">
					       <span class="input-group-text">단가</span>
					    </div>
					    <input type="text" class="form-control comma-enable" id="tr_price" name="tr_price">
					    
					  </div>
			</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger" data-dismiss="tr-modal" onclick="addTransaction('buy')">매수</button>
      	<button type="button" class="btn btn-primary" data-dismiss="tr-modal" onclick="addTransaction('sell')">매도</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="hideTrModal()">취소</button>
      </div>

    </div>
  </div>
</div>
<script type="text/javascript">
	$(function(){
		$(".comma-enable").on("keyup",function(event){
			var selection = window.getSelection().toString();
			if ( selection !== '' ) {
		        return;
		    }
		 
		    // 2. 위 화살표 입력 시 + $step, 아래 화살표 입력 시 - $step
		    var extra = 0;
		    var $step = 1;
		    if ( $.inArray( event.keyCode, [38,40,37,39] ) !== -1 ) {
		      if (event.keyCode == 38) {
		        extra = $step;
		      } else if (event.keyCode == 40) {
		        extra = -$step;
		      } else {
		        return;
		      }
		    }
		  
		    // 3
		    var $this = $( this );
		    var input = $this.val();
		 
		    // 4
		    var input = input.replace(/[\D\s\._\-]+/g, "");
		 
		    // 5. 입력 값에 화살표 입력에 따른 증가/감소 
		    input = input ? parseInt( input, 10 ) : 0;
		    input += extra;
		    extra = 0;
		 
		    // 6
		    $this.val( function() {
		        return ( input === 0 ) ? "" : input.toLocaleString( "en-US" );
		    });
		});
	});
	
	function showTrModal(idx){
		var ms = stocks[idx];
		$("#tr-form-today #tr_date").val(ms.to_date);
		$("#tr-form-today #bk_id").val(ms.bk_id);
		$("#tr-form-today #co_code").val(ms.co_code);
		$("#tr-form-today #co_name").val(ms.co_name);
		$("#tr-form-today #tr_price").val('');
		$("#tr-form-today #tr_quantity").val('');
		
		
		$("#tr-modal").modal('show');
	}
	function hideTrModal(){
		$("#tr-modal").modal('hide');
	}
	function addTransaction(type){
			$("#tr-form-today #tr_type").val(type);
			var price = $("#tr-form-today #tr_price").val();
			var qty = $("#tr-form-today #tr_quantity").val();
			
			$("#tr-form-today #tr_price").val(price.replace(",",""));
			$("#tr-form-today #tr_quantity").val(qty.replace(",",""));
			
			var param 		= $("#tr-form-today").serialize();
			$("#tr-form-today #tr_price").val(price);
			$("#tr-form-today #tr_quantity").val(qty);
			
	  		var REQ_TYPE 	= "post";
	  		var REQ_URL  	= "../transaction/add";
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
	  						var status 		= result.status;
	  						var message 	= result.message;
	  						var data		= result.data;
	  						
	  						alert(result.result+"\n"+message);
	  						
	  						if(status <= 100){
	  							loadStocks();
	  							hideTrModal();
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
