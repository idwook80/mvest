<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<%@ include file="common.jsp" %>
<style>
h1, h2, h3, h4, h5, h6 {
	color: black;
	}

#side-carousel img {
	margin: 0 auto;
	}

.footer-blurb {
    padding: 30px 0;
    margin-top: 20px;
    background-color: #eee;
    color: black;
}
    
.footer-blurb-item {
    padding: 20px;
    }
 
.small-print {
	background-color: #fff;
	padding: 30px 0;
}

.small-print {
	text-align: center;
	}
</style>
<body>


<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <a class="navbar-brand" href="#">LOGO</a>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
   <ul class="nav navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Products</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Services
                    </a>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="#">Engage</a>
                        <a class="dropdown-item" href="#">Pontificate</a>
                        <a class="dropdown-item" href="#">Synergize</a>
                    </div>
                </li>
            </ul>
  </div>  
  <form class="form-inline" action="/action_page.php">
    <input class="form-control mr-sm-2" type="text" placeholder="Search">
    <button class="btn btn-secondary" type="submit">Search</button>
  </form>
  <button class="navbar-toggler" style="float: right;"type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
</nav>

<br>
<div class="container-fluid row">

		<!-- Left Column -->
		<div class="col-sm-2">
		
				<!-- Form --> 
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title">
						<i class="fa fa-sign-in" aria-hidden="true"></i> 
						Log In
					</h5>
				</div>
				<div class="card-body">
					<form>
						<div class="form-group">
							<input type="text" class="form-control" id="uid" name="uid" placeholder="Username">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password">
						</div>
						<button type="submit" class="btn btn-primary">Log In</button>
					</form>
				</div>
			</div>
			<br>
		

			<!-- List-Group Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-random" aria-hidden="true"></i> Completely Synergize</h5>
				</div>
				<div class="list-group list-group-flush">
					<a href="#" class="list-group-item list-group-item-action">Resource Taxing</a>
					<a href="#" class="list-group-item list-group-item-action">Premier Niche Markets</a>
					<a href="#" class="list-group-item list-group-item-action">Dynamically Innovate</a>
					<a href="#" class="list-group-item list-group-item-action">Objectively Innovate</a>
					<a href="#" class="list-group-item list-group-item-action">Proactively Envisioned</a>
				</div>
			</div>
			<br>
			<!-- Text Panel -->
			<div class="card">
				<div class="card-header p-b-0">
					<h5 class="card-title"><i class="fa fa-cog" aria-hidden="true"></i> Dramatically Engage</h5>
				</div>

				<div class="card-body">
					<p class="card-text">Objectively innovate empowered manufactured products whereas parallel platforms. Holisticly predominate extensible testing procedures for reliable supply chains. Dramatically engage top-line web services vis-a-vis cutting-edge deliverables.</p>
					<p><button class="btn btn-secondary">Engage</button></p>
				</div>
			</div>
			<br>
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
  
  
		<!-- Center Column -->
		<div class="col-sm-9">
		
			<!-- Alert -->
			<div class="alert alert-success alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<strong>Synergize:</strong> Seamlessly visualize quality intellectual capital!
			</div>		
			
			<!-- Articles -->
			<div class="row">
				<article class="col-xs-12">
					<h2>Premier Niche Markets</h2>
					<p>Phosfluorescently engage worldwide methodologies with web-enabled technology. Interactively coordinate proactive e-commerce via process-centric "outside the box" thinking. Completely pursue scalable customer service through sustainable potentialities.</p>
					<p><button class="btn btn-outline-success">Read More</button></p>
					<p class="pull-right"><span class="tag tag-default">keyword</span> <span class="tag tag-default">tag</span> <span class="tag tag-default">post</span></p>
					<ul class="list-inline">
						<li class="list-inline-item"><a href="#">Today</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-comment"></span> 2 Comments</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-share"></span> 8 Shares</a></li>
					</ul>
				</article>
			</div>
			<hr>
			<div class="row">
				<article class="col-xs-12">
					<h2>Proactively Envisioned</h2>
					<p>Seamlessly visualize quality intellectual capital without superior collaboration and idea-sharing. Holistically pontificate installed base portals after maintainable products. Proactively envisioned multimedia based expertise and cross-media growth strategies.</p>
					<p><button class="btn btn-outline-primary">Read More</button></p>
					<p class="pull-right"><span class="tag tag-default">keyword</span> <span class="tag tag-default">tag</span> <span class="tag tag-default">post</span></p>
					<ul class="list-inline">
						<li class="list-inline-item"><a href="#">Yesterday</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-comment"></span> 21 Comments</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-share"></span> 36 Shares</a></li>
					</ul>
				</article>
			</div>
			<hr>      
			<div class="row">
				<article class="col-xs-12">
					<h2>Completely Synergize</h2>
					<p>Completely synergize resource taxing relationships via premier niche markets. Professionally cultivate one-to-one customer service with robust ideas. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>
					<p><button class="btn btn-outline-danger">Read More</button></p>
					<p class="pull-right"><span class="tag tag-default">keyword</span> <span class="tag tag-default">tag</span> <span class="tag tag-default">post</span></p>
					<ul class="list-inline">
						<li class="list-inline-item"><a href="#">2 Days Ago</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-comment"></span> 12 Comments</a></li>
						<li class="list-inline-item"><a href="#"><span class="glyphicon glyphicon-share"></span> 18 Shares</a></li>
					</ul>
				</article>
			</div>
			<hr>
		</div><!--/Center Column-->


	  <!-- Right Column  
	  <div class="col-sm-1">
	  </div>< /Right Column -->

	</div><!--/container-fluid-->
	
	<footer>
		<div class="footer-blurb">
			<div class="container">
				<div class="row">
					<div class="col-sm-3 footer-blurb-item">
						<h3><i class="fa fa-text-height" aria-hidden="true"></i> Dynamic</h3>
						<p>Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits. Dramatically visualize customer directed convergence without revolutionary ROI.</p>
						<p><a class="btn btn-primary" href="#">Procrastinate</a></p>
					</div>
					<div class="col-sm-3 footer-blurb-item">
						<h3><i class="fa fa-wrench" aria-hidden="true"></i> Efficient</h3>
						<p>Dramatically maintain clicks-and-mortar solutions without functional solutions. Efficiently unleash cross-media information without cross-media value. Quickly maximize timely deliverables for real-time schemas. </p>
						<p><a class="btn btn-success" href="#">Unleash</a></p>
					</div>
					<div class="col-sm-3 footer-blurb-item">
						<h3><i class="fa fa-paperclip" aria-hidden="true"></i> Complete</h3>
						<p>Professionally cultivate one-to-one customer service with robust ideas. Completely synergize resource taxing relationships via premier niche markets. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>
						<p><a class="btn btn-primary" href="#">Complete</a></p>
					</div>
					<div class="col-sm-3 footer-blurb-item">
						
						<!-- Thumbnails --> 
						<h3><i class="fa fa-camera" aria-hidden="true"></i> Phosfluorescent</h3>
							<div class="row">
								<div class="col-xs-6">
									<a href="#" class="img-fluid">
										<img src="holder.js/110x80?theme=vine" alt="">
									</a>
								</div>
								<div class="col-xs-6">
									<a href="#" class="img-fluid">
										<img src="holder.js/110x80?theme=sky" alt="">
									</a>
								</div>
								<div class="col-xs-6">
									<a href="#" class="img-fluid">
										<img src="holder.js/110x80?theme=sky" alt="">
									</a>
								</div>
								<div class="col-xs-6">
									<a href="#" class="img-fluid">
										<img src="holder.js/110x80?theme=vine" alt="">
									</a>
								</div>
							</div>
							
					</div>

				</div>
				<!-- /.row -->	
			</div>
        </div>
        
        <div class="small-print">
        	<div class="container">
        		<p><a href="#">Terms &amp; Conditions</a> | <a href="#">Privacy Policy</a> | <a href="#">Contact</a></p>
        		<p>Copyright &copy; Example.com 2015 </p>
        	</div>
        </div>
	</footer>

	
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    
    <!-- Initialize Bootstrap functionality -->
    <script>
    // Initialize tooltip component
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })

    // Initialize popover component
    $(function () {
      $('[data-toggle="popover"]').popover()
    })
    </script> 
    
	<!-- Placeholder Images -->
	<script src="js/holder.min.js"></script>
	
</body>
    
    
    
</html>
