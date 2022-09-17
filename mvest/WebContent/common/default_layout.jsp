<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>

<body>

<!--  ###################################### Header area ######################################################-->
	<%@include file="header.jsp" %>
<!--  ###################################### Header area ######################################################-->

<!--  ###################################### Main area ######################################################-->
<div class="main container-fluid">
 	<div class="container-fluid">
 		<h2>test layout</h2>
 	</div>
 	 <div class="paging container-fluid" style="width:100%;margin:0;">
				  	
		  <ul class="pagination justify-content-center">
			  <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
			  <li class="page-item"><a class="page-link" href="#">1</a></li>
			  <li class="page-item active"><a class="page-link" href="#">2</a></li>
			  <li class="page-item"><a class="page-link" href="#">3</a></li>
			  <li class="page-item"><a class="page-link" href="#">다음</a></li>
			</ul>
	  
	  </div>
</div> 
<!--  ###################################### Main area ######################################################-->

<!--  ###################################### Footer area ######################################################-->
<%@include file="tail.jsp" %>
<!--  ###################################### Footer area ######################################################-->

</body>
</html>


