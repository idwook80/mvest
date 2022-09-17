<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCUTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>M-vest</title>
</head>

  <script src="./webjars/jquery/3.3.1/jquery.min.js"></script>
  <script src="./webjars/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <script src="./webjars/popper.js/1.14.3/umd/popper.min.js"></script>
  <link rel="stylesheet" href="./webjars/bootstrap/4.4.1/css/bootstrap.min.css" />
  
   <script type="text/javascript">
     $(function () {
    	 list();
     });
	  function list(){
	    		var param 		= $("#pageForm").serialize();
	    		var REQ_TYPE 	= "POST";
	    		var REQ_URL  	= "./company/list";
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
	    							/* updateTotal(res.total);
	    							updateList(res.groups);
	    							updatePaging(res.vo); */
	    						}else {
	    							ajaxLoadFail(result);
	    						}
	    					 	
	    			},
	    			error		: function() {
	    						ajaxError();
	    			}
	    		});
	     }
  
  
  </script>
  
<body>

<div class="container">
  <h2>Hoverable Dark Table</h2>
  <p>The .table-hover class adds a hover effect (grey background color) on table rows:</p>            
  <table class="table table-dark table-hover">
    <thead>
      <tr>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
      </tr>
      <tr>
        <td>Mary</td>
        <td>Moe</td>
        <td>mary@example.com</td>
      </tr>
      <tr>
        <td>July</td>
        <td>Dooley</td>
        <td>july@example.com</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>