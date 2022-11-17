<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<div class="col-sm-2">
		   <!-- List-Group Panel -->
				<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-random" aria-hidden="true"></i>  종목 정보</h5>
				</div>
				<div class="list-group list-group-flush stock-item" style="min-height:150px;">
				 	<div class="list-group-item"> 종목명 : <span></span></div>
			    	<div class="list-group-item"> 잔고 : <span></span></div>
			    	<div class="list-group-item"> 평균가 : <span></span></div>
			    	<div class="list-group-item"> 현재가: <span></span></div>
			    	<div class="list-group-item"> 수익금 : <span></span></div>
			    	<div class="list-group-item"> 수익률 : <span></span></div>
			    	  
				</div>
			</div>
			<br>
			<!-- List-Group Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-random" aria-hidden="true"></i> 최근 매수 </h5>
				</div>
				<!-- <div class="list-group list-group-flush recently-buy" style="min-height:220px;"> -->
				<table class="table" style="min-height:220px;font-size:12px;">
					<tbody class="recently-buy"></tbody>
				</table>
			</div>
			<br>
			
			<!-- List-Group Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-random" aria-hidden="true"></i> 최근 매도</h5>
				</div>
				<table class="table" style="min-height:220px;font-size:12px;" >
					<tbody class="recently-sell">
					
					</tbody>
				</table>
			</div>
			<br>
			
			<!-- Text Panel -->
			<script type="text/javascript">
			
				function setStockItem(idx){
					  var co = stocks[idx];
			    	  $(".stock-item").html("");
			    	  
			    	  var color = "black";
			    	  color = parseInt(co.ms_average) < parseInt(co.ms_today) ? "red" : "blue";
			    	  
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 종목명 : <span> "+co.co_name+"</span></div>");
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 잔고 : <span> "+ comma(co.ms_balance)+"</span></div>");
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 평균가 : <span> "+ comma(co.ms_average)+"</span></div>");
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 현재가: <span style=\"color:"+color+"\"> "+ comma(co.ms_today)+"</span></div>");
			    	 
			    	  var purchase = parseInt(co.ms_average) * parseInt(co.ms_balance);
			    	  var evaluation = parseInt(co.ms_today) * parseInt(co.ms_balance);
			    	  var profit = evaluation - purchase;
			    	  profit = profit - (evaluation*0.0025);
			    	  var ration =  (profit) / ( purchase / 100);
			    	  
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 수익금: <span style=\"color:"+color+"\"> "+ comma(String(profit.toFixed(0)))+"</span></div>");
			    	  $(".stock-item").append("<div class=\"list-group-item\"> 수익률: <span style=\"color:"+ (ration < 0 ? "blue" : "red") +"\"> "+ comma(String(ration.toFixed(2)))+"%</span></div>");
				    	 	 
			    	  
			    	  recentlyList(co.co_code, 'buy');
			    	  recentlyList(co.co_code, 'sell');
				}
				function recentlyList(type){
					recentlyList('000100',type);
					
				}
				function recentlyList(code, type){
					var param 		="co_code="+code+"&tr_type="+type;
		    		var REQ_TYPE 	= "get";
		    		var REQ_URL  	= "../transaction/list";
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
		    							var transactions = res.transactions;
		    							console.log(transactions);
		    							if(type == 'buy'){
		    								updateRecentlyList("recently-buy", transactions);
		    							}else {
		    								updateRecentlyList("recently-sell", transactions);
		    							}
		    							
		    						}else {
		    							ajaxLoadFail(result);
		    						}
		    					 	
		    			},
		    			error		: function() {
		    						ajaxError();
		    			}
		    		});
				}
				
				function updateRecentlyList(tag, transactions){
					$("."+tag).html('');
					var len = transactions.length > 5 ? 5 : transactions.length; 
					for(var i=0; i<len; i++){
						var item = transactions[i];
						/* $("."+tag).append("<a href=\"#\" class=\"list-group-item list-group-item-action\">"+item.tr_date+"\t\t"+comma(item.tr_price)+" \t\t"+comma(item.tr_quantity)+"</a>"); */
						
						$("."+tag).append("<tr><td style=\"text-align:left;\">"+item.tr_date+"</td><td style=\"text-align:center;\">"+comma(item.tr_price)+"</td><td style=\"text-align:right;\">"+comma(item.tr_quantity)+"</td></tr>");
					
					
					}
				}
				
				
				
				function calInputAction(){
					var p = $("#input-cal-price").val();
					var q = $("#input-cal-quantity").val();
					
					if(p != '' && q != ''){
						var purchase = parseInt(p)*parseInt(q);
						$("#input-cal-purchase").val(comma(String(purchase)));
					}else {
						$("#input-cal-purchase").val("0");
					}
				
					
				}
			</script>
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-cog" aria-hidden="true"></i> 계산기</h5>
				</div>

				<div class="card-body">
					<div class="input-group">
					     <div class="input-group-prepend">
					       <span class="input-group-text">가격</span>
					    </div>
					    <input type="text" class="form-control" id="input-cal-price" name="input-cal-price" onkeyup="calInputAction()">
					  </div>
					  <div class="input-group">
					     <div class="input-group-prepend">
					       <span class="input-group-text">수량</span>
					    </div>
					    <input type="text" class="form-control" id="input-cal-quantity" name="input-cal-quantity" onkeyup="calInputAction()">
					  </div>
					  <div class="input-group">
					     <div class="input-group-prepend">
					       <span class="input-group-text">총액</span>
					    </div>
					    <input type="text" class="form-control" id="input-cal-purchase" name="input-cal-purchase">
					  </div>
					<p class="card-text">
					
					</p>
					<p><button class="btn btn-secondary">예상</button></p>
				</div>
			</div>
			<br>
			<!-- Text Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title">
						<i class="far fa-bullhorn" aria-hidden="true"></i>
						Active Predomination
					</h5>
				</div>
				<div class="card-body">
					<p class="card-text">Proactively envisioned multimedia based expertise and cross-media growth strategies.</p>
					<div class="btn-group btn-group-sm" role="group">
						<button type="button" class="btn btn-secondary">Resource</button>
						<button type="button" class="btn btn-secondary">Envision</button>
						<button type="button" class="btn btn-secondary">Niche</button>
					</div>
				</div>
			</div>	
				
				
		<br>
			<!-- Progress Bars -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title">
						<i class="fa fa-tachometer" aria-hidden="true"></i> 
						Dramatically Engage
					</h5>
				</div>
				<div class="card-body">
                    <div class="text-xs-center" id="progress-caption-1">Proactively Envisioned &hellip; 100%</div>
                    <progress class="progress progress-success" value="100" max="100" aria-describedby="progress-caption-1" style="width:100%;"></progress>
                    <div class="text-xs-center" id="progress-caption-2">Objectively Innovated &hellip; 80%</div>
                    <progress class="progress progress-info" value="80" max="100" aria-describedby="progress-caption-2" style="width:100%;"></progress>
                    <div class="text-xs-center" id="progress-caption-3">Portalled &hellip; 45%</div>
                    <progress class="progress progress-warning" value="45" max="100" aria-describedby="progress-caption-3" style="width:100%;"></progress>
                    <div class="text-xs-center" id="progress-caption-4">Done &hellip; 35%</div>
                    <progress class="progress progress-danger" value="35" max="100" aria-describedby="progress-caption-4" style="width:100%;"></progress>
				</div>
			</div>
			
			<br>
			<!-- Carousel --> 
 			<h4><i class="fa fa-language" aria-hidden="true"></i> Synergization</h4>
			<div id="side-carousel" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#side-carousel" data-slide-to="0" class="active"></li>
					<li data-target="#side-carousel" data-slide-to="1"></li>
					<li data-target="#side-carousel" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner bg-danger" role="listbox">
					<div class="carousel-item active">
						<a href="#">
							<img class="img-responsive" src="https://imgnews.pstatic.net/image/thumb120/028/2021/03/05/2535158.jpg" alt="" >
						</a>
						<div class="carousel-caption">
							<h3>Dramatically Engage</h3>
							<p>Objectively innovate empowered manufactured products whereas parallel platforms.</p>
						</div>
					</div>
					<div class="carousel-item">
						<a href="#">
							<img class="img-responsive" src="https://imgnews.pstatic.net/image/thumb120/077/2021/03/05/5113993.jpg">
						</a>
						<div class="carousel-caption">
							<h3>Efficiently Unleash</h3>
							<p>Dramatically maintain clicks-and-mortar solutions without functional solutions.</p>
						</div>
					</div>
					<div class="carousel-item">
						<a href="#">
							<img class="img-responsive" src="https://imgnews.pstatic.net/image/thumb120/028/2021/03/05/2535156.jpg" alt="" >
						</a>
						<div class="carousel-caption">
							<h3>Proactively Pontificate</h3>
							<p>Holistically pontificate installed base portals after maintainable products.</p>
						</div>
					</div>			  
				</div>
				<a class="left carousel-control" href="#side-carousel" role="button" data-slide="prev">
				  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				  <span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#side-carousel" role="button" data-slide="next">
				  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				  <span class="sr-only">Next</span>
				</a>
			  </div>
			  
			  
			  
			  <hr>
			  <div id="demo" class="carousel slide" data-ride="carousel">
				  <ul class="carousel-indicators">
				    <li data-target="#demo" data-slide-to="0" class="active"></li>
				    <li data-target="#demo" data-slide-to="1"></li>
				    <li data-target="#demo" data-slide-to="2"></li>
				  </ul>
				  <div class="carousel-inner bg-secondary">
				    <div class="carousel-item active">
				      <img src="https://imgnews.pstatic.net/image/thumb120/077/2021/03/05/5113992.jpg" alt="Los Angeles">
				      <div class="carousel-caption">
				        <h3>Los Angeles</h3>
				        <p>We had such a great time in LA!</p>
				      </div>   
				    </div>
				    <div class="carousel-item">
				        <img src="https://imgnews.pstatic.net/image/thumb120/077/2021/03/05/5113991.jpg" alt="Los Angeles">
				      <div class="carousel-caption">
				        <h3>Chicago</h3>
				        <p>Thank you, Chicago!</p>
				      </div>   
				    </div>
				    <div class="carousel-item">
				      <img src="https://imgnews.pstatic.net/image/thumb120/077/2021/03/05/5113990.jpg" alt="Los Angeles">
				      <div class="carousel-caption">
				        <h3>New York</h3>
				        <p>We love the Big Apple!</p>
				      </div>   
				    </div>
				  </div>
				  <a class="carousel-control-prev" href="#demo" data-slide="prev">
				    <span class="carousel-control-prev-icon"></span>
				  </a>
				  <a class="carousel-control-next" href="#demo" data-slide="next">
				    <span class="carousel-control-next-icon"></span>
				  </a>
				</div>
		</div><!--/Left Column-->
