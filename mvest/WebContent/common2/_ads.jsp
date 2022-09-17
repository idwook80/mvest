<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script type=text/javascript>
		$(document).ready(function($){
				setInterval(function(){
					$(".tab-pane").each(function(){
						var fade = $(this).attr("class");
						if(fade == 'tab-pane fade'){
							$(this).attr("class","tab-pane fade in active");
						}else {
							$(this).attr("class","tab-pane fade");
						}
					});
				}, 1000*10);
				
				$('#myCarousel').carousel({
					interval:   10000
				});
				
				var clickEvent = false;
				$('#myCarousel').on('click', '.nav a', function() {
						clickEvent = true;
						$('.nav li').removeClass('active');
						$(this).parent().addClass('active');		
				}).on('slid.bs.carousel', function(e) {
					if(!clickEvent) {
						/* $("#myCarousel").find('.nav li').each(function(){
							alert($(this).text());
						}) */
						var count = $("#myCarousel").find('.nav').children().length -1;
						var current =$("#myCarousel").find('.nav li.active');
						current.removeClass('active').next().addClass('active');
						var id = parseInt(current.data('slide-to'));
						if(count == id) {
							$("#myCarousel").find('.nav li').first().addClass('active');	
						}
						
					}
					clickEvent = false;
				});
		});
		</script>
		
	  <div class="row container-fluid" >
	    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="border:1px solid #efefef;margin-bottom:5px;">
	    <!-- Indicators -->
			<ul class="nav nav-tabs">
			    <li style="max-width:50px;" data-target="#myCarousel" data-slide-to="0" class="active"><a data-toggle="tab" href="#naver" style="padding:0px 2px;"><h6><strong>Naver1</strong></h6></a></li>
			    <li style="max-width:50px;" data-target="#myCarousel" data-slide-to="1"><a data-toggle="tab" href="#naver2"  style="padding:0px 2px;"><h6><strong>Naver2</strong></h6></a></li>
			    <li style="max-width:50px;" data-target="#myCarousel" data-slide-to="2"> <a data-toggle="tab" href="#daum"  style="padding:0px 2px;"><h6><strong>Daum</strong></h6></a></li>
			 </ul>
	    <!-- Wrapper for slides -->
		    <div class="carousel-inner" role="listbox" style="padding-left:5px;">
	      		<div class="item active">
			       	<%--  <jsp:include page="../rank/naverRank.jsp" flush="true" /> --%>
			    </div>
			    <div class="item">
			       	  <%-- <jsp:include page="../rank/naverRank2.jsp" flush="true" /> --%>
			    </div>
			    <div class="item">
			        <%-- <jsp:include page="../rank/daumRank.jsp" flush="true"/> --%>
			    </div>
		    </div>
		    <!-- Left and right controls -->
		  </div>
    </div>
    <%-- 
    <div class="row container-fluid">
    	<ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#naver" data-target="#myCarousel" data-slide-to="0">Naver</a></li>
		    <li><a data-toggle="tab" href="#daum" data-target="#myCarousel" data-slide-to="1">Daum</a></li>
		 </ul>
		  <div class="tab-content">
		  	 <div id="naver" class="tab-pane fade in active">
		        <jsp:include page="../naver/naverRank.jsp" flush="true"/>
		    </div>
		     <div id="daum" class="tab-pane fade">
		      <jsp:include page="../daum/daumRank.jsp" flush="true"/>
		    </div>
		  </div>
    </div> --%>
    <div class="well">
       <p>well</p>
     </div>
     <div class="well">
       <p>well</p>
     </div>
    <div class="row container-fluid">
    	 
    </div>
    <hr>
    <div class="row container-fluid">
     <p>ADS MESSAGE TEST AREA ADS MESSAGE TEST AREA </p>
    </div>
    
    
  
