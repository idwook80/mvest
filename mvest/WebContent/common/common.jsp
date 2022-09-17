<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="config.jsp" %>
<%@ page session="false" %>
<%
	String G_CONTEXT_PATH = request.getContextPath();
	String G_URL = request.getRequestURI();
	String G_HOST = request.getLocalAddr();
	String G_PAGE_TITLE = WebConfig.get("CF_TITLE","ETR CR");
	String G_LANG = Lang.getLocale();
	String G_LOCALE = Lang.getLocaleMoment();
	
	System.out.println(request.getAttribute("lang")+","+ Lang.getLocale() +" - "+Lang.get("login.button.login"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title><%= G_PAGE_TITLE != null ? G_PAGE_TITLE : "ETR CR" %></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  
  <script src="../webjars/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <script src="../webjars/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="../webjars/jquery/3.3.1/jquery.min.js"></script>
  <link rel="stylesheet" href="../webjars/bootstrap/4.4.1/css/bootstrap.min.css" />
  
  
  
  
  
 <!--  <script src="../resource/fontawesome/5.8.1/js/solid.js"></script>
  <script src="../resource/fontawesome/5.8.1/js/fontawesome.js"></script> -->
  <script src="https://kit.fontawesome.com/a076d05399.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 
 

 
   
  <script src="<%=G_CONTEXT_PATH %>/resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
  <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css">
 

  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/moment.js"></script> 
  <%-- <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/moment-with-locales.js"></script> --%>
  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/locale/ko.js"></script>
  <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/moment/locale/ja.js"></script>
  
  
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>  
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>     -->
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />


 <%-- <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/css/layout.css"> --%>
 <link rel="stylesheet" href="<%=G_CONTEXT_PATH %>/css/layout_20200702.css">
 <script type="text/javascript" src="<%=G_CONTEXT_PATH %>/js/common_20200612.js"></script>
 <script type="text/javascript">
 function ajaxLoadFail(result){
		var status 	= result.status;
		var data 	= result.data;
		var message = result.message;
		
		if(status == 301){
			alert("<%=Lang.get("login.msg.auto_logout") %>");
			<%-- location.href= <%=G_CONTEXT_PATH %>result.data; --%>
			location.href= "<%=G_CONTEXT_PATH %>/login/logout.jsp";
		}else {
			alert('<%=Lang.get("common.load_fail") %>');
		}
	}
function ajaxActionFail(result){
	var status = result.status;
	var data = result.data;
	var message = result.message;
	
	if(status == 301){
		alert("<%=Lang.get("login.msg.auto_logout") %>");
		location.href= result.data;
	}else {
		alert("<%=Lang.get("common.fail") %>"+"\n" + status + "\n" + message);
	}
}
function ajaxError(){
	loadingHide();
	alert('<%=Lang.get("common.system_error") %>');
}
</script>
</head>

<%-- <%@ include file="session.jsp" %> --%>
<%@ include file="loading.jsp" %>