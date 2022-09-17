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

$(function(){
	$("#input-form-today #to_date").val(today_date);
	$("#today_date").text(today_date);
	 list();
});	
	
function list(){
  		var param 		= $("#pageForm").serialize();
  		var REQ_TYPE 	= "get";
  		var REQ_URL  	= "../lottery/list";
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
  							var wins = res.wins;
  							console.log(wins);
  							/* updateTotal(res.total);*/
  							updateList(wins);
  							updatePaging(res.vo); 
  							updateWin(res.win);
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
function getItemTags(item,idx){
	  var tag 	= new StringBuffer();
	  var c1 = getColor(item.n1);
	  var c2 = getColor(item.n2);
	  var c3 = getColor(item.n3);
	  var c4 = getColor(item.n4);
	  var c5 = getColor(item.n5);
	  var c6 = getColor(item.n6);
	  var c7 = getColor(item.b1);
	  
   
  	 tag.append("<tr class=\"text-center\">");
		 tag.append("<td>" + item.round + "</td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c1 +"\">" + item.n1 + "</span></td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c2 +"\">" + item.n2 + "</span></td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c3 +"\">" + item.n3 + "</span></td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c4 +"\">" + item.n4 + "</span></td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c5 +"\">" + item.n5 + "</span></td>");
		 tag.append("<td><span class=\"ball_645 sml "+ c6 +"\">" + item.n6 + "</span></td>");
		 tag.append("<td><i class=\"fa fa-plus\" style=\"font-size:14px;color:#aaa;margin-right:5px;\"></i>");
		 tag.append("<span class=\"ball_645 sml "+ c7 +"\">" + item.b1 + "</span></td>");
		 
		 tag.append("</tr>");
		 
  	 return tag.toString();
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
	  tag.append("<span>" + item.round + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c1 +"\">" + item.n1 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c2 +"\">" + item.n2 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c3 +"\">" + item.n3 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c4 +"\">" + item.n4 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c5 +"\">" + item.n5 + "</span>");
		 tag.append("<span class=\"ball_645 sml "+ c6 +"\">" + item.n6 + "</span>");
		 tag.append("<span><i class=\"fa fa-plus\" style=\"font-size:14px;color:#aaa;margin-right:5px;\"></i></span>");
		 tag.append("<span class=\"ball_645 sml "+ c7 +"\">" + item.b1 + "</span>");
		 
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

function goPage(page){
 	 $("#pageForm #curPage").val(page);
 	 list();
  }
	
</script>
<style>
/* 645 ball */
.ball_645 {display:inline-block; border-radius:100%; text-align:center; vertical-align:middle; color:#fff; font-weight:bold;  /* text-shadow: 0px 0px 2px rgba(0, 0, 0, 1); */}
/* .ball_645.lrg {width:60px; height:60px; line-height:56px; font-size:28px} */
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
		 <div>
		  <iframe class="embed-responsive-item" 
		  src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912658&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%25A7%2580%25EB%258B%25B9%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=2675/s/F5vTV%2By2NyVQhQP0hUu04zCxUyiX7P7SdWYclc0uLFHqi6zgZhSbq7FJZ%2Bag3T56wXh3cKpTrKLY4j2aaMi51etrVChD13Xjzu9Zxn3Hk=&cctvpasswd=null&cctvport=null&minX=127.68724013825106&minY=37.07159919298039&maxX=127.76618494906704&maxY=37.11181233551626"
		  >
		  </iframe>
		  </div>
		
		<div class="embed-responsive embed-responsive-16by9">
		 <iframe class="embed-responsive-item" 
		  src="http://www.utic.go.kr/main/main.do" 
		  allowfullscreen>
		  </iframe>
		</div>
		
		
	
		 
		
	
		<!--
		
		 <div class="embed-responsive embed-responsive-16by9">
		  <iframe class="embed-responsive-item" 
		  src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912367&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EA%25B8%2588%25EB%258B%25B9%25EA%25B5%2590&kind=Z3&cctvip=null&cctvch=null&id=3284/e%2Ba53CP%2BV25JmOn9Ydp2pGCF1FFcYiUa3STA5bXGP0ZM90ON2fz1VWotILEyK46TTl4rIG2m3bafuCSM1m137qWvt7BUpvCCktsCCLmfn7E=&cctvpasswd=null&cctvport=null&minX=127.52787177714893&minY=37.16209508445889&maxX=127.74010333867484&maxY=37.25780037923759" 
		  allowfullscreen>
		  </iframe>
		</div>
		
		 <div class="embed-responsive embed-responsive-16by9">
		  <iframe class="embed-responsive-item" 
		  src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912472&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%2597%25AC%25EC%25A3%25BC%25EB%25B6%2584%25EA%25B8%25B0%25EC%25A0%2590&kind=Z3&cctvip=null&cctvch=null&id=3283/cQBHat8Zm0wEcfXEf9eD3iGy9BiUiYlJuvmkyeSl0LLO5bf590VlwoaqwI8fKlHeRyUHKdza60FEYBJai0aSmh5XP8Czac0XpE4QZY9sl0E=&cctvpasswd=null&cctvport=null&minX=127.50910171941533&minY=37.1835147576851&maxX=127.72137010301421&maxY=37.279251434798084" 
		  allowfullscreen>
		  </iframe>
		</div>
		
		
		
		 <div class="embed-responsive embed-responsive-16by9">
		  <iframe class="embed-responsive-item" 
		  src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912001&cctvname=%255B%25EC%2598%2581%25EB%258F%2599%25EC%2584%25A0%255D%25EC%259D%25B4%25EC%25B2%259C&kind=Z3&cctvip=null&cctvch=null&id=89/RoUxjchcDqYkeAjVLllnolhYdk/MIAzrcML4lOim/hCokfLhgKQjAKcM4ikjeydYJoP0ROJDLTcZk/k0u3FOvc5K0bOHFgYXpr8BQmtNfG4=&cctvpasswd=null&cctvport=null&minX=127.43434891450258&minY=37.188428900204045&maxX=127.64654760880018&maxY=37.284293829876205" 
		  allowfullscreen>
		  </iframe>
		</div> -->
		
		
	
	</div>

</div>
	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
</body>
    
    
    
</html>
