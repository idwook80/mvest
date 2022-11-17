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
	

%>
	
<%@ include file="common.jsp" %>
<body>
 <%=ParamUtil.DEFAULT_PAGE_FORM_START_TAG %>
 <%=ParamUtil.serializeForm(paramMap) %>
 <%=ParamUtil.DEFAULT_PAGE_FORM_END_TAG %>

<script type="text/javascript">
var today_date = '<%=tDate %>';
var wins;
var next_round;

$(function(){
	$("#input-form-today #to_date").val(today_date);
	 $("#today_date").text(today_date);
 	game();
});	
	
function game(){
  		var param 		= $("#pageForm").serialize();
  		var REQ_TYPE 	= "get";
  		var REQ_URL  	= "../lottery/game";
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
  							//console.log(wins);
  							/* updateTotal(res.total);*/
  							updateWin(res.win);
  							updateList(res.wins);
  						
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
  	this.wins = list;
	 $(".wins-body").html('');
	 if(list){
    	 for(var i=0; i<list.length; i++){
			var item = list[i];
			$(".wins-body").append(getItemTag(item,i));
    	 }
    	
	 }
}
function getItemTag(item,idx){
	  var tag 	= new StringBuffer();
	  var c1 = getColor(item.n1);
	  var c2 = getColor(item.n2);
	  var c3 = getColor(item.n3);
	  var c4 = getColor(item.n4);
	  var c5 = getColor(item.n5);
	  var c6 = getColor(item.n6);
	  var c7 = getColor(item.b1);
	  
   
	  tag.append(" <li class=\"list-group-item d-flex justify-content-between align-items-center\">");
		/*  tag.append("<td>" + item.round + "</td>"); */
		 tag.append("<span class=\"ball_645 sml "+ c1 +"\">" + item.n1 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c2 +"\">" + item.n2 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c3 +"\">" + item.n3 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c4 +"\">" + item.n4 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c5 +"\">" + item.n5 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c6 +"\">" + item.n6 + "</span>");
		/*  tag.append("<span class=\"btn btn-info\" onclick=\"regMyWin("+idx+")\">" + next_round + "회</span>"); */
		 tag.append("<span class=\"btn btn-info\" onclick=\"regMyWin("+idx+")\">등록</span>");
		 //tag.append("<td><i class=\"fa fa-plus\" style=\"font-size:14px;color:#aaa;margin-right:5px;\"></i>");
		// tag.append("<span class=\"ball_645 sml "+ c7 +"\">" + item.b1 + "</td>");
		 
		 tag.append("</li>");
		 
  	 return tag.toString();
}
function getColor(n){
	if(n <= 10) return "ball1";
	if(n <= 20) return "ball2";
	if(n <= 30) return "ball3";
	if(n <= 40) return "ball4";
	if(n < 50) return "ball5";
	
}

function updateWin(item){
	$(".win-round").text(item.round);
	next_round =  Number(item.round) + 1;
	$(".next-round").text(next_round);
	
	$(".win").each(function(index){
		$(this).removeClass("ball1 ball2 ball3 ball4 ball5");
	});
	$(".win-1").text(item.n1);  $(".win-1").addClass(getColor(item.n1)); 
	$(".win-2").text(item.n2);  $(".win-2").addClass(getColor(item.n2)); 
	$(".win-3").text(item.n3);  $(".win-3").addClass(getColor(item.n3)); 
	$(".win-4").text(item.n4);  $(".win-4").addClass(getColor(item.n4)); 
	$(".win-5").text(item.n5);  $(".win-5").addClass(getColor(item.n5)); 
	$(".win-6").text(item.n6);  $(".win-6").addClass(getColor(item.n6)); 
	$(".win-b").text(item.b1);  $(".win-b").addClass(getColor(item.b1)); 
	$(".win_date").text(item.date);
}

function regMyWin(idx){
	var win = wins[idx];
	win.round = next_round;
	//alert(win.round+ ","+idx);
		var REQ_TYPE 	= "get";
		var REQ_URL  	= "../lottery/my/c";
		$.ajax({
			type		: REQ_TYPE,
			url			: REQ_URL,
			data		: win,
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
							//console.log(wins);
							alert("등록되었습니다.");
						
						}else {
							ajaxLoadFail(result);
						}
					 	
			},
			error		: function() {
						ajaxError();
			}
		});
	
	
}
function regMyWins(){
	for(var i=0; i<wins.length; i++){
		wins[i].round = next_round;
	}
	
	var jsondata = JSON.stringify(wins);
	console.log(wins);
	console.log(jsondata);
	var t1 = wins[0];
	
	var REQ_TYPE 	= "post";
	var REQ_URL  	= "../lottery/my/c/all";
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: {data:jsondata} ,
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
						//console.log(wins);
						alert("등록되었습니다.");
					
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
<style>
/* 645 ball */
.ball_645 {display:inline-block; border-radius:100%; text-align:center; vertical-align:middle; color:#fff;  /* text-shadow: 0px 0px 2px rgba(0, 0, 0, 1); */}
.ball_645.lrg {width:30px; height:30px; line-height:28px; font-size:20px}
.ball_645.sml {width:26px; height:26px; line-height:24px; font-size:17px}
.ball_645.not {color:#777}
.ball_645.sml.not {font-weight:300}
.ball_645.ball1 {background:#fbc400; text-shadow: 0px 0px 3px rgba(73, 57, 0, .8)}
.ball_645.ball2 {background:#69c8f2; text-shadow: 0px 0px 3px rgba(0, 49, 70, .8)}
.ball_645.ball3 {background:#ff7272; text-shadow: 0px 0px 3px rgba(64, 0, 0, .8)}
.ball_645.ball4 {background:#aaa; text-shadow: 0px 0px 3px rgba(61, 61, 61, .8)}
.ball_645.ball5 {background:#b0d840; text-shadow: 0px 0px 3px rgba(41, 56, 0, .8)}

.win {margin-left : 5px; margin-right:5px;}
</style>




<%@ include file="navbar.jsp" %> 

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-6"><h4> <span class="badge ">자동 추천번호</span></h4></div>
	    <div class="col-sm-6 text-right"><span class="text-right text-dark"><strong>Today : </strong><strong id="today_date">2021-01-01</strong></span></div>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-12 text-center last-win" >
			  	<span  class="text-dark col-md-2 col-sm-12" style="font-size:24px;font-weight:bold;margin-right:20px;">
			  		<span class="win-round text-danger"></span>
			  		회차
			  		<span class="text-secondary"  style="font-size: 12px;"><span class="win_date"></span>(추첨)</span>
			  	</span>
	
		<div class="row">
			<ul class="list-group col-sm-12">
  			  <li class="list-group-item d-flex justify-content-between align-items-center" style="border: none">
  			  		<span class="win win-1 ball_645 lrg" ></span>
				 	<span class="win win-2 ball_645 lrg" ></span>
				 	<span class="win win-3 ball_645 lrg" ></span>
				 	<span class="win win-4 ball_645 lrg" ></span>
				 	<span class="win win-5 ball_645 lrg" ></span>
				 	<span class="win win-6 ball_645 lrg" ></span>
				 	<span><i class="fa fa-plus" style="font-size:24px;color:#aaa;margin-right:5px;margin-left:5px;"></i></span>
				 	<span class="win win-b ball_645 lrg" ></span>
  			  
  			  </li>
  			  </ul>
		</div>
		
		<div class="col-sm-12">
			<span  class="text-dark col-md-2 col-sm-12" style="font-size:24px;font-weight:bold;margin-right:20px;">
				  		다음 <span class="next-round text-danger"></span>회차
		 	</span>
		</div>
	 </div>
			
	</div>
	
	<hr>
	
	<div class="row">
		<div class="col-sm-12">
			<ul class="list-group">
				  <li class="list-group-item d-flex justify-content-between align-items-center bg-secondary">
				    <span>A</span> 
				    <span>B</span>
				    <span>C</span> 
				    <span>D</span> 
				    <span>E</span> 
				    <span>F</span>
				    <span ><a class="btn btn-info" href="javascript:void(0)" onclick="regMyWins();" style="font-size:10px;">일괄등록</a></span>
				  </li>
				  
				  <div class="wins-body">
				 </div>
		 	</ul>
		</div>
	</div>
	<br>
	  <div class="row">
	   <div class="col-sm-12 text-center">
	   		<span><a class="btn btn-info" href="index.jsp">리스트 돌아가기</a></span>
	   		<span><a class="btn btn-success" href="javascript:void(0)" onclick="game();">다시 추출하기</a></span>
	   </div>
   </div>

</div>



	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>  
</body>
    
    
    
</html>
