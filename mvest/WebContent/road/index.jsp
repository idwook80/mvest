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
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=L180144&cctvname=%25EC%2596%2591%25EC%25A0%2595%25EC%2597%25AD&kind=n&cctvip=211.57.45.104&cctvch=null&id=0278&cctvpasswd=null&cctvport=null&minX=127.16855534228083&minY=37.57659199052246&maxX=127.2382458087876&maxY=37.61712277748955" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E901651&cctvname=%255B%25EA%25B5%25AD%25EB%258F%25846%25ED%2598%25B8%25EC%2584%25A0%255D%25EB%2582%25A8%25EC%2596%2591%25EC%25A3%25BC%25EB%258D%2595%25EC%2586%258CIC&kind=Z2&cctvip=null&cctvch=null&id=71658/8fsvkQInMoOm00M2zjpFWmeA4Dk5H4Ezr5rilwK6MiIOv8ErCkx0izXP0RBqKqRjzflOcTB6h59FAau7dJkFW135GvpXtV4byLfrjRlzsyg=&cctvpasswd=null&cctvport=null&minX=127.1413854635866&minY=37.55406790563158&maxX=127.30473791597254&maxY=37.6250454523151" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E900917&cctvname=%255B%25EA%25B5%25AD%25EB%258F%25846%25ED%2598%25B8%25EC%2584%25A0%255D%25EB%2582%25A8%25EC%2596%2591%25EC%25A3%25BC%25EB%258F%2584%25EA%25B3%25A1IC&kind=Z2&cctvip=null&cctvch=null&id=4408/GwzKOG1nenDgbIJzrYTIGzV2BvG2xwI5b6%2BxgDxC9COv2KYtXmnJJEIPnoU6/FIzoBX%2BaeSCOAVgduPpvdAf06tIrOHtu5ScpjAH9iSwca0=&cctvpasswd=null&cctvport=null&minX=127.18963452504457&minY=37.523976971150155&maxX=127.3046854162675&maxY=37.5950247028681" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E900923&cctvname=%255B%25EA%25B5%25AD%25EB%258F%25846%25ED%2598%25B8%25EC%2584%25A0%255D%25EC%2596%2591%25ED%258F%2589%25EA%25B5%25AD%25EC%2588%2598%25EA%25B5%2590&kind=Z2&cctvip=null&cctvch=null&id=5410/Ed1rdAbCvJ9OIgCuqy5yLPCe5kJZFcZQkqzGp82nQZQGvV3z6OJAe5GxoiVp9cLu8orgmBL5fNZDmXUXp/1mEUmh1nJRmpo3G8hTWkYqo1U=&cctvpasswd=null&cctvport=null&minX=127.34684836031002&minY=37.46703033297622&maxX=127.4619458969942&maxY=37.53793852960323" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=L900999&cctvname=%25EC%2596%2591%25ED%258F%2589%25EB%2582%25A8%25ED%2595%259C%25EA%25B0%2595%25ED%259C%25B4%25EA%25B2%258C%25EC%2586%258C&kind=EE&cctvip=4892&cctvch=null&id=4892/e/h388WxmF%2BRiAgXNOOqNmBxwCvJEsSTM9XZ1Ix%2BX8svHuhhZKqKKGytz8apwXoN&cctvpasswd=null&cctvport=null&minX=127.26114974494126&minY=37.49637493945154&maxX=127.46902764694728&maxY=37.567030950814576" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912542&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EB%2582%25A8%25EC%2597%25AC%25EC%25A3%25BC&kind=Z3&cctvip=null&cctvch=null&id=3290/pc/QIwOdLdlFVO0iL3tkTEvzWvr1/FBKJJ%2BCoY563VlPFuMdAjWV9eeLkb95C3NaLVeQPtX4W3isE/g23sEY5R3Cx28emwJ8dOKDuhhj5WE=&cctvpasswd=null&cctvport=null&minX=127.51764269009131&minY=37.23638642761014&maxX=127.72503586703745&maxY=37.30662018435749" allowfullscreen></iframe></div>
</div>
<div class="row">
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E911777&cctvname=%255B%25EC%2588%2598%25EB%258F%2584%25EA%25B6%258C%25EC%25A0%259C1%25EC%2588%259C%25ED%2599%2598%25EC%2584%25A0%255D%25ED%2586%25A0%25ED%258F%2589&kind=Z3&cctvip=null&cctvch=null&id=11/xo1rPHhWjk7oQ%2Bnvd5bkqnXU%2BtvSR0gzix8sj3LBoG%2Bwu03QRiDYeGmAke3YaflfqpqkaO2VBK9czDdacZjF3NPPyMPb114blkXGI0bpXXw=&cctvpasswd=null&cctvport=null&minX=127.11785278903771&minY=37.55924843511215&maxX=127.23978240466337&maxY=37.6303462051095" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E911687&cctvname=%255B%25EC%2588%2598%25EB%258F%2584%25EA%25B6%258C%25EC%25A0%259C1%25EC%2588%259C%25ED%2599%2598%25EC%2584%25A0%255D%25EA%25B0%2595%25EC%259D%25BC%25EC%259C%25A1%25EA%25B5%2590&kind=Z3&cctvip=null&cctvch=null&id=2360/C9O1Icppt%2Bhdrn63EulRT%2BoTO%2BFYYYPYsvT2/SyIboWgPU20VsSBhJDhNWiXUUbk2uiu7NOMWpBQx7Sji4PShhNAdZcT9eSFF%2BL%2BKNdK%2BQ8=&cctvpasswd=null&cctvport=null&minX=127.13564083723145&minY=37.53255905530102&maxX=127.25754484794736&maxY=37.60364031806241" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E911785&cctvname=%255B%25EC%2588%2598%25EB%258F%2584%25EA%25B6%258C%25EC%25A0%259C1%25EC%2588%259C%25ED%2599%2598%25EC%2584%25A0%255D%25ED%2595%2598%25EB%2582%25A8%25EB%25B6%2584%25EA%25B8%25B0%25EC%25A0%2590&kind=Z3&cctvip=null&cctvch=null&id=8/Z%2BVVz7D7L5SJxBqmCFLxXW2KLkoDO3yLDEkxJq7cJXtXXuPqsLKEYHrYWEsmZ0gxiI4tgnIDSguBZjk1Vtxfmg==&cctvpasswd=null&cctvport=null&minX=127.15061016526916&minY=37.50536607072481&maxX=127.27248554556543&maxY=37.57643352703578" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912760&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EC%2584%25A0%255D%25EB%258F%2599%25EC%2584%259C%25EC%259A%25B8%25EC%2598%2581%25EC%2597%2585%25EC%2586%258C&kind=Z3&cctvip=null&cctvch=null&id=20/HTEXsvfqanVXj9nA/ZLlAlNxbr33rK4zUXmMh9lP1ZR5SuzbuQ%2BH%2BXiNOKUbcSFdVpcFIMMeE6RujuDq/o3AjCX/gD66wFRZ%2BHM4xdKc22Q=&cctvpasswd=null&cctvport=null&minX=127.16449969937098&minY=37.48545276520738&maxX=127.28635649883167&maxY=37.55650733807731" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912485&cctvname=%255B%25EC%25A0%259C2%25EC%25A4%2591%25EB%25B6%2580%25EC%2584%25A0%255D%25EC%2584%25A0%25EB%258F%2599&kind=Z3&cctvip=null&cctvch=null&id=2667/F1KHaufGgG9%2BsF9Doa0ObY7arcPtvIwhTKVhtsJ83JvLD2aZ5mMs0rAzUsAPcchWxMmL4y%2BUpBSAPiiTdFPb27G1YTlTpHcWhUlRcGi9t%2Bo=&cctvpasswd=null&cctvport=null&minX=127.27063274560759&minY=37.34390148654553&maxX=127.39236358928169&maxY=37.41485769195704" allowfullscreen></iframe></div>
  <div class="col-md-2 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912761&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EC%2584%25A0%255D%25EB%25A7%2588%25EC%259E%25A5%25EB%25B6%2584%25EA%25B8%25B0%25EC%25A0%2590&kind=Z3&cctvip=null&cctvch=null&id=908/FqPIF347hJabJKujPL0OGHY9TKm6D8bPR9G9oISIqHSXXoHzPS3Knq/eimR2zZk5M97HbpmdD8OFpTAZ8EKW8S4bebZTtBT0nCy5oXOczYM=&cctvpasswd=null&cctvport=null&minX=127.36211825472449&minY=37.21844529056453&maxX=127.48373559282042&maxY=37.28931712042782" allowfullscreen></iframe></div>
</div>

<div class="row">
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912628&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%2597%25AC%25EC%25A3%25BC%25EB%25B6%2584%25EA%25B8%25B0%25EC%25A0%2590&kind=Z3&cctvip=null&cctvch=null&id=3283/cQBHat8Zm0wEcfXEf9eD3iGy9BiUiYlJuvmkyeSl0LLO5bf590VlwoaqwI8fKlHegNr/36iJJG9J%2BFkYd5dMg9e5RE5ZlcnWJysj3hpepDM=&cctvpasswd=null&cctvport=null&minX=127.54474601858871&minY=37.18187701705603&maxX=127.70675622342632&maxY=37.25234427773818" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912524&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EA%25B8%2588%25EB%258B%25B9%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=8347/Zzlg28UBfkU4ZSOH%2BnROVCQiZRAvB69QeWH62k4owELioThVQsKWvMMyKTd3eSxVKCDmZkuHjp8m8/cJOEWtNirGGJZx025Ha5hcKl5CqSQ=&cctvpasswd=null&cctvport=null&minX=127.50414280467288&minY=37.15949626923843&maxX=127.82005412550481&maxY=37.290326302095544" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912632&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%2597%25B0%25EB%258C%2580%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=8346/YYsiQxZyRVBq8lk8gun%2B6vGnO1VEmhb4A9aUGrC5amBVJKzNAHEONTLX5HZOq0r3k9Mnr3ChUYyzAWcSlvT9t%2B4cAH5O0ez6v0HlXSiNIwo=&cctvpasswd=null&cctvport=null&minX=127.54961046191416&minY=37.169455989001634&maxX=127.71159938404371&maxY=37.2399173416514" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912548&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EB%258B%25A8%25ED%258F%2589%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=732/Dt4%2BnsOc8KejZHL6Y3rKEaAKJ%2BtK16qgzPJmL1jp1A/2MYvd9PkHppBxcjHlyHwvkAAJ71/oZNNbTVhPpSD/fJzm0DlkP0g8SG4ocLwP8Qw=&cctvpasswd=null&cctvport=null&minX=127.59939228148076&minY=37.097417052236054&maxX=127.76127468237453&maxY=37.167816385025716" allowfullscreen></iframe></div>
</div>
<div class="row">
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912545&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EB%2582%25A8%25EC%2597%25AC%25EC%25A3%25BC&kind=Z3&cctvip=null&cctvch=null&id=3290/pc/QIwOdLdlFVO0iL3tkTEvzWvr1/FBKJJ%2BCoY563VlPFuMdAjWV9eeLkb95C3NaSx8nl55g/kDWXTN2wT2CXS7J9loyV1jkDMwSJbz4sRI=&cctvpasswd=null&cctvport=null&minX=127.47006390627753&minY=37.15787172870549&maxX=127.75921522616537&maxY=37.28896361031591" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912674&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%25A7%2580%25EB%258B%25B9%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=2675/s/F5vTV%2By2NyVQhQP0hUu04zCxUyiX7P7SdWYclc0uLFHqi6zgZhSbq7FJZ%2Bag3Th6fPg5SGc8m2kgsMGMcO4dzudNPYy5scNXOszuMs484=&cctvpasswd=null&cctvport=null&minX=127.67807796977557&minY=37.07568903108008&maxX=127.76399787932934&maxY=37.11586303357578" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912672&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%25A4%2591%25EC%259B%2590%25ED%2584%25B0%25EB%2584%2590&kind=Z3&cctvip=null&cctvch=null&id=3289/Ota%2B/ZS8kQXSm2j6Y6BgmVFceGjpB0t1Nrz3teu1GnwUACjYeQMtl%2BVaGv5JMM6ZAyswE0MBAVSTccqRZXbYaVh6euowFqxOxW3Y6OD9rvg=&cctvpasswd=null&cctvport=null&minX=127.68348307325233&minY=37.056555440206026&maxX=127.76938585330628&maxY=37.096726266714334" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912501&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EA%25B0%2580%25EC%258B%25A02%25EA%25B5%2590&kind=Z3&cctvip=null&cctvch=null&id=3287/5/4PB3DZztqDSYViNd%2BGWu6N%2BczhjW%2BCQWwUs1lZLvCmLNBtd39%2BKADLgKHYs3lNAvUhvKl%2BRcPpz3veQ%2BW5fnEU0BXlmkj/OzrRbVm/Cec=&cctvpasswd=null&cctvport=null&minX=127.66929043757638&minY=37.033281554423596&maxX=127.83199767208323&maxY=37.10358656817043" allowfullscreen></iframe></div>
</div>
<div class="row">
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912545&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EB%2582%25A8%25EC%2597%25AC%25EC%25A3%25BC&kind=Z3&cctvip=null&cctvch=null&id=3290/pc/QIwOdLdlFVO0iL3tkTEvzWvr1/FBKJJ%2BCoY563VlPFuMdAjWV9eeLkb95C3NaSx8nl55g/kDWXTN2wT2CXS7J9loyV1jkDMwSJbz4sRI=&cctvpasswd=null&cctvport=null&minX=127.47006390627753&minY=37.15787172870549&maxX=127.75921522616537&maxY=37.28896361031591" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912674&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%25A7%2580%25EB%258B%25B9%25EB%25A6%25AC&kind=Z3&cctvip=null&cctvch=null&id=2675/s/F5vTV%2By2NyVQhQP0hUu04zCxUyiX7P7SdWYclc0uLFHqi6zgZhSbq7FJZ%2Bag3Th6fPg5SGc8m2kgsMGMcO4dzudNPYy5scNXOszuMs484=&cctvpasswd=null&cctvport=null&minX=127.67807796977557&minY=37.07568903108008&maxX=127.76399787932934&maxY=37.11586303357578" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912672&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EC%25A4%2591%25EC%259B%2590%25ED%2584%25B0%25EB%2584%2590&kind=Z3&cctvip=null&cctvch=null&id=3289/Ota%2B/ZS8kQXSm2j6Y6BgmVFceGjpB0t1Nrz3teu1GnwUACjYeQMtl%2BVaGv5JMM6ZAyswE0MBAVSTccqRZXbYaVh6euowFqxOxW3Y6OD9rvg=&cctvpasswd=null&cctvport=null&minX=127.68348307325233&minY=37.056555440206026&maxX=127.76938585330628&maxY=37.096726266714334" allowfullscreen></iframe></div>
  <div class="col-md-3 col-sm-6"><iframe width="100%" height="250" src="http://www.utic.go.kr/view/map/cctvStream.jsp?cctvid=E912501&cctvname=%255B%25EC%25A4%2591%25EB%25B6%2580%25EB%2582%25B4%25EB%25A5%2599%25EC%2584%25A0%255D%25EA%25B0%2580%25EC%258B%25A02%25EA%25B5%2590&kind=Z3&cctvip=null&cctvch=null&id=3287/5/4PB3DZztqDSYViNd%2BGWu6N%2BczhjW%2BCQWwUs1lZLvCmLNBtd39%2BKADLgKHYs3lNAvUhvKl%2BRcPpz3veQ%2BW5fnEU0BXlmkj/OzrRbVm/Cec=&cctvpasswd=null&cctvport=null&minX=127.66929043757638&minY=37.033281554423596&maxX=127.83199767208323&maxY=37.10358656817043" allowfullscreen></iframe></div>
</div>
 
<!--  <div class="row">
  <div class="col-sm-12"><iframe src="http://www.utic.go.kr/main/main.do" width="100%" height="800"></iframe></div>
</div> -->
 
</div>
	<!-- Tail Column -->
 <%@ include file="tail.jsp" %>
</body>
    
    
    
</html>
