<%@page import="java.util.Random"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("G_PAGE_LEVEL", 10);
	

%>
<%@include file="../_common.jsp" %>
<%
	/* switch(G_mb_level_int){
	case Member.LEVEL_GROUP : out.println("<script>location.href='" +G_CONTEXT_PATH + "/etr/site_list.jsp';</script>"); break;
	case Member.LEVEL_USER : out.println("<script>location.href='" +G_CONTEXT_PATH + "/etr/site_list.jsp';</script>"); break;
	} */

%>

<style>
@media (min-width: 576px) {
    .card-columns {
        column-count: 1;
    }
}

@media (min-width: 768px) {
    .card-columns {
        column-count: 1;
    }
}

@media (min-width: 992px) {
    .card-columns {
        column-count: 2;
    }
}

@media (min-width: 1200px) {
    .card-columns {
        column-count: 2;
    }
}

</style>
<body>

<!--   Header area -->
	<%@include file="../_header.jsp" %>
<!--   Header area -->
 <script type="text/javascript">
     $(function () {
    	 menu('home');
    	 if(e1_member_level < 20) location.href="<%=G_CONTEXT_PATH %>/etr/site_list.jsp";
    	 else if(e1_member_level < 30) location.href="<%=G_CONTEXT_PATH %>/etr/site_list.jsp";
    	 adminLogList(function(logs){
    		 if(logs){
	  				for(var i=0; i<logs.length; i++){
	  					$("#admin-ul").append(tagAdminLog(logs[i]));
	  					if(i >= 5) break;
	  				}
	  			}
    	 });
    	 controlLogList(function(logs){
    		 if(logs){
	  				for(var i=0; i<logs.length; i++){
	  					$("#control-ul").append(tagControlLog(logs[i]));
	  					if(i >= 5) break;
	  				}
	  			}
    	 });
    	 loginLogList(function(logs){
    			if(logs){
	  				for(var i=0; i<logs.length; i++){
	  					$("#login-ul").append(tagLoginLog(logs[i]));
	  					if(i >= 5) break;
	  				}
	  			}
    	 });
    	 scheduleLogList(function(logs){
    			if(logs){
	  				for(var i=0; i<logs.length; i++){
	  					$("#schedule-ul").append(tagScheduleLog(logs[i]));
	  					if(i >= 5) break;
	  				}
	  			}
    	 });
     });
 </script>
<!--  Main area -->
<div class="main container-fluid">

		  <!-- <div class="title container-fluid">
		 	 <h2><span class='fas fa-home' style='font-size:48px;'></span> HOME</h2>
		  	<p> </p>
		  </div> -->
		  <div class="title container-fluid">
		  	<div class="" style=""><span class="left-title">HOME</span></div><p> </p>
		  </div>
		  
		   <div class="container-fluid" style="margin:0;padding:0;width:100%;">
		   		<div class="card-columns">
					  	
					  	<script type="text/javascript">
					  	 function adminLogList(callback){
					  		    $("#admin-ul").html("");
					       		var param 		= "curPage=1";
					    		var REQ_TYPE 	= "POST";
					    		var REQ_URL  	= "./log/admin/list";
					    		$.ajax({
					    			type		: REQ_TYPE,
					    			url			: REQ_URL,
					    			data		: param,
					    			dataType	: "json", 
					    			async		: false,
					    			beforeSend	: function(){ loadingShow(); },
					    			success		: function(res){
					    						loadingHide();
					    						var str 		= JSON.stringify(res,null,2);
					    						var result 		= res.result;
					    						var status 		= result.status;
					    						var message 	= result.message;
					    						var data		= result.data;
					    						
					    						//alert(result.result+"\n"+message);
					    						
					    						if(status <= 100){
					    							callback(res.logs);
					    						}else{
					    							ajaxLoadFail(result);
					    						}
					    					 	
					    			},
					    			error		: function(){
					    							ajaxError();
					    			}
					    		});
					        }
					  		function tagAdminLog(log){
					  			var tag 			= new StringBuffer();
					  			
					  			var ad_type 		= log.ad_type;
					  			var ad_memo 		= log.ad_memo;
					  			var ad_table 		= log.ad_table.replace("e1_","");
					  			var ad_register 	= log.ad_register;
					  			
					  			var type_badge = ad_type == 'MOD' ? "warning" : "danger";
					  			
					  			if(ad_type == 'REG') type_badge = "success";
					  			
					  			if(ad_type == 'REG') ad_type = "<%=Lang.get("common.register") %>";
					     		if(ad_type == 'MOD') ad_type = "<%=Lang.get("common.modify") %>";
					     		if(ad_type == 'DEL') ad_type = "<%=Lang.get("common.delete") %>";
					     		
					  			
					  			tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-action\">");
					  			tag.append("<span><span class=\"badge badge-" + type_badge + "\" style=\"width:60px;\">" + ad_type + "</span> ");
					  			tag.append("<span class=\"badge badge-primary\" style=\"width:80px;\">" +ad_table + "</span></span>");
					  			tag.append("<span>" + ad_memo + "</span>");
					  			tag.append("<span class=\"badge badge-pill badge-secondary\">" + ad_register + "</span>");
					  			tag.append("</li>");
					  			
					  			
					  			return tag.toString();
					  		}
					  	</script>
					  	<div class="card bg-light border-secondary">
					       <h4 class="card-header"><%=Lang.get("menu.log.admin") %></h4>
					       <div class="card-body text-center" style="margin:0;padding:0; height: 300px;">
					       <ul class="list-group" id="admin-ul" name="admin-ul">
					       </ul>
					      </div>
					    </div>
					    
					    <script type="text/javascript">
					    function controlLogList(callback){
					    	$("#control-ul").html("");
				       		var param 		= "curPage=1";
				    		var REQ_TYPE 	= "POST";
				    		var REQ_URL  	= "./log/control/list";
				    		$.ajax({
				    			type		: REQ_TYPE,
				    			url			: REQ_URL,
				    			data		: param,
				    			dataType	: "json", 
				    			async		: false,
				    			beforeSend	: function(){ loadingShow(); },
				    			success		: function(res){
				    						loadingHide();
				    						var str 		= JSON.stringify(res,null,2);
				    						var result 		= res.result;
				    						var status 		= result.status;
				    						var message 	= result.message;
				    						var data		= result.data;
				    						
				    						//alert(result.result+"\n"+message);
				    						
				    						if(status <= 100){
				    							callback(res.logs);
				    						}else{
				    							ajaxLoadFail(result);
				    						}
				    					 	
				    			},
				    			error		: function(){
				    							ajaxError();
				    			}
				    		});
				        }
				  		function tagControlLog(log){
				  			var tag = new StringBuffer();
				  			var cl_memo 	= log.cl_memo;
				  			var cl_register = log.cl_register;
				  			var cl_type 	= log.cl_type;
				  			var si_name 	= log.si_name;
				  			var gate_number = log.gate_number;
				  			var mb_id		= log.mb_id;
				  			var badge_type	= "info";
				  			if(cl_type == 'OPEN'){
				  				cl_type = "<%=Lang.get("etr.button.open") %>";
				  				badge_type == "info";
				  			}
				  			if(cl_type == 'CLOSE'){
				  				cl_type = "<%=Lang.get("etr.button.close") %>";
				  				badge_type = "secondary";
				  			}
				  			if(cl_type == "CP_ENABLE"){
				  				cl_type = "<%=Lang.get("etr.button.enable") %>";
				  				badge_type = "success";
				  			}
				  			if(cl_type == "CP_DISABLE"){
				  				cl_type = "<%=Lang.get("etr.button.disable") %>";
				  				badge_type == "dark";
				  			}
				  			
				  			
				  			
				  			tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-action\">");
				  			tag.append("<span class=\"badge badge-pill badge-"+badge_type+"\" style=\"width:80px;\">" + cl_type + "</span>");
				  			tag.append("<span>" + si_name + "</span>");
				  			tag.append("<span>" + gate_number + "</span>");
				  			tag.append("<span>" + mb_id + "</span>");
				  			tag.append("<span class=\"badge badge-pill badge-secondary\">" + cl_register + "</span>");
				  			tag.append("</li>");
				  			
				  			return tag.toString();
				  		}
					    </script>
					    
					    
					    
					    
					    <div class="card bg-light border-secondary">
					       <h4 class="card-header"><%=Lang.get("menu.log.control") %></h4>
					      <div class="card-body text-center" style="margin:0;padding:0; height: 300px;">
					       <ul class="list-group" id="control-ul" name="control-ul">
						   </ul>
					      </div>
					    </div>
					    
					    
					    
			   </div>
			   <div class="card-columns">
						<script type="text/javascript">
					    function loginLogList(callback){
					    	$("#login-ul").html("");
					    	
				       		var param 		= "curPage=1";
				    		var REQ_TYPE 	= "POST";
				    		var REQ_URL  	= "./log/login/list";
				    		$.ajax({
				    			type		: REQ_TYPE,
				    			url			: REQ_URL,
				    			data		: param,
				    			dataType	: "json", 
				    			async		: false,
				    			beforeSend	: function(){ loadingShow(); },
				    			success		: function(res){
				    						loadingHide();
				    						var str 		= JSON.stringify(res,null,2);
				    						var result 		= res.result;
				    						var status 		= result.status;
				    						var message 	= result.message;
				    						var data		= result.data;
				    						
				    						//alert(result.result+"\n"+message);
				    						
				    						if(status <= 100){
				    							callback(res.logs);
				    						}else{
				    							ajaxLoadFail(result);
				    						}
				    					 	
				    			},
				    			error		: function(){
				    							ajaxError();
				    			}
				    		});
				        }
				  		function tagLoginLog(log){
				  			var tag = new StringBuffer();
				  			var lo_type     = log.lo_type;
				  			var lo_datetime = log.lo_datetime;
				  			var gr_name		= log.gr_name;
				  			var mb_id		= log.mb_id;
				  			
				  			var badge_type	= lo_type == 'LOGIN' ? "success" : "danger";
				  			if(lo_type == 'LOGIN'){
				  				badge_type = "success";
				  				lo_type = "<%=Lang.get("login.button.login") %>";
				  			}
				  			if(lo_type == 'LOGOUT'){
				  				badge_type = "danger";
				  				lo_type = "<%=Lang.get("login.button.logout") %>";
				  			}
				  			
				  			tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-action\">");
				  			
				  			tag.append("<span class=\"badge badge-pill badge-"+badge_type+"\" style=\"width:60px;\">" + lo_type + "</span>");
				  			tag.append("<span>" + gr_name + "</span>");
				  			tag.append("<span>" + mb_id + "</span>");
				  			tag.append("<span class=\"badge badge-pill badge-secondary\">" + lo_datetime + "</span>");
				  			tag.append("</li>");
				  			
				  			return tag.toString();
				  		}
					    </script>		   
					  	<div class="card bg-light border-secondary">
					      <h4 class="card-header"><%=Lang.get("menu.log.login") %></h4>
					      <div class="card-body text-center" style="margin:0;padding:0; height: 300px;">
					        <ul class="list-group" id="login-ul" name="login-ul">
						   </ul>
					      </div>
					    </div>
					    
					    
					    <script type="text/javascript">
					    function scheduleLogList(callback){
					    	$("#schedule-ul").html("");
				       		var param 		= "curPage=1";
				    		var REQ_TYPE 	= "POST";
				    		var REQ_URL  	= "./log/schedule/list";
				    		$.ajax({
				    			type		: REQ_TYPE,
				    			url			: REQ_URL,
				    			data		: param,
				    			dataType	: "json", 
				    			async		: false,
				    			beforeSend	: function(){ loadingShow(); },
				    			success		: function(res){
				    						loadingHide();
				    						var str 		= JSON.stringify(res,null,2);
				    						var result 		= res.result;
				    						var status 		= result.status;
				    						var message 	= result.message;
				    						var data		= result.data;
				    						
				    						//alert(result.result+"\n"+message);
				    						
				    						if(status <= 100){
				    							callback(res.logs);
				    						}else{
				    							ajaxLoadFail(result);
				    						}
				    					 	
				    			},
				    			error		: function(){
				    							ajaxError();
				    			}
				    		});
				        }
				  		function tagScheduleLog(log){
				  			var tag = new StringBuffer();
				  			var gr_name		= log.gr_name;
				  			var si_name     = log.si_name;
				  			var gate_number = log.gate_number;
				  			var sl_register	= log.sl_register;
				  			var sl_type		= log.sl_type;
				  			
				  			var type_badge = sl_type == 'MOD' ? "warning" : "danger";
				  			if(sl_type == 'REG') {
				  				sl_type = "<%=Lang.get("common.register")%>";
				  				type_badge = "success";
				  			}
				  			if(sl_type == 'MOD') {
				  				sl_type = "<%=Lang.get("common.modify")%>";
				  				type_badge = "warning";
				  			}
				  			if(sl_type == 'DEL'){
				  				sl_type = "<%=Lang.get("common.delete")%>";
				  				type_badge = "danger";
				  			}
				  			
				  			
				  			
				  			tag.append("<li class=\"list-group-item d-flex justify-content-between align-items-center list-group-item-action\">");
				  			
				  			tag.append("<span class=\"badge badge-pill badge-"+type_badge+"\" style=\"width:80px;\">" + sl_type + "</span>");
				  			tag.append("<span>" + gr_name + "</span>");
				  			tag.append("<span>" + si_name + "</span>");
				  			tag.append("<span>" + gate_number + "</span>");
				  			tag.append("<span class=\"badge badge-pill badge-secondary\">" + sl_register + "</span>");
				  			tag.append("</li>");
				  			
				  			return tag.toString();
				  		}
					    </script>
					    
					    
					   <div class="card bg-light border-secondary">
					      <h4 class="card-header"><%=Lang.get("menu.log.schedule") %></h4>
					      <div class="card-body text-center" style="margin:0;padding:0; height: 300px;">
					       <ul class="list-group" id="schedule-ul" name="schedule-ul">
					       </ul>
					      </div>
					    </div>
			    </div>
 		   </div>
</div> 
<!--  Main area -->

<!--  Footer area -->
<%@include file="../_tail.jsp" %>
<!--  Footer area -->

</body>
</html>


