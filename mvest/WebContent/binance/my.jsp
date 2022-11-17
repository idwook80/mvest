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
var today_date = '<%=tDate %>';
var mys;
var wins;
var win;
var is_drawn = false;
$(function(){
		$("#input-form-today #to_date").val(today_date);
	 	$("#today_date").text(today_date);
			load();
			//list();
			$("select[name='round-selector']").change(function(){
				var val = $("select[name='round-selector'] option:selected").val();
				list(val);
				
			});
});	

function load(){
		var param 		= $("#pageForm").serialize();
		var REQ_TYPE 	= "get";
		var REQ_URL  	= "../lottery/list/all";
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
							updateAllWins(res.wins);
						}else {
							ajaxLoadFail(result);
						}
					 	
			},
			error		: function() {
						ajaxError();
			}
		});
}
function updateAllWins(wins){
	this.wins = wins;
	var last_round = Number(wins[wins.length-1].round);
	var next_round = Number(last_round)+1;
	
	$("select[name='round-selector']").html('');
	if(wins){
   	 for(var i=0; i<wins.length; i++){
			var item = wins[i];
			$("select[name='round-selector']").append("<option value='"+item.round+"'>"+item.round+"</option>");
   		 }
	 }
	$("select[name='round-selector']").val(last_round).attr("selected","selected");
	$("select[name='round-selector']").append("<option value='"+(next_round)+"'>"+(next_round)+"</option>");
	list(last_round);
	
}
	
function list(round){
  		var param 		= $("#pageForm").serialize();
  		if(round) param += "&round="+round;
  		
  		var REQ_TYPE 	= "get";
  		var REQ_URL  	= "../lottery/my/list";
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
  							console.log(wins);
  							/* updateTotal(res.total);*/
  							is_drawn = false;
  							if(round > wins.length)  updateNotDrawn(round);
  							else updateWin(wins[round-1]);
  							
  							updateList(res.wins);
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
  	this.mys = list;
	 $(".wins-body").html('');
	 if(list){
    	 for(var i=0; i<mys.length; i++){
			var item = mys[i];
			$(".wins-body").append(getItemTag(item,i));
    	 }
    	
	 }
}
function getItemTag(item,idx){
	  var tag 	= new StringBuffer();
	  var c1 = checkWin(item.n1) || is_drawn ? getBallColor(item.n1) : "not";
	  var c2 = checkWin(item.n2) || is_drawn  ? getBallColor(item.n2) : "not";
	  var c3 = checkWin(item.n3) || is_drawn  ? getBallColor(item.n3) : "not";
	  var c4 = checkWin(item.n4) || is_drawn  ? getBallColor(item.n4) : "not";
	  var c5 = checkWin(item.n5) || is_drawn  ? getBallColor(item.n5) : "not";
	  var c6 = checkWin(item.n6) || is_drawn  ? getBallColor(item.n6) : "not";
	 // var c7 = checkWin(item.n1) ? getColor(item.b1) : "";
	  
	 tag.append(" <li class=\"list-group-item d-flex justify-content-between align-items-center\">");
	
   
		 tag.append("<span>" + item.round + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c1 +"\">" + item.n1 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c2 +"\">" + item.n2 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c3 +"\">" + item.n3 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c4 +"\">" + item.n4 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c5 +"\">" + item.n5 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c6 +"\">" + item.n6 + "</span>");
		 
		 var result = "낙점";
		 var count = getCount(item);
		 if(count == 3) result =  "5등";
		 if(count == 4) result =  "4등";
		 if(count == 5) {
		 	if(checkBonus(item)) result = "2등";
		 	result =  "3등";
		 }
		 if(count == 6) result = "1등";
		 if(is_drawn)  result = "미추첨";
		 
		 if(result == "낙점" || is_drawn){
			 tag.append("<span class=\"badge badge-secondary badge-pill\">" + result + " </span>");
		 }else {
			 tag.append("<span class=\"badge badge-success badge-pill\">" + result + " </span>");
		 }
			
		 
		 
		 tag.append("</li>");
		 
  	 return tag.toString();
}
function getBallColor(n){
	if(n <= 10) return "ball1";
	if(n <= 20) return "ball2";
	if(n <= 30) return "ball3";
	if(n <= 40) return "ball4";
	if(n < 50) return "ball5";
}
function checkWin(n){
	if(win.n1 == n) return true;
	if(win.n2 == n) return true;
	if(win.n3 == n) return true;
	if(win.n4 == n) return true;
	if(win.n5 == n) return true;
	if(win.n6 == n) return true;
	return false;
}
function getCount(item){
	var count = 0;
	if(checkWin(item.n1)) count++;
	if(checkWin(item.n2)) count++;
	if(checkWin(item.n3)) count++;
	if(checkWin(item.n4)) count++;
	if(checkWin(item.n5)) count++;
	if(checkWin(item.n6)) count++;
	return count;
}
function checkBonus(item){
	if(win.b1 == item.n1) return true;
	if(win.b1 == item.n2) return true;
	if(win.b1 == item.n3) return true;
	if(win.b1 == item.n4) return true;
	if(win.b1 == item.n5) return true;
	if(win.b1 == item.n6) return true;
	return false;
}

function updateNotDrawn(round){
	this.is_drawn = true;
	this.win = new Object();
	win.round = round;
	win.n1 = win.n2 = win.n3 = win.n4 = win.n5 = win.n6 = win.b1 = 0;
	$(".win-round").text(round);
	$(".win").each(function(index){
		$(this).removeClass("ball1 ball2 ball3 ball4 ball5");
	});
	
	$(".drawn-line").css("display","flex");
	$(".win-line").css("display","none");
	
	$(".win-1").text("");  $(".win-1").addClass("ball4"); 
	$(".win-2").text("");  $(".win-2").addClass("ball4"); 
	$(".win-3").text("미");  $(".win-3").addClass("ball4"); 
	$(".win-4").text("추");  $(".win-4").addClass("ball4"); 
	$(".win-5").text("첨");  $(".win-5").addClass("ball4"); 
	$(".win-6").text("");  $(".win-6").addClass("ball4"); 
	$(".win-b").text("");  $(".win-b").addClass("ball4"); 
	
}
function updateWin(item){
	$(".drawn-line").css("display","none");
	$(".win-line").css("display","flex");
	
	this.win = item;
	$(".win-round").text(item.round);
	$(".win").each(function(index){
		$(this).removeClass("ball1 ball2 ball3 ball4 ball5");
	});
	
	$(".win-1").text(item.n1);  $(".win-1").addClass(getBallColor(item.n1)); 
	$(".win-2").text(item.n2);  $(".win-2").addClass(getBallColor(item.n2)); 
	$(".win-3").text(item.n3);  $(".win-3").addClass(getBallColor(item.n3)); 
	$(".win-4").text(item.n4);  $(".win-4").addClass(getBallColor(item.n4)); 
	$(".win-5").text(item.n5);  $(".win-5").addClass(getBallColor(item.n5)); 
	$(".win-6").text(item.n6);  $(".win-6").addClass(getBallColor(item.n6)); 
	$(".win-b").text(item.b1);  $(".win-b").addClass(getBallColor(item.b1)); 
}

function goPage(page){
 	 $("#pageForm #curPage").val(page);
 	var val = $("select[name='round-selector'] option:selected").val();
	list(val);
  }
	
</script>

<style>
/* 645 ball */
.ball_645 {display:inline-block; border-radius:100%; text-align:center; vertical-align:middle; color:#fff; font-weight:bold;  /* text-shadow: 0px 0px 2px rgba(0, 0, 0, 1); */}
.ball_645.xlrg {width:50px; height:50px; line-height:48px; font-size:40px}
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
			    <div class="col-sm-6"><h4><span class="badge"><!-- <i class="fas fa-user-tie"></i> -->내번호</span></h4>
			    	<span><a href="index.jsp" class='btn btn-success'>리스트</a></span>
			    </div>
			    <div class="col-md-6  col-sm-12 text-right"><span class="text-right text-dark"><strong>Today : </strong><strong id="today_date">2021-01-01</strong></span></div>
</div>
<hr>
<div class="row">
	<div class="col-sm-12">
		<div class="input-group">
	  		<div class="input-group-prepend">
		      <span class="input-group-text">회차</span>
		    </div>
		    <select name="round-selector" class="custom-select form-control">
			    <option selected>select win round</option>
			  </select>
	  	</div><br>
	</div>
	<div class="col-sm-12 text-center last-win" >
  		<div class="col-sm-12">
	  		<span  class="text-dark" style="font-size:24px;font-weight:bold;margin-right:20px;">
	  		<span class="win-round text-danger"></span>
	  				회차
	  		</span>
  		</div>
  		<div class="row">
  			<ul class="list-group col-sm-12">
  			  <li class="win-line list-group-item justify-content-between align-items-center" style="display:none;border:none;">
	  			<span class="win win-1 ball_645 lrg" ></span>
			 	<span class="win win-2 ball_645 lrg" ></span>
			 	<span class="win win-3 ball_645 lrg" ></span>
			 	<span class="win win-4 ball_645 lrg" ></span>
			 	<span class="win win-5 ball_645 lrg" ></span>
			 	<span class="win win-6 ball_645 lrg" ></span>
			 	<span><i class="fa fa-plus" style="font-size:24px;color:#aaa;margin-right:5px;margin-left:5px;"></i></span>
			 	<span class="win win-b ball_645 lrg" ></span>
		 	   </li>
		 	     <li class="drawn-line list-group-item justify-content-between align-items-center" style="display:none;border:none;">
			 	<span  class="text-dark" style="width:100%;">
		  				<span class="col-sm-4"><span class="ball_645 xlrg ball4" >미</span> </span>
		  			   	<span class="col-sm-4"> <span class="ball_645 xlrg ball4 ">추</span> </span>
		  				<span class="col-sm-4"><span class="ball_645 xlrg ball4" >첨</span> </span>
		  		</span>
		  		</li>
  			</ul>
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
									   <span>회차</span>
									    <span>A</span> 
									    <span>B</span>
									    <span>C</span> 
									    <span>D</span> 
									    <span>E</span> 
									    <span>F</span>
									    <span>G</span> 
								       <span >당첨</span>
								  </li>
								  
			  				
			  				
			  				
			  					  <div class="wins-body">
								  <li class="list-group-item d-flex justify-content-between align-items-center">
								   <span class="win win-1 ball_645 sml ball1" >1</span>
								   <span class="win win-1 ball_645 sml ball1" >2</span>
								   <span class="win win-1 ball_645 sml ball2" >1</span>
								   <span class="win win-1 ball_645 sml ball3" >2</span>
								   <span class="win win-1 ball_645 sml ball4" >1</span>
								   <span class="win win-1 ball_645 sml ball5" >2</span>
								   <span class="badge badge-secondary badge-pill">낙점</span>
								  </li>
								  </div>
						 	</ul>
				  		</div>
				  		<br>
				  		<div class="row">
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

</div>


	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
</body>
    
    
    
</html>
