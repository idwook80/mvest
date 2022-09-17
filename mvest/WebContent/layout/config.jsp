<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mvest.config.*"  %>

<%
	String realPath 		= request.getRealPath("/");
	WebConfig.load(realPath);

	HttpSession csession = request.getSession();
	WebConfig.debug(csession);

%>
