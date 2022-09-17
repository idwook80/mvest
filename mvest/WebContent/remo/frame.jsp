<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common.jsp" %>
<%@ include file="head.jsp" %>
 
<%
String url = (String)G_PARAM.get("url");
String mainUrl = "main.jsp";
if(url.startsWith("https://") || url.startsWith("http://")){
	mainUrl = url;
}else {
	mainUrl = GL_DOMAIN+"/"+url;
}


%>
<style>
.iframe100 {   display: block;  /*  border: none;  */  height: 100vh;   width: 100vw; }
</style>
<script type="text/javascript">
$(document).ready(function($){
	$("#url-area").text("<%=mainUrl %>");
	$("#info").attr('class','panel-body collapse');
});

</script>

<!-- CONTENTS -->
<%-- <jsp:include page="<%=url %>" flush="true" /> --%>

<div class="container-fluid" style="margin-top:10px;display:none;" id="frame-info">
	 <%@ include file="info.jsp" %>
<hr>
</div>

<div class="container-fluid">
	<iframe src="<%= mainUrl %>" class="iframe100" scrolling="auto" marginwidth="0" noresize>
	</iframe>
</div>
<!-- CONTENTS END -->

<%@ include file="tail.jsp" %>
