<%@page import="etr_cr.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- nav start  -->
<!-- <nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top"> -->
<nav class="navbar navbar-expand-md  bg-dark navbar-dark fixed-top" style="margin:0px;padding:0px;">
  <a class="navbar-brand" href="<%=G_CONTEXT_PATH %>/main.jsp" id="brand" style="display:none;">ETR</a>
  <button class="navbar-toggler btn btn-secondary text-left" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fas fa-align-right" style="background: gray;"></i>
   </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar" style="margin:0px;padding:0px;">
	    <ul class="navbar-nav" id="menu" style="width:100%;">
	      <% if(G_mb_level_int >= Member.LEVEL_SYSTEM) { %>
	      <li class="nav-item"  data-menu-item="home">
	        <a class="nav-link" href="<%=G_CONTEXT_PATH %>/main.jsp" ><span class='fas fa-home'></span> <%=Lang.get("menu.home") %></a>
	      </li>
	      <li class="nav-item"  data-menu-item="group" >
	        <a class="nav-link" href="<%=G_CONTEXT_PATH %>/group/group_list.jsp"><span class="fa fa-group"></span> <%=Lang.get("menu.group") %></a>
	      </li> 
	      <% } %>
	      
	      <% if(G_mb_level_int >= Member.LEVEL_GROUP) { %>
	      <li class="nav-item"  data-menu-item="member" >
	        <a class="nav-link" href="<%=G_CONTEXT_PATH %>/member/member_list.jsp"><span class="fa fa-user"></span> <%=Lang.get("menu.user") %></a>
	      </li>   
	      <li class="nav-item" data-menu-item="site">
	        <a class="nav-link" href="<%=G_CONTEXT_PATH %>/site/site_list.jsp"><span class='fas fa-building'></span> <%=Lang.get("menu.site") %><a>
	      </li>   
	      <% } %>
	      
	      <li class="nav-item" data-menu-item="etr">
	        <a class="nav-link" href="<%=G_CONTEXT_PATH %>/etr/site_list.jsp"><span class='fas fa-warehouse'></span> <%=Lang.get("menu.etr") %></a>
	      </li>   
	      
	      
	      <li class="nav-item dropdown" data-menu-item="log">
	      	<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	     	<span class="fa fa-edit"></span> <%=Lang.get("menu.log") %>
	        </a>
	        <div class="dropdown-menu" >
	         <% if(G_mb_level_int >= Member.LEVEL_SYSTEM) { %>
	        	<a class="dropdown-item" data-sub-item="admin" href="<%=G_CONTEXT_PATH %>/log/admin_log.jsp"><%=Lang.get("menu.log.admin") %></a>
	        	<%} %>
	        	<a class="dropdown-item" data-sub-item="login" href="<%=G_CONTEXT_PATH %>/log/login_log.jsp"><%=Lang.get("menu.log.login") %></a>
	        	<a class="dropdown-item" data-sub-item="control" href="<%=G_CONTEXT_PATH %>/log/control_log.jsp"><%=Lang.get("menu.log.control") %></a>
	        	<a class="dropdown-item" data-sub-item="schedule" href="<%=G_CONTEXT_PATH %>/log/schedule_log.jsp"><%=Lang.get("menu.log.schedule") %></a>
	      	</div>
	      </li>   
	      
		      <!-- Dropdown 
		    <li class="nav-item dropdown " data-menu-item="schedule">
			      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			     	<span class="fa fa-calendar"></span> 일정
			      </a>
			      <div class="dropdown-menu" >
			        <a class="dropdown-item" data-sub-item="weekly" href="<%=G_CONTEXT_PATH %>/etr/weekly.jsp">주간</a>
			        <a class="dropdown-item" data-sub-item="monthly" href="<%=G_CONTEXT_PATH %>/etr/monthly.jsp">월간</a>
			      </div>
		    </li> 
		    
		    -->
		    
		    
	    </ul>
	      <!-- Links -->
		  <ul class="navbar-nav" style="">
		     <!-- Dropdown -->
		    
		    <% if(G_mb_level_int > Member.LEVEL_SYSTEM ){ %>
		    <li class="nav-item dropdown " data-menu-item="config">
			      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			     	   <i class='fas fa-bug'></i>
			      </a>
			      <div class="dropdown-menu" >
			        <a class="dropdown-item" data-sub-item="test" href="<%=G_CONTEXT_PATH %>/test/test.jsp">test</a>
			        <a class="dropdown-item" data-sub-item="db" href="<%=G_CONTEXT_PATH %>/test/db.jsp">DB</a>
			        <a class="dropdown-item" data-sub-item="derby" href="<%=G_CONTEXT_PATH %>/test/derby.jsp">Derby</a>
			        <a class="dropdown-item" data-sub-item="rule" href="<%=G_CONTEXT_PATH %>/etr/rule_list.jsp">schedule</a>
			        <a class="dropdown-item" data-sub-item="rule" href="<%=G_CONTEXT_PATH %>/etr/event_list.jsp">event</a>
			        <a class="dropdown-item" data-sub_item="login" href="<%=G_CONTEXT_PATH %>/test/login_list.jsp">Login</a>
			        <a class="nav-link dropdown-toggle" href="#" id="navbardrop2" data-toggle="dropdown" style="color: gray;">
				     	  Language 
				    </a>
			        <div class="dropdown-menu" >
			        	 <a class="dropdown-item" data-sub-item="en" href="<%=G_CONTEXT_PATH %>/main.jsp?lang=en">English</a>
			        	 <a class="dropdown-item" data-sub-item="jp" href="<%=G_CONTEXT_PATH %>/main.jsp?lang=jp">日本語</a>
			        	 <a class="dropdown-item" data-sub-item="ko" href="<%=G_CONTEXT_PATH %>/main.jsp?lang=ko">한국어</a>
			        </div>
			      </div>
		    </li> 
		    <%} %>
		    
		      <style>
		      	.popover{
				    width:350px;
				    height:250px;
				    max-width:none; 
				}
				
			    .login-popup {
			      	  width:120px; 
				      display:block;
				      font-size:20px;
				      overflow:hidden;
				      text-overflow: ellipsis;
				      white-space: nowrap;
			      }
			      .login-buttons {
			      	font-size:15px;
			      }
			      .card-text.card-label{
			      	font-weight: bold;
			      }
			 </style>
		     <li class="nav-item">
		      <a class="nav-link" href="#" data-toggle="popover-login">
		      	<span class="fas fa-user-circle login-popup"> <%=G_mb_id %></span> 
		      </a>
		    </li>
		  </ul>
    </div> 
   
</nav>
<!-- nav end -->
<%@include file="my_modal.jsp" %>

<script type="text/javascript">
     $(document).ready(function () {
         $('#collapsibleNavbar').on('hidden.bs.collapse', function (e) {
			  /*  alert('hidden'); */
		});
		         $('#collapsibleNavbar').on('show.bs.collapse', function (e) {
			 /*   alert('show'); */
		});
		         
	  $('[data-toggle="popover-login"]').popover({
		//  title : '로그인 정보',	  
		  html: true,
		  trigger: 'focus',
		  placement: 'bottom',
		  container: 'body',
		  content: function () { return loginTag(); }
	  });
	  $(document).on('click', '#myModalButton', function(){
			addMyModal();
		});

	  
	  if(e1_member.mb_level == 10){
		  $(".navbar #brand").text("<%=Lang.get("member.label.level_user") %>");
	  }else if(e1_member.mb_level == 20){
		  $(".navbar #brand").text("<%=Lang.get("member.label.level_group") %>");
	  }else if(e1_member.mb_level == 30){
		  $(".navbar #brand").text("<%=Lang.get("member.label.level_system") %>");
	  }
	  setInterval(function() {
			  e1_member_time_interval--;
			  updatedMaxTimeInterval();
		}, 1000);
 	});
     
    function updatedMaxTimeInterval(){
    	$(".login-popover #left-timeout").text(e1_member_time_interval);
    	 if(e1_member_time_interval <= 0){
    		 e1_member_time_interval = 0;
		  }
    }
    function loginTag(){
    	var tag = new StringBuffer();
    	var level = "<%=Lang.get("member.label.level_user") %>";
    	if(e1_member.mb_level == 20) level = "<%=Lang.get("member.label.level_group") %>";
    	if(e1_member.mb_level == 30) level = "<%=Lang.get("member.label.level_system") %>"
    	
    	tag.append("<div class=\"login-popover card\">");
    	
    	tag.append("<div class=\"card-body card-popover\">");
		tag.append("<h4 class=\"card-title\"><span class='fas fa-user'></span> " + e1_member.mb_id + "</h4>");
		tag.append("<span class=\"card-text card-label\"><%=Lang.get("member.label.member_name") %>  :  </span><span class=\"text-right\">" + e1_member.mb_name + "</span><br>");
		tag.append("<span class=\"card-text card-label\"><%=Lang.get("group.label.group_name") %> : </span><span>" + e1_member.gr_name + "</span><br>");
		tag.append("<span class=\"card-text card-label\"><%=Lang.get("member.label.member_level") %> : </span><span>" + level + "</span><br>");
		tag.append("<span class=\"card-text card-label\"><%=Lang.get("login.label.login_ip") %>  :</span><span> " + e1_member.mb_login_ip + "</span><br>");
		tag.append("<span class=\"card-text card-label\"><%=Lang.get("login.label.last_login") %>  :</span><span> " + e1_member.mb_update + "</span><br>");
		/* tag.append("<span class=\"card-text\"> 제어 시간 : " + e1_member_time_last + "</span><br>");
		tag.append("<span class=\"card-text\">남은 시간 : <span id=\"left-timeout\">" + e1_member_time_interval + "</span></span><br><br>"); */
		tag.append("<span class=\"text-right\">")
		tag.append("<a href=\""+e1_path+"/login/logout.jsp\" class=\"btn btn-secondary login-buttons\"><%=Lang.get("login.button.logout") %></a>");
		tag.append(" <a href=\"#\" class=\"btn btn-secondary login-buttons\" id=\"myModalButton\"><%=Lang.get("member.title.my") %></a>");
		tag.append("</span>");
		tag.append("</div>");
    	tag.append("</div>");
    	
    	return tag.toString();
    } 
    
    function loginTag2(){
    	var tag = new StringBuffer();
    	var level = "<%=Lang.get("member.label.level_user") %>";
    	if(e1_member.mb_level == 20) level = "<%=Lang.get("member.label.level_group") %>";
    	if(e1_member.mb_level == 30) level = "<%=Lang.get("member.label.level_system") %>"
    	
    	tag.append("<div class=\"login-popover card\">");
    	
    	tag.append("<div class=\"card-body card-popover\">");
		tag.append("<h4 class=\"card-title\"><span class='fas fa-user'></span> " + e1_member.mb_id + "</h4>");
		tag.append("<span class=\"card-text\"><%=Lang.get("member.label.member_name") %>  :  " + e1_member.mb_name + "</span><br>");
		tag.append("<span class=\"card-text\"><%=Lang.get("group.label.group_name") %> : " + e1_member.gr_name + "</span><br>");
		tag.append("<span class=\"card-text\"><%=Lang.get("member.label.member_level") %> : " + level + "</span><br>");
		tag.append("<span class=\"card-text\"><%=Lang.get("login.label.login_ip") %>  : " + e1_member.mb_login_ip + "</span><br>");
		tag.append("<span class=\"card-text\"><%=Lang.get("login.label.last_login") %>  : " + e1_member.mb_update + "</span><br>");
		/* tag.append("<span class=\"card-text\"> 제어 시간 : " + e1_member_time_last + "</span><br>");
		tag.append("<span class=\"card-text\">남은 시간 : <span id=\"left-timeout\">" + e1_member_time_interval + "</span></span><br><br>"); */
		tag.append("<span class=\"text-right\">")
		tag.append("<a href=\""+e1_path+"/login/logout.jsp\" class=\"btn btn-secondary login-buttons\"><%=Lang.get("login.button.logout") %></a>");
		tag.append(" <a href=\"#\" class=\"btn btn-secondary login-buttons\" id=\"myModalButton\"><%=Lang.get("member.title.my") %></a>");
		tag.append("</span>");
		tag.append("</div>");
		
    	tag.append("</div>");
    	
    	return tag.toString();
    } 
    function menu(val){
    	val = val == 'schedule' ? "etr" : val;
    	
    	$("#menu").find("li").each(function(){
    		var menu = $(this).data("menu-item");
    		if(menu == val){
    			if($(this).find("a").hasClass('dropdown-item')){
    				$(this).find(".nav-link").addClass('active');
    			}else {
    				$(this).find("a").addClass('active');
    			}
    		}else {
    			$(this).find("a").removeClass('active');
    		}
    	});
    }
    function sub(val){
    	$("#menu").find("a").each(function(){
    		var menu = $(this).data("sub-item");
    		if(menu != null){
    			if(menu == val){
        				$(this).addClass('active');
        		}else {
        			$(this).removeClass('active');
        		}
    		}
    	
    		
    	});
    }
 </script>
 
