<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="common.jsp" %>
<%@ include file="head.jsp" %>
<!-- <meta http-equiv="refresh"  content="600"> 자동 리로드-->
 
 
<%-- <%@ include file="contents.jsp" %> --%>
 
<script type="text/javascript">
var refreshTime = new Date().getTime();
var currentTime = 
$(document.body).bind("mousemove keypress",function(){
	refreshTime = new Date().getTime();
});
$(document).ready(function(){
	setInterval(function() {
	    if (new Date().getTime() - refreshTime >= 1000*60*10) {
	        window.location.reload(true);
	    }
	}, 1000);
	 
});
</script>
<!-- contents start-->

<div class="container-fluid"> <%@ include file="info.jsp" %></div>




<!-- google calendar -->
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12 col-md-5"> 
		 <jsp:include page="google/calendar.jsp"></jsp:include>
		</div>
		<div class="col-xs-12 col-md-5"> 
		 <jsp:include page="google/map.jsp"></jsp:include>
		</div>
		<div class="col-xs-12 col-md-2"> 
		 <jsp:include page="naver/news2.jsp"></jsp:include>
		</div>
	</div>
</div>
<!-- //google calendar -->

<%@ include file="../remo/rank/rank.jsp" %>

<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12 col-md-6">
			<!-- NEWS -->
			<div class="panel panel-primary">
			     <div class="panel-heading">
			     	<div class="row container-fluid">
				     	<span class="col-xs-6"><a href="#info_news" data-toggle="collapse">News</a></span>
				     	<span class="col-xs-6 text-right" id="url-area"></span>
			     	</div>
			     </div>
			     <div class="panel-body collapse" id="info_news">
			     	<div class="row container-fluid" style="height:300px;overflow: scroll;">
			     		 <jsp:include page="../remo/naver/news.jsp"></jsp:include>
			     	</div>
				</div>
			</div>
			<!-- //NEWS -->
		</div>
		<div class="col-xs-12 col-md-6" > 
			<!-- MOBILE -->
			<div class="panel panel-primary">
			     <div class="panel-heading">
			     	<div class="row container-fluid">
				     	<span class="col-xs-6"><a href="#info_mobile" data-toggle="collapse">Mobile</a></span>
				     	<span class="col-xs-6 text-right" id="url-area"></span>
			     	</div>
			     </div>
			     <div class="panel-body collapse" id="info_mobile">
			     	<div class="row container-fluid" style="height:300px;overflow: scroll;">
			     		 <jsp:include page="../remo/naver/mobile.jsp"></jsp:include>
			     	</div>
				</div>
			</div>
			<!-- //MOBILE NEWS -->
		</div>
	</div>
</div>  

<!-- PM MAP  -->
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12 col-md-6"> 
			<div class="panel panel-primary">
			     <div class="panel-heading">
			     	<div class="row container-fluid">
				     	<span class="col-xs-6"><a href="#pm_s_map" data-toggle="collapse">미세먼지1</a></span>
				     	<span class="col-xs-6 text-right" id="url-area"><a href="javascript:reloadIframe('pm_s_map_frame');" class="glyphicon glyphicon-refresh"></a> </span>
			     	</div>
			     </div>
			     <div class="panel-body collapse in" id="pm_s_map">
		     		<iframe id="pm_s_map_frame" src="https://earth.nullschool.net/#current/particulates/surface/level/overlay=pm2.5/orthographic=-232.65,37.40,3000" style="border: 0" width="100%" height="450" frameborder="0" scrolling="no">
					</iframe>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-md-6"> 
			<div class="panel panel-primary">
			     <div class="panel-heading">
			     	<div class="row container-fluid">
				     	<span class="col-xs-6"><a href="#pm_l_map" data-toggle="collapse">미세먼지2</a></span>
				     	<span class="col-xs-6 text-right" id="url-area"><a href="javascript:reloadIframe('pm_l_map_frame');" class="glyphicon glyphicon-refresh"></a> </span>
			     	</div>
			     </div>
			     <div class="panel-body collapse in" id="pm_l_map">
			     	<script>
			     	function reloadIframe(objId){
			     		/* document.getElementById(프레임ID).contentDocument.location.reload(true);
			     		document.getElementsByName(프레임명).contentDocument.location.reload(true);
			     		parent.프레임명.location.reload(true); */
			     		//$("#"+objId).attr("src","https://earth.nullschool.net/#current/particulates/surface/level/overlay=pm2.5/orthographic=-232.65,37.40,3000")
			     		//document.getElementById(objId).contentDocument.location.reload(true);
			     		$("#"+objId).contentDocument.location.reload(true);
			     	} 
			     	</script>
		     		<iframe id="pm_l_map_frame" src="https://earth.nullschool.net/#current/particulates/surface/level/overlay=pm2.5/orthographic=-232.65,37.40,500" style="border: 0" width="100%" height="450" frameborder="0" scrolling="no">
			</iframe>
				</div>
			</div>
			
		</div>
	</div>
</div>
<!-- //PM MAP  -->


<!-- //contents-->

<%@ include file="tail.jsp" %>
