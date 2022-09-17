<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>

<body>
<!-- header area -->
	<%@include file="header.jsp" %>
<!--  header end -->

<!-- main start  -->
<div class="main container-fluid">
	<h2>달력</h2>
	
	<style>
		.calendar-month .date-date {
			font-weight: bold;
		}
		.calendar-month .date-msg {
			text-align: left;
			color:#6d7fcc;
			display:inline-block;
			width:100%;
		    white-space:nowrap;
		    overflow:hidden;
		    text-overflow:ellipsis;
		}
		.calendar-month .date-plus {
			padding-right:10px;
			display:inline-block;
			color:red;
			float: right;
			text-overflow: ellipsis;
		}
		.calendar-month li {
		    margin: 0 0 0 0;
		    padding: 0 0 0 0;
		    border : 1px solid #efefef;
		    width:14.26%;
		    list-style: none;
		    float: left;
		    position: relative;
		    height:100px;
		}
		.day-area li {
			font-family: 'Poppins', sans-serif;
		    font-size: 1.5em;
		    font-weight: 300;
		    line-height: 2.0em;
			width:100%;
			text-align: center;
			margin: 0 0 0 0;
		    padding: 0 0 0 0;
		    border : 1px solid #efefef;
		    width:14.26%;
		    list-style: none;
		    float: left;
		    position: relative;
		}
		.day-area .day-label {
			background: lightgray;
			height:100%;
		}
	</style>
   <div class="calendar-ctr row container-fluid">
   		<div class="col-sm-4 text-right">
   			<a href="#" style='font-size:24px' class="btn"><i class='fas fa-angle-left'></i></a>
   		</div>
   		<div class="col-sm-4 text-center"><a href="#" class="btn btn-basic" style="width:100%;">2020-04</a></div>
   		<div class="col-sm-4 text-left">
   			<a href="#" style="font-size:24px" class="btn"> <i class="fas fa-angle-right"></i></a>
   		</div>
   </div>
   <div class="today"> TODAY : <span id="today">2020-04-02</span></div>
   <div class="day-area">
  		 <!-- row.1 -->
  	   			<ul class="list-group list-group-horizontal">
				  <li class="list-group-item list-group-item-action">	<p class="day-label text-danger"> 일 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label"> 월 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label"> 화 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label"> 수 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label"> 목 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label"> 금 </li>
				  <li class="list-group-item list-group-item-action">	<p class="day-label text-info"> 토 </li>
				</ul>
	  <!-- row.1 -->
  </div>
  <div class="calendar-month">
			
			<%
			
				int count = 1;
				for(int i=0; i<6; i++){
					String date_id = "month-"+i;
					String week_id = "week-"+i;
				%>
				<ul class="list-group list-group-horizontal" id="<%=week_id %>" data-week-id=<%=i %>>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>0" onclick="eventModalShow();" data-day-id=0>
				  	<span><a class="date-date" href="javascript:alert('date')"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="javascript:alert('msg')">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="javascript:alert('plus')" >+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>1" data-day-id=1>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>2" data-day-id=2>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>3" data-day-id=3>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>4" data-day-id=4>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>5" data-day-id=5>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
				  <li class="list-group-item list-group-item-action text-center date-component" id="<%=date_id %>6" data-day-id=6>	
				  	<span><a class="date-date" href="#"><%=String.valueOf(count++) %></a></span>
				  	<span><a class="date-msg"  href="#"  data-toggle="modal"  data-target="#events-modal">[주]10:00~11:00 </a> </span>
				  	<span><a class="date-plus" href="#">+3</a></span> 
				  </li>
			</ul>	
					
			<%}
			%>
			 
  </div>
  <p>
  
   <script>
   		var cal = {};
   		
		$(document).ready(function(){
			cal.today = new Date().getTime();
			cal.dates = new Array(new Array(7),new Array(7),new Array(7),new Array(7),new Array(7),new Array(7));
			cal.msgs  = new Array(new Array(7),new Array(7),new Array(7),new Array(7),new Array(7),new Array(7));
			cal.plus  = new Array(new Array(7),new Array(7),new Array(7),new Array(7),new Array(7),new Array(7));
			cal.events = new Array(new Array(7),new Array(7),new Array(7),new Array(7),new Array(7),new Array(7));
			
			cal
			$("#today").val(cal.today);
			for(var i=0; i<6; i++) {
				for(var j=0; j<7; j++){
					cal.dates[i][j] = (i*7)+(j+1);
					cal.msgs[i][j] = "msg : "+i+", "+j;
					cal.plus[i][j] = "+"+(j+1);
				}
			}
			$(".calendar-month").find('ul').each(function(){
				var week = $(this).data("week-id");
				$(this).find('li').each(function(){
					var day = $(this).data("day-id");
					console.log("week "+week +", day "+ day)
					$(this).find('.date-date').text(cal.dates[week][day]);
					$(this).find('.date-msg').text(cal.msgs[week][day]);
					$(this).find('.date-plus').text(cal.plus[week][day]);
					
				})
				
			});
			$(".date-component").on('click', function () {
	            $(".date-component").each(function(){
	            	$(this).removeClass('active');
	            });
	            $(this).addClass('active');
	         });
		    
			
		});
		
		function eventModalShow(){
			$("#events-modal").modal('show');
		}
</script>
 
</div> <!-- main end -->

<div class="container">
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                    <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1"/>
                    <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
            	 $('#datetimepicker1').datetimepicker({
            		 locale: 'ko',
            		 inline: true,
            		 
            	 });
            	 $('#datetimepicker1').on("dp.show",function(e){
            		 alert(e);
            	 });
            });
        </script>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <div class="input-group date" id="datetimepicker3" data-target-input="nearest">
                    <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker3"/>
                    <div class="input-group-append" data-target="#datetimepicker3" data-toggle="datetimepicker">
                        <div class="input-group-text"><i class="fas fa-clock-o"></i></div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
            	 $('#datetimepicker3').datetimepicker({
                     format: 'LT'
                 });
            });
        </script>
    </div>
</div>


<div class="modal fade" id="events-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h3 class="modal-title">Event</h3>
				</div>
				<div class="modal-body" style="height: 400px">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
</div>


<!-- footer area  -->
<%@include file="tail.jsp" %>
<!-- footer area -->

</body>
</html>


