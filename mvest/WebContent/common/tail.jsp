<%@page import="etr_cr.config.WebConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- footer start  -->
<style>
footer a {
	color:white;
}
footer a:HOVER {
	color:gray;
}
</style>
<footer class="container-fluid text-center" style="max-height:400px;">
			<p>
				<div class="text-center" style="padding:20px;color:gray;font-size:30px;height:20px;">
				</div>
			</p>
			<h2><%=WebConfig.get("CF_TAIL_TITLE"," ") %></h2>
		 	<p><%=WebConfig.get("CF_COPYRIGHT"," ") %></p>
		 	<p>
				<div class="text-center" style="padding:20px;color:gray;font-size:30px;height:80px;">
					<!-- <a href=#><i class="fab fa-google"></i></a>
		           	<a href=#><i class="fab fa-facebook"></i></a>
		           	<a href=#><i class="fab fa-twitter"></i></a>
		           	<a href=#><i class="fab fa-github"></i></a>
		           	<a href=#><i class="fab fa-linkedin"></i></a>
		           	<a href=#><i class="fab fa-line"></i></a> -->
				</div>
			</p>
</footer>
<!-- footer end -->