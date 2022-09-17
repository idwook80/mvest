<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
 <%
	request.setCharacterEncoding("UTF-8");
	String CONTEXT_PATH 	= request.getContextPath();
	HttpSession session		= request.getSession(false);
	String CONTEXT_URL 		= request.getRequestURI();
	String LOCATION 		= request.getRequestURL().toString();
	String CUR_URL 			= CONTEXT_PATH+request.getRequestURI();
	
	if(session != null){
		//out.println("<script>alert('session : "+session.getId()+"')</script>");
	}
	 
	/**
	WebConfig.debug("CUR  URL:"+ LOCATION);
	String LOGIN_URL 		= CONTEXT_PATH+"/jsp/login/login.jsp?lang="+lang;
	String LOGOUT_URL 		= CONTEXT_PATH+"/jsp/login/logout?lang="+lang;
	
	if(session == null || session.getAttribute("loginYn") == null || session.getAttribute("loginYn").equals("N")){
		out.println("<script>alert('"+Lang.get("main.msg.please_login")+"')</script>");
		out.println("<script>location.href='"+LOGIN_URL+"';</script>");
	}
	
	String sessionId 		= session != null ? session.getId() : "";
 	String loginYn 			= session != null ? (String)session.getAttribute("loginYn") : "";
 	String loginId 			= session != null ? (String)session.getAttribute("loginId") : "";
 	String loginName 		= session != null ? (String)session.getAttribute("loginName") : "";
 	String loginNo 			= session != null ? (String)session.getAttribute("loginNo") : "";
 	String loginLevel 		= session != null ? (String)session.getAttribute("loginLevel") : "";
 	String loginSessionId 	= session != null ? (String)session.getAttribute("loginSessionId") : "";
 	Member loginMember 		= session != null ? (Member)session.getAttribute("member") : null;
 	int maxInactive 		= session != null ? session.getMaxInactiveInterval() : 0;
 	long lastAccesse  		= session != null ? session.getLastAccessedTime() : 0;
 	String lastAccessedTime	= lastAccesse+"";
 	int M_LEVEL = 0;
 	
 	try{
 		M_LEVEL = loginMember != null ? Integer.parseInt(loginMember.getMb_level()): 0;
 	}catch(Exception e){}
 	boolean IS_MANAGER = M_LEVEL >= Member.LEVEL_MANAGER;
 	
 	
 	String lastAccess = session != null ?  TimeUtil.getDateFormat("YYYY-MM-dd HH:mm:ss", lastAccesse) : "";
 	
 	String session_check_timeout = String.valueOf(60*1000);
 	try{
 		session_check_timeout  = String.valueOf(Integer.parseInt(WebConfig.get("CF_SESSION_CHECK_TIMEOUT","60"))*1000);
 	}catch(Exception e){}
 	**/
%>