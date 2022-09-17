<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCUTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>M-vest</title>
</head>

  <script src="../webjars/jquery/3.3.1/jquery.min.js"></script>
  <script src="../webjars/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <script src="../webjars/popper.js/1.14.3/umd/popper.min.js"></script>
  <link rel="stylesheet" href="../webjars/bootstrap/4.4.1/css/bootstrap.min.css" />
  <script src="../js/common_20200612.js"></script>
  
   <script type="text/javascript">
     $(function () {
    	 list();
     });
	  function list(){
	    		var param 		= $("#pageForm").serialize();
	    		var REQ_TYPE 	= "POST";
	    		var REQ_URL  	= "../company/list";
	    		$.ajax({
	    			type		: REQ_TYPE,
	    			url			: REQ_URL,
	    			data		: param,
	    			dataType	: "json", 
	    			async		: true,
	    			beforeSend	: function(){/*  loadingShow(); */ },
	    			success		: function(res){
	    						/* loadingHide(); */
	    						var str 		= JSON.stringify(res,null,2);
	    						var result 		= res.result;
	    						var status 		= result.status;
	    						var message 	= result.message;
	    						var data		= result.data;
	    						
	    						//alert(result.result+"\n"+message);
	    						
	    						if(status <= 100){
	    							var companies = res.companies;
	    							console.log(companies);
	    							/* updateTotal(res.total);*/
	    							updateList(companies);
	    							updatePaging(res.vo); 
	    						}else {
	    							ajaxLoadFail(result);
	    						}
	    					 	
	    			},
	    			error		: function() {
	    						ajaxError();
	    			}
	    		});
	     }
	  function updateList(list){
	    	 $("#table-body").html('');
	    	 if(list){
		    	 for(var i=0; i<list.length; i++){
					var item = list[i];
					$("#table-body").append(getItemTag(item,i));
		    	 }
	    	 }
	  }
	  function getItemTag(item,idx){
		  var tag 	= new StringBuffer();
	    	// var link 	= "../group/group_site_list.jsp?gr_id="+g.gr_id+"&list_page="+$("#pageForm #curPage").val();
	    	 
	    	 tag.append("<tr class=\"text-center\">");
			 tag.append("<td>" + item.co_id + "</td>");
			 tag.append("<td>" + item.co_code + "</td>");
			 tag.append("<td>" + item.co_name + "</td>");
			 tag.append("<td>" + comma(item.to_price) + "</td>");
			 tag.append("<td>" + comma(item.to_yesterday) + "</td>");
			
			 var previous = parseFloat(item.to_previous);
			 if(previous < 0){
				 tag.append("<td style=\"color:blue;\">" + comma(item.to_previous) + "</td>");
				 tag.append("<td style=\"color:blue;\"><i class='fas fa-arrow-down'></i></td>");
				 
			 }else {
				 tag.append("<td style=\"color:red;\">" + comma(item.to_previous) + "</td>");
				 tag.append("<td style=\"color:red;\"><i class='fas fa-arrow-up'></i></td>");
			 }
			 
			 tag.append("</tr>");
			 
	    	 return tag.toString();
	  }
  </script>
  
<body>

 <div class="main container-fluid">
		
				  <div class="title container-fluid">
				 	<%-- <h2><span class="fa fa-group" style="font-size:48px;"></span> <%=Lang.get("group.title") %></h2> --%>
				  	<p>List </p>
				  </div>
				  <div class="container-fluid text-right" style="margin-bottom:10px;">
				    <span class="" id="list-total" style="float:left;">Total (<span id="total-count">0</span>)</span>
				  	<a href="javascript:void(0);" class="btn btn-info" data-toggle="modal" data-target="#groupModal" onclick="addModal()">등록</a>
				  </div>
				  <div class="table-responsive" style="min-height:400px;">
						  <table class="table table-hover table-striped">
						    <thead class="thead-dark">
						      <tr class="text-center">
						        <th>ID</th>
						        <th>Code</th>
						        <th>Name</th>
						        <th>Today</th>
						        <th>Yesterday</th>
						        <th>P</th>
						        <th>I</th>
						      </tr>
						    </thead>
						    <tbody id="table-body">
						    
						    </tbody>
						  </table>
				  </div>
				 <%@include file="../_paging.jsp" %>
 	
</div> 



</body>
</html>