<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mvest.config.*"  %>

<%
	String realPath 		= request.getRealPath("/");
	WebConfig.load(realPath);

	HttpSession csession = request.getSession();
	
	WebConfig.load(request.getRealPath("/"));
	csession = request.getSession();
	String lang = csession != null ? (String)csession.getAttribute("lang") : "";
	
	if(request.getParameter("lang") != null ){
		lang = request.getParameter("lang").toUpperCase();
		if(lang.equals("JA") || lang.equals("JP") 
			|| lang.equals("EN") || lang.equals("US") 
			|| lang.equals("KO") || lang.equals("KR")){
			request.setAttribute("lang", lang);
		}else {
			lang = "";
		}
	}
	if(lang == null) lang ="";
	if(lang != null && lang.equals("")){
		if(request.getSession().getAttribute("lang") != null){
			lang = (String)request.getSession().getAttribute("lang");
		}else {
			lang = WebConfig.get("CF_DEFAULT_LANG","JP");
		}
	}
	Lang Lang = LangManager.getLang(lang.toUpperCase());
	
%>
