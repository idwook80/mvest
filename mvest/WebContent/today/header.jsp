<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

<link href="<%=request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-2.1.1.min.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script> 
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
 
<body>
		<nav class="navbar navbar-inverse  navbar-fixed-top">
		<!-- <nav class="navbar navbar-default"> -->
		  <div class="container-fluid">
		  <!-- <div class="container"> -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>                        
		      </button>
		      <a class="navbar-brand" href="<%=PATH %>nhisct/auth.jsp">테스트 </a>
		    </div>
		    <div class="collapse navbar-collapse" id="myNavbar">
		      <ul class="nav navbar-nav">
		      <li class="<%=command.startsWith("/") ? "active" : "" %>"><a href="<%=PATH %>">Home</a></li>
		        <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Web <span class="caret"></span></a>
		          <ul class="dropdown-menu">
			         <li class="<%=command.startsWith("/bootstrap") ? "active" : "" %>"><a href="<%=PATH %>bootstrap">Bootstrap</a></li>
			         <li class="<%=command.startsWith("/layout") ? "active" : "" %>"><a href="<%=PATH %>layout">Layout</a></li>
		          </ul>
		        </li>
		        
		      	<li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Develop <span class="caret"></span></a>
		          <ul class="dropdown-menu">
			         <li class="<%=command.startsWith("/nhisct") ? "active" : "" %>"><a href="<%=PATH %>nhisct/auth.jsp">NHiSCT</a></li>
		          </ul>
		        </li>
		        <li class="dropdown <%=command.startsWith("/chat") ? "active" : "" %>">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Chat <span class="caret"></span></a>
		          <ul class="dropdown-menu">
			         <li class=""><a href="<%=PATH %>chat/push.jsp">Push</a></li>
			         <li class=""><a href="<%=PATH %>chat/polling.jsp">Polling</a></li>
			          <li class=""><a href="<%=PATH %>chat/websocket.jsp">WebSocket</a></li>
		          </ul>
		        </li>
		      <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#">API <span class="caret"></span></a>
		          <ul class="dropdown-menu">
			         <li class="<%=command.startsWith("/google") ? "active" : "" %>"><a href="<%=PATH %>youtube/youtube.jsp">Google</a></li>
			         <li class="<%=command.startsWith("/naver") ? "active" : "" %>"><a href="<%=PATH %>youtube/youtube.jsp">Naver</a></li>
			         <li class="<%=command.startsWith("/daum") ? "active" : "" %>"><a href="<%=PATH %>youtube/youtube.jsp">Daum</a></li>
		          	 <li class="<%=command.startsWith("/youtube") ? "active" : "" %>"><a href="<%=PATH %>youtube/youtube.jsp">Youtube</a></li>
		          </ul>
		        </li>
		        <li><a href="#">Page 2</a></li>
		        <li><a href="#">Page 3</a></li>
		        
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		        <li><a href="#" id=""><span id="sign_up" name="sign_up" class="glyphicon glyphicon-user">Sign Up</span></a></li>
		        <!-- <li><a href="login.jsp" id=""><span class="glyphicon glyphicon-log-in">Login</span></a></li> -->
		        <li><a href="#" id="login_href"><span id="login" name="login" class="glyphicon glyphicon-log-in">Login</span></a></li>
		      </ul>
		    </div>
		  </div>
		</nav>
		
		
		<!-- <div id="page-wrapper">
			  사이드바
			  <div id="sidebar-wrapper" class="toggled">
			    <ul class="sidebar-nav">
			      <li class="sidebar-brand">
			        <a href="#">메뉴 브랜드</a>
			      </li>
			      <li><a href="#">메뉴 1</a></li>
			      <li><a href="#">메뉴 2</a></li>
			      <li><a href="#">메뉴 3</a></li>
			      <li><a href="#">메뉴 4</a></li>
			      <li><a href="#">메뉴 5</a></li>
			      <li><a href="#">메뉴 6</a></li>
			      <li><a href="#">메뉴 7</a></li>
			      <li><a href="#">메뉴 8</a></li>
			      <li><a href="#">메뉴 9</a></li>
			    </ul>
			  </div>
			  /사이드바
			 -->
			<!-- 본문 시작 -->
  			<div id="page-content-wrapper">