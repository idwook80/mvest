<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.dropdown-submenu {
  position: relative;
}
.dropdown-submenu .dropdown-menu {
  top: 0;
  left: 100%;
  margin-top: -1px;
}
</style>
<script>
/* $(document).ready(function(){
  $('.dropdown-submenu a.test').on("click", function(e){
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
  });
}); */
</script>
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
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">hisct <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/info">101/info</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/pc/login.jsp">101/pc</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/admin/login.jsp">101/admin</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://172.16.203.101/m/login.jsp">101/mobile</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/info">hisct.jp/info</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/pc/login.jsp">hisct.jp/pc</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/admin/login.jsp">hisct.jp/admin</a></li>
		            <li><a href="<%=GL_DOMAIN %>/remo/frame.jsp?url=https://hisct.jp/m/login.jsp">hisct.jp/mobile</a></li> 
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
		         
		         
		        <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">Dev <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="/svn/index.html">svn</a></li>
		            <li><a href="trac/remo">trac</a></li>
		            <li><a href="">nginx</a></li>
		          </ul>
		        </li>
		        
		        
		        <li class="dropdown">
		          <a class="dropdown-toggle" data-toggle="dropdown" href="#" data-hovor="dropdown" data-delay="10">Menu <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="<%=GL_DOMAIN %>/remo/naver/index.jsp">Naver</a></li>
		          </ul>
		        </li>
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
		        <li><a href="javascript:collapseAll();"><span class="glyphicon glyphicon-info"></span> Info</a></li>
		      </ul>
		      <br>
		    </div>
		  </div>
</nav>
 
<script type="text/javascript">
var collapseIn = 'in';
var displayIn =  "none";
function collapseAll(){
	var obj = $("div").find(".panel-body");
	var className = 'panel-body collapse '+collapseIn;
	$.each(obj,function(){
		$(this).attr("class", className);
	});
	if(collapseIn == 'in'){
		collapseIn = '';
		displayIn =  "";
	}else {
		collapseIn = 'in';
		displayIn =  "none";
	}
	$("#frame-info").css("display",displayIn);
	
}
<%-- $(document).ready(function(){
	setInterval(function() {
	    $("#cur-date").text('<%=getNowDateTime() %>');
	     $("#cur-date").text(getTimeFormat("YYYY-MM-DD HH:mm:ss",new Date()));
	}, 1000);
}); --%>
</script>
<!-- <div class="container-fluid">
	<div class="row">
		<div class="col-xs-4">	<h3><span class="label label-default " id="cur-date"></h3></div>
		<div class="col-xs-8">
			 <script>
			  (function() {
			    var cx = '003480802014118702520:vnurwsm3lfq';
			    var gcse = document.createElement('script');
			    gcse.type = 'text/javascript';
			    gcse.async = true;
			    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
			    var s = document.getElementsByTagName('script')[0];
			    s.parentNode.insertBefore(gcse, s);
			  })();
			</script>
			<gcse:search></gcse:search>
		</div>
	</div>
</div> -->