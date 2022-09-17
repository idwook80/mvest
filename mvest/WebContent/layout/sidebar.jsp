<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- sidebar Start  -->
        <nav id="sidebar"> 
            <div class="sidebar-header">
            	 <div id="dismiss">
		               <!--  <i class="fas fa-arrow-right fa-spin fa-pulse"></i> -->
		               <span class="fa-stack">
		                <i class="fas fa-times fa-stack-1x"></i>
		                <!-- <i class="fas fa-ban fa-stack-2x text-danger" style="colore:red;"></i> -->
		                </span>
		            </div>
                <h3>사이드 메뉴</h3>
            </div>

            <ul class="list-unstyled components">
                <p>Dummy Heading</p>
                <li class="active">
                    <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" >
					  <i class="fas fa-home"></i>   Home       <span class="text-right" style="float:right"><i class="fas fa-plus"></i></span>             
                    </a>
                 
                    <ul class="collapse list-unstyled" id="homeSubmenu">
                        <li>
                            <a href="#">Home 1</a>
                        </li>
                        <li>
                            <a href="#">Home 2</a>
                        </li>
                        <li>
                            <a href="#">Home 3</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#testSubmenu" data-toggle="collapse" aria-expanded="false">
                    	<i class="fas fa-building"></i> TestMenu <span class="text-right" style="float:right"><i class="fas fa-plus"></i></span>  
                    	</a>
                    <ul class="collapse list-unstyled" id="testSubmenu">
                        <li>
                            <a href="#">Test 1</a>
                        </li>
                        <li>
                            <a href="#">Test 2</a>
                        </li>
                        <li>
                            <a href="#">Test 3</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">
                    <i class="fas fa-credit-card"></i>   Pages <span class="text-right" style="float:right"><i class="fas fa-plus"></i></span>  
                    </a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="#">Page 1</a>
                        </li>
                        <li>
                            <a href="#">Page 2</a>
                        </li>
                        <li>
                            <a href="#">Page 3</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#"> <i class="fas fa-door-open"></i>  About</a>
                </li>
                
                <li>
                    <a href="#">Portfolio</a>
                </li>
                <li>
                    <a href="#">Contact</a>
                </li>
            </ul>

            <ul class="list-unstyled CTAs">
                <li>
                    <a href="https://bootstrapious.com/tutorial/files/sidebar.zip" class="download">Download source</a>
                </li>
                <li>
                    <a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a>
                </li>
            </ul>
            <div class="text-center" style="padding:20px;color:gray;">
           	<i class="fab fa-bluetooth"></i>
           	<i class="fas fa-tablet-alt"></i>
           	<i class="fas fa-wifi"></i>
           	<i class="fas fa-network-wired"></i>
           	<i class="fas fa-battery-three-quarters"></i>
           	<i class="fas fa-link"></i>
           	
           	
           	<!-- 
           	<i class="fab fa-facebook"></i>
           	<i class="fab fa-twitter"></i>
           	<i class="fab fa-github"></i>
           	<i class="fab fa-linkedin"></i>
           	<i class="fab fa-line"></i>
           	 -->
           </div>
        </nav>
<!-- sidebar End  -->
<script type="text/javascript">
     $(document).ready(function () {
         $("#sidebar").mCustomScrollbar({
             theme: "minimal"
         });

         $('#dismiss, .overlay').on('click', function () {
             $('#sidebar').removeClass('active');
             $('.overlay').removeClass('active');
         });

         $('#brand').on('click', function () {
             $('#sidebar').addClass('active');
             $('.overlay').addClass('active');
             $('.collapse.in').toggleClass('in');
             $('a[aria-expanded=true]').attr('aria-expanded', 'false');
         });
 	});
     
     
 </script>