<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Layout Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="../js/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  
 <!--  <script src="../resource/fontawesome/5.8.1/js/solid.js"></script>
  <script src="../resource/fontawesome/5.8.1/js/fontawesome.js"></script> -->
  <script src="https://kit.fontawesome.com/a076d05399.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <script src="../resource/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../resource/bootstrap/4.4.1/css/bootstrap.min.css">
  
  <script src="../resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
  <link rel="stylesheet" href="../resource/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css">
 
 <script type="text/javascript" src="../js/moment/moment.js"></script> 
<!--  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script> -->
<!--   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
  
  
  

</head>
<body>
<style>


:root {
	/* --slide-bg-color:#7386D5; #5bc0de #8c8c8c*/
	--base-bg-color		: #fff;
	--base-active-color	: #5bc0de;
	--base-white		: #fff;
	--base-gray			: #efefef;
	--base-sky			: #5bc0de;
	--base-sky-light	: #aadcee;
	--base-sky-dark		: #4d4d4d;
	--base-dark			: #495057;
	/* --base-sky-dark: #1d7595; */
	--base-red 			: white;
}

p {
    font-family: 'Poppins', sans-serif;
    font-size: 1.1em;
    font-weight: 300;
    line-height: 1.7em;
    color: #999;
}

a,
a:hover,
a:focus {
    color: inherit;
    text-decoration: none;
    transition: all 0.3s;
}


.header{
	border: 1px solid red;
}
.overlay {
    display: block;
	height: 100vh;
	width: 100vw;
	position: fixed;
	top:0;
	background: rgba(0, 0, 0, 0.7);
    opacity: 0;
	transition: all 0.5s ease-in-out;
	
}
.overlay.active {
    display: block;
    opacity: 1;
}
#sidebar {
	padding-top:50px;
	background-color: gray;
	height:100vh;
	width:250px;
	position: fixed;
	top:0;
	left:-250px;
	overflow-y: scroll;
	/* background: var(--base-gray); */
    color: var(--base-white);
    transition: all 0.3s;
     box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.2);
}
#sidebar.active {
	left:0;
}


.main {
	margin-top:80px;
	border: 1px solid blue;
	min-height:800px;
	background: var(--base-red);
}
.navbar {
 	padding: 0px 0px;
    background: var(--base-white);
    border: none;
    border-radius: 0;
    margin-bottom: 0px;
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
}
.navbar-nav li.active {
	background: var(--base-sky);
	color:white;
}
#collapsibleNavbar ul li a {
    padding: 10px;
    font-size: 1.1em;
    display: block;
 	color: var(--base-dark);
    background: var(--base-white);
}
#collapsibleNavbar ul li a:hover {
    color: var(--base-white);
    background: var(--base-sky);
}
#collapsibleNavbar ul li.active>a,
a[aria-expanded="true"] {
    color: var(--base-white);
    background: var(--base-sky);
}
#collapsibleNavbar ul li a[aria-expanded="true"]
{
	color: var(--base-dark);
    background: var(--base-white);
}
</style>

<!-- header start -->
<div class="header container-fluid">

<!-- nav start  -->
<nav class="navbar navbar-expand-md   fixed-top">
  <a class="navbar-brand" href="#" id="brand" >Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="javascript:void(0)" onclick="init()">변경</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>   
      
	      <!-- Dropdown -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        Dropdown link
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="#">Link 1</a>
	        <a class="dropdown-item" href="#">Link 2</a>
	        <a class="dropdown-item" href="#">Link 3</a>
	      </div>
	    </li> 
    </ul>
  </div>  
</nav>
<!-- nav end -->


<%@include file="../common/loading.jsp" %>
<div class="overlay"></div> 
<!-- sidebar area -->
<div class="active" id="sidebar"></div>
<!-- sidebar area -->
</div>
</div>
<!--  header end -->


 
<!-- main start  -->
<div class="main container-fluid"><h2>body</h2>
		   <script> 
  				 var rows = 10;
				$(document).ready(function(){
				  	init();
				  	 $('#dismiss, .overlay').on('click', function () {
			             $('#sidebar').removeClass('active');
			             $('.overlay').removeClass('active');
			             loadingHide();
			         });
				  	  $('#brand').on('click', function () {
				             $('#sidebar').addClass('active');
				             $('.overlay').addClass('active');
				             $('.collapse.in').toggleClass('in');
				             $('a[aria-expanded=true]').attr('aria-expanded', 'false');
				             loadingShow();
				         });
				  	 $('#sidebar').mCustomScrollbar({
			             theme: "minimal"
			         });
				 	
				});
				
				function init(){
					if(rows == 10) rows = 10;
					else rows = 10;
					
					$(".main").html("");
					$("#sidebar").html("");
					for(var i=0; i<rows; i++){
						var html  = "<h2>body "+ i +"</h2>";
						var side  = "<h2>side "+ i +"</h2>";
						$(".main").append(html);
						$("#sidebar").append(side);
					}
				}
				function loadingAction(){
					alert('loading action');
					loadingShow();
				}
				</script>
</div>
<!-- main end -->
<div class="test loading">
	<a href="javascript:void(0)" class="btn btn-info" id="l-show" onclick="loadingAction()">Loading Show</a>
</div>

<style>
footer{
	padding:10px 0px;
	bottom: 0; 
	color : var(--base-white);
	background-color: #333;
    width: 100%;
}

</style>
<!-- footer start  -->
<footer class="container-fluid text-center">
		<h2>footer</h2>
		 	<p>site@copyright</p>
		 	<p>
				<div class="text-center" style="padding:20px;color:gray;font-size:30px;">
					<a href=#><i class="fab fa-google"></i></a>
		           	<a href=#><i class="fab fa-facebook"></i></a>
		           	<a href=#><i class="fab fa-twitter"></i></a>
		           	<a href=#><i class="fab fa-github"></i></a>
		           	<a href=#><i class="fab fa-linkedin"></i></a>
		           	<a href=#><i class="fab fa-line"></i></a>
				</div>
			</p>
</footer>

<!-- footer end -->

</body>
</html>


