<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<div class="col-sm-2">
			<!-- List-Group Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-random" aria-hidden="true"></i> 최근 잔고</h5>
				</div>
				<table class="table" style="min-height:220px;" >
					<tbody class="today-list">
					</tbody>
				</table>
			</div>
			<br>
			
			<script type="text/javascript">
				function updateTodayList(list){
					$(".today-list").html("");
					if(list){
						var len = list.length > 5 ? 5 : list.length;
						
						for(var i=0; i<len; i++){
							var item = list[i];
							var color = parseInt(item.to_average) < parseInt(item.to_price) ?  "red" : "blue";
							$(".today-list").append("<tr>");
							$(".today-list").append("<td style=\"text-align:left;\">"+item.to_date.substring(2)+"</td>");
							$(".today-list").append("<td style=\"text-align:center;\">"+comma(item.to_balance)+"</td>");
							$(".today-list").append("<td style=\"text-align:center;color:"+color+";\">"+comma(item.to_average)+"</td>");
							$(".today-list").append("<td style=\"text-align:right;\">"+comma(item.to_price)+"</td>");
							$(".today-list").append("</tr>");
						}
					}
				}
			
			</script>			
			
			
			
			<!-- Text Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title">
						<i class="fa fa-bullhorn" aria-hidden="true"></i>
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
