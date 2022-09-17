<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

<%
String G_CONTEXT_PATH = request.getContextPath();
String G_URL = request.getRequestURI();
String G_HOST = request.getLocalAddr();

%>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en"> 
<head>
  <title><%=WebConfig.get("CF_TITLE") %>(500)</title>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	 <script src="<%=G_CONTEXT_PATH %>/js/jquery/3.4.1/jquery.min.js"></script>
  
  
 <!--  <script src="../resource/fontawesome/5.8.1/js/solid.js"></script>
  <script src="../resource/fontawesome/5.8.1/js/fontawesome.js"></script> -->
  <script src="https://kit.fontawesome.com/a076d05399.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 
  <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/resource/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="<%=G_CONTEXT_PATH %>/resource/bootstrap/4.4.1/js/bootstrap.min.js"></script>

 
   
  <script src="<%=G_CONTEXT_PATH %>/resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
  <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css">
 

  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/moment.js"></script> 
  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/moment-with-locales.js"></script>
  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/locale/ko.js"></script>
  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/locale/ja.js"></script>
  
  
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />


 <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/css/layout_20200410.css">
 <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/common.js"></script>
</head>
<%

String path = request.getContextPath();
String url = request.getRequestURL().toString();
String uri = request.getRequestURI();
url = url.replace( uri,"")+request.getContextPath();
 

%>


 <style>

</style>

<script type="text/javascript">
	function goMain(){
		 location.href="<%=G_CONTEXT_PATH %>/main.jsp";
	}
</script>
<body>
<div class="container-fluid" style="width:100%;height:100vh;padding:0px;margin:0px;min-height: 500px;overflow: auto;padding-top:60px;">
	<div class="row text-center " style="width:100%;height:400px;padding:0px;margin:0px;">
		 <div class="container-fluid" style="width:450px;">
		 	<div class="card">
			  <div class="card-header bg-secondary"><h4>500</h4></div>
			  <div class="card-body" style="height:150px;">
			  					<p><%=Lang.get("error.msg.500_01") %>
			  					<p><%=Lang.get("error.msg.500_02") %>
			  </div>
			  <div class="card-footer bg-light">
			  	<a href="javascript:void(0)" class="btn btn-secondary" onclick="goMain()"><%=Lang.get("menu.home") %></a>
			  </div>
			</div>
		 </div>
	</div>
</div>
</body>
</html>