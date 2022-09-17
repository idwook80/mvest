<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common.jsp" %>
<%@ include file="head.jsp" %>
 
<%
String url = (String)G_PARAM.get("url");
String mainUrl = "news.jsp";
if(url != null && (url.startsWith("https://") || url.startsWith("http://"))){
	mainUrl = url;
}else {
	mainUrl = url;
}


%>
<style>
.iframe100 {   display: block;  /*  border: none;  */  height: 100vh;   width: 100vw; }
</style>
<script type="text/javascript">
$(document).ready(function($){
	/* $(document).on('click', 'a[href="#"]', function(e){
		alert(e);
		alert($(this).attr("href"));
	}); */
	  $("a[name=link]").click(function(e) {
		var name = $(this).attr("href").replace("#","");
		$("#ct-frame").attr("src",name+".jsp");
 		$("#ct-frame").contentDocument.location.reload(true);
	});  
});

</script>

<!-- CONTENTS -->
<%-- <jsp:include page="<%=url %>" flush="true" /> --%>

<div class="container-fluid" style="margin-top:10px;display:none;" id="frame-info">
	 <%@ include file="../info.jsp" %>
<hr>
</div>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12 col-md-2">
			<ul class="list-unstyled">
				<li><a href="#news" 	name="link">news</a></li>
				<li><a href="#news2" 	name="link">news2</a></li>
				<li><a href="#mobile" 	name="link">mobile</a></li>
				<li><a href="#rank1" 	name="link">rank1</a></li>
				<li><a href="#rank2" 	name="link">rank2</a></li>
			</ul>
		</div>
		<div class="col-xs-12 col-md-10">
			<iframe id="ct-frame" src="<%=mainUrl %>" class="iframe100" scrolling="auto" marginwidth="0" noresize>
			</iframe>
		</div>
	</div>
	
</div>
<!-- CONTENTS END -->

<%@ include file="../tail.jsp" %>
