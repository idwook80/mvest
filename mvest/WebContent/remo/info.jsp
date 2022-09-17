<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	setInterval(function() {
	     $("#cur-date").text(getTimeFormat("YYYY-MM-DD HH:mm:ss",new Date()));
	}, 1000);
});
</script>
<div class="panel panel-primary">
     <div class="panel-heading">
     	<div class="row container-fluid">
	     	<div class="col-xs-12 col-md-4">
	     		<p><a href="#info" data-toggle="collapse">information</a>
	     		&nbsp;<i class="label label-default " id="cur-date"></i></p>
	     		<p class="col-xs-12 text-left" id="url-area"></p>
	     	</div>
	     	<div class="col-xs-12 col-md-8">
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
     </div>
     <div class="panel-body collapse" id="info">
     	<div class="row container-fluid">
     	<span class="col-xs-12 text-right" id="url-area"></span>
     	</div>
     	<div class="row container-fluid" style="height:300px;overflow: scroll;">
     		<div class="col-xs-12" >
     			<blockquote>
		     		PM_METHOD : <%=PM_METHOD %><br>
			     	GL_URL : <%=GL_URL %><br>
			     	GL_URI : <%=GL_URI %><br>
					GL_PATH : <%=GL_PATH %><br>
					SERVLET PATH : <%=GL_SV_PATH %><br>
					SERVLET CONTEXT : <%=GL_SV_CONTEXT %><br>
					GL_DOMAIN : <%=GL_DOMAIN %><br>
				</blockquote>
				<pre><%=getHashtable(G_HEADER).replace("],", "]<br>") %></pre>
				<pre><%=getHashtable(G_PARAM).replace("],", "]<br>") %></pre> 
			</div>
     	</div>
	</div>
</div>