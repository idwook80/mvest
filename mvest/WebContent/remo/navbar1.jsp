<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse  navbar-fixed-top">
		<!-- <nav class="navbar navbar-default"> -->
		  <div class="container-fluid">
		  <!-- <div class="container"> -->
		  	<!-- navbar header -->
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>                        
		      </button>
		     <!--  <a class="navbar-brand" href="">iremo.net<br>(주)리모컴퓨팅 </a> -->
		      <a class="navbar-brand" href="<%=GL_DOMAIN %>/remo">LOGO <br> REMO </a>
		    </div>
		    <!-- //navbar header -->
		    
		    
		    <div class="collapse navbar-collapse" id="myNavbar">
		      <ul class="nav navbar-nav">
		      	 <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">WEB <span class="caret"></span></a>
		          <ul class="dropdown-menu" style="background-color: #336699;">
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=iremo">iremo</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://www.google.com/webhp?igu=1">Google</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://naver.com">Naver</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://daum.net">Daum</a></li>
		          </ul>
		         </li>
		         <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">nhisct <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		          	<li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/info">101/info</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/pc/login.jsp">101/pc</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/admin/login.jsp">101/admin</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/m/login.jsp">101/mobile</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/info">nhisct.jp/info</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/pc/login.jsp">nhisct.jp/pc</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/admin/login.jsp">nhisct.jp/admin</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/m/login.jsp">nhisct.jp/mobile</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=http://172.16.203.220:8081/test">API</a></li>
		          </ul>
		         </li>
		      	 <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">hisct info <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=hisct_info">Demo</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://10.0.254.115">hisct.info</a></li>
		          </ul>
		         </li>
				<li class=""><a href="/svn/index.html">svn</a></li>
				<li class=""><a href="trac/remo">trac</a></li>
				<li class=""><a href="">nginx</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hovor="dropdown" data-delay="10">tomcat</a>
					<ul class="dropdown-menu" role="menu">
						<li>	<script type="text/javascript">
							document.writeln('<a href=http://'+document.location.host+':8080/test/index.jsp class=navi-link>test</a>');
					</script></li>
						<li><a tabindex="-1" href="#">hisct.info</a></li>
					</ul>
				</li>
		        <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">Page 1 <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li class=""><a href="/hisct_info/">Hisct Info</a></li>
		            <li><a href="#">Page 1-2</a></li>
		            <li><a href="#">Page 1-3</a></li>
		          </ul>
		        </li>
		        <!-- <li><a href="#">Page 2</a></li>
		        <li><a href="#">Page 3</a></li> -->
		      </ul>
		      <ul class="nav navbar-nav navbar-right">
		        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
		        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
		        <li><a href="#info" data-toggle="collapse"><span class="glyphicon glyphicon-info"></span> Info</a></li>
		      </ul>
		      <br>
		    </div>
		  </div>
</nav> --%>