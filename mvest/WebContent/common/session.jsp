<%@page import="com.mvest.util.*"%>
<%@page import="com.google.gson.*"%>
<%@page import="com.mvest.config.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
 <%
 	int G_PAGE_LEVEL =  request.getAttribute("G_PAGE_LEVEL") != null ? (Integer) request.getAttribute("G_PAGE_LEVEL") : 10 ;
 	
 	
 	request.setCharacterEncoding("UTF-8"); 	
	String CONTEXT_PATH 	= request.getContextPath();
	HttpSession hsession	= request.getSession(false);
	String CONTEXT_URL 		= request.getRequestURL().toString();
	String CONTEXT_URI		= request.getRequestURI();
	String CUR_URL 			= CONTEXT_PATH+request.getRequestURI();
	//Member member			= null;
	
	//String lang				= request.getAttribute("lang") != null ? (String) request.getAttribute("lang") : "ko";

	String LOGIN_URL 		= CONTEXT_PATH+"/login/login.jsp";
	String LOGOUT_URL 		= CONTEXT_PATH+"/login/logout.jsp";
	String HREF_PARAM		= lang != null ? "?lang="+lang : "";
	
	WebConfig.debug("CONTEXT_URL : "+ CONTEXT_URL);
	WebConfig.debug("CONTEXT_URI : "+ CONTEXT_URI);
	WebConfig.debug("LOGIN URL : "+ LOGIN_URL +","+ CONTEXT_URI.equals(LOGIN_URL));
	
	//hsession.setAttribute(Login.CURRENT_URL, CONTEXT_URL);
	
	
	String isLogin = "N";
    String h_lang = (String) hsession.getAttribute("lang");
    if(request.getAttribute("lang")  != null){
    	h_lang = (String) request.getAttribute("lang") ;
    }
    if(request.getParameter("lang") != null) {
    	h_lang = (String) request.getParameter("lang");
    }
	 
    WebConfig.debug("LANG:"+h_lang +","+request.getAttribute("lang") +","+ request.getParameter("lang"));
	
    
	if(hsession != null){
		isLogin = hsession.getAttribute(Login.YN) != null ? (String) hsession.getAttribute(Login.YN) : Login.LOGIN_N;
	    member = (Member) hsession.getAttribute(Login.LOGIN_MEMBER);
	    
		if(isLogin.equals(Login.LOGIN_Y) && member != null){
			WebConfig.debug(member.toString());
		}
		boolean b = LoginSessionManager.isInvalidSession(hsession);
		if(!b) {
			hsession.invalidate();
			hsession = request.getSession(true);
		}
		
	}else {
		System.out.println("session null");
	}
	if(h_lang != null) hsession.setAttribute("lang", h_lang);
	JsonObject memberObject = null;
	
	if(member == null || isLogin.equals("N")){
		 if(CONTEXT_URI.indexOf("login.jsp")<0 || CONTEXT_URI.indexOf("logout.jsp") < 0){
			  
		   }else {
				out.println("<script>alert('" + Lang.get("login.msg.after_login") + "')</script>");
				out.println("<script>location.href='"+LOGIN_URL + HREF_PARAM +"';</script>");
			   memberObject = null;
		   }
	}else {
		 String pw = "";
		   for(int i=0; i< member.getMb_password().length(); i++){
			   pw +="*";
		   }
		   member.setMb_password(pw);
		   memberObject = ParamUtil.toJson(member); 
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
 	
 	String G_mb_id 			= member != null ? member.getMb_id() : "";
 	String G_mb_name 		= member != null ? member.getMb_name() : "";
 	String G_mb_level 		= member != null ? member.getMb_level() : "";
 	String G_mb_gr_id		= member != null ? member.getGr_id() : "";
 	String G_mb_last_access = hsession != null ? TimeUtil.getDateFormat("YYYY-MM-dd HH:mm:ss", hsession.getLastAccessedTime()) : "";
 	int G_mb_max_interval   = hsession != null ? hsession.getMaxInactiveInterval() : 0;
    int G_mb_level_int		= 0;
    
	try{
		G_mb_level_int = Integer.parseInt(G_mb_level);
	}catch(Exception e){
	}
	
	if(G_mb_level_int < G_PAGE_LEVEL){
		if(isLogin.equals("Y")){
			out.println("<script>alert('" + Lang.get("error.msg.not_permission") + "')</script>");
			out.println("<script>location.href=history.back();</script>");
		}else {
			out.println("<script>alert('" + Lang.get("login.msg.after_login") + "')</script>");
			out.println("<script>location.href='"+LOGIN_URL + HREF_PARAM +"';</script>");
		}
		
	}
 	
%>
<script type="text/javascript">
var e1_path 				= "<%=request.getContextPath() %>";
var e1_url 					= "<%=WebConfig.get("CF_URL") %>";
var e1_uri  				= "<%=request.getRequestURI() %>";
var e1_is_gecko  			= (navigator.userAgent.toLowerCase().indexOf("gecko") != -1);
var e1_is_ie     			= (navigator.userAgent.toLowerCase().indexOf("msie") != -1);
var e1_is_member 			= "<%=hsession.getAttribute(Login.YN) %>";
var e1_session_id 			= "<%=hsession.getId() %>";
var e1_last_access_time 	= "<%=hsession.getLastAccessedTime() %>";
<%-- var e1_lang					= "<%=Lang.getLocale() %>";--%>
var e1_member_id			= "<%=G_mb_id %>";
var e1_member_name			= "<%=G_mb_name %>";
var e1_member_level			= "<%=G_mb_level %>"; 
var e1_member_group			= "<%=G_mb_gr_id %>";
var e1_member				= <%=memberObject != null ? memberObject.toString() : "\"\"" %>;
var e1_member_time_last 	= "<%=G_mb_last_access %>";
var e1_member_time_interval =  <%=G_mb_max_interval %>;

$(function(){
	if(!e1_uri.match("login.jsp") && !e1_uri.match("logout.jsp")){
		/* setInterval(function() {
			checkSession();
		}, 1000*10); */
	}else {
	}
});
function checkSession(){
		var REQ_TYPE 	= "POST";
		var REQ_URL  	= "<%=G_CONTEXT_PATH %>/login/invalid";
		var param		= "";
		
		$.ajax({
			type		: REQ_TYPE,
			url			: REQ_URL,
			data		: param,
			dataType	: "json", 
			async		: false,
		/* 	beforeSend	: function(){ loadingShow(); },  */
			success		: function(res){
					/* 	loadingHide();  */
						var str 		= JSON.stringify(res,null,2);
						var result 		= res.result;
						var status 		= result.status;
						var message 	= result.message;
						var data		= result.data;
						
						console.log(str);
						//alert(result.result+"\n"+message +"\n"+data);
						if(status <= 100){
							
						}else {
							alert('auto logout');
							
						}
					 	
			},
			error		: function(){
			}
		});
}
</script>