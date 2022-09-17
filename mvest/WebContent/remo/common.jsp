<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mvest.util.*" %>

<%-- <jsp:include page="config.jsp"></jsp:include> --%>
<%@ include file="config.jsp" %>
 <%!
 /*******************************************************************************
 ** 공통 변수, 상수, 코드 
 *******************************************************************************/
 	Hashtable<String,String> 	G_PARAM		 	= new Hashtable();
 	Hashtable<String,String>  	G_HEADER		= new Hashtable();
 	String 						PM_METHOD 		= "";
 	String 						GL_URL			= "";
 	String 						GL_URI			= "";
 	String 						GL_PATH			= "";
 	String						GL_SV_PATH		= "";
 	String						GL_SV_CONTEXT	= "";
 	String 						GL_DOMAIN		= "http://172.16.203.220:8081";
 
 	public void setCommon(HttpServletRequest request){
 		GL_PATH = request.getContextPath();
 		GL_URL = request.getRequestURL().toString();			//--> http://localhost/test/test.html
 		GL_URI = request.getRequestURI();						//--> /test/test.html
 		GL_DOMAIN  =request.getRequestURL().toString();
 		GL_DOMAIN =  GL_DOMAIN.replace(GL_URI, "").replace(GL_PATH, "");
 		GL_SV_CONTEXT = request.getServletContext().getContextPath();
 		GL_SV_PATH = request.getServletPath();
 		
 		PM_METHOD = request.getMethod();
 		ParamUtil.setParameters(G_PARAM, request);
 		ParamUtil.setHeaders(G_HEADER, request);
 	}
 	public String getHashtable(Hashtable tb){
 		return ParamUtil.toString(tb);
 	}
 	public String getNowDateTime(){
 		return TimeUtil.getCurrentTime("yyyy-MM-dd HH:mm:ss");
 	}
 	public String getNowDate(){
 		return TimeUtil.getCurrentTime("yyyy-MM-dd");
 	}
 	public String getNowTime(){
 		return TimeUtil.getCurrentTime("HH:mm:ss");
 	}
 %>
<%

// 공통 라이브러리
setCommon(request); 
 
 %>
