<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCUTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
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

<div class="container text-center">
  <h2>Web UI Test Site</h2>
  <p>This is test UI site for programs</p>            
  <table class="table table-dark table-hover">
    <tbody>
      <tr>
        <td><a href="lottery/">Lottery</a></td>
      </tr>
      <tr>
        <td><a href="today/">Stock</a></td>
      </tr>
      <tr>
        <td><a href="bybit/">Coin</a></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>