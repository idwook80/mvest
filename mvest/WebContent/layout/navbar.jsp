<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- nav start  -->
<nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top">
  <a class="navbar-brand" href="#" id="brand" >사이드메뉴</a>
  
  
  <button class="navbar-toggler btn btn-info text-left" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fas fa-align-right"></i>
   </button>
  
   
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link active" href="javascript:void(0)" onclick="init()">변경</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">그룹</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">사용자</a>
      </li>   
      <li class="nav-item">
        <a class="nav-link" href="#">사이트<a>
      </li>   
      <li class="nav-item">
        <a class="nav-link" href="#">ETR</a>
      </li>   
      <li class="nav-item">
        <a class="nav-link" href="#">로그</a>
      </li>   
      
	      <!-- Dropdown -->
	    <li class="nav-item dropdown ">
	      <a class="nav-link dropdown-toggle active" href="#" id="navbardrop" data-toggle="dropdown">
	        	일정
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item " href="#">주간</a>
	        <a class="dropdown-item" href="#">월간</a>
	        <a class="dropdown-item" href="#">Link 3</a>
	      </div>
	    </li> 
    </ul>
  </div>  
</nav>
<!-- nav end -->
<script type="text/javascript">
     $(document).ready(function () {
         $('#collapsibleNavbar').on('hidden.bs.collapse', function (e) {
			  /*  alert('hidden'); */
		});
		         $('#collapsibleNavbar').on('show.bs.collapse', function (e) {
			 /*   alert('show'); */
		});
 	});
     
     
     
    function menu(val){
    	alert('menu : '+val)
    }
 </script>