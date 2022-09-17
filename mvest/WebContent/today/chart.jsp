<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
			
			
			<!-- 차트 링크 --> <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

			<hr>
			<div class="row container">
					 <canvas id="myChart"></canvas>
			</div>

			<script>
			$(function(){
				createChart();
			});
			
			function createChart(){
				var ctx = document.getElementById('myChart'); 
				
				var labels = [];
				var datas = [];
				var bgs = [];
				var bos = [];
				
				var isPlus = false;
				for(var i=0; i<31; i++){
					var date =  new Date(2021,3,(i+1))
					//labels[i] =  (date.getMonth()+1) + "-"+date.getDate();
					labels[i] = date.yyyymmdd();
					if(isPlus){
						datas[i] = (i+1);
						bgs[i] = 'rgba(255, 99, 132, 0.2)';
						bos[i] = 'rgba(255, 99, 132, 1)';
					}else {
						datas[i] = (i+1)*-1;
						bgs[i] = 'rgba(54, 162, 235, 0.2)';
						bos[i] = 'rgba(54, 162, 235, 1)';
					}
					isPlus = isPlus ? false : true;
				}
				
				
				
				/* labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'], 
				datasets: [{ label: '# of Votes', 
					data: [12, 19, 3, 5, 2, 3], 
					backgroundColor: [ 
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)', 
						'rgba(255, 159, 64, 0.2)' 
						], 
					borderColor: [ 
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)' 
						],  */
				
				var myChart = new Chart(ctx, { 
					type: 'bar', 
					data: { 
						labels: labels, 
						datasets: [{ label: '# of #', 
							data: datas, 
							backgroundColor: bgs, 
							borderColor: bos, 
							borderWidth: 1 
							}] 
					}, 
					options: { 
						scales: { 
							yAxes: [{ 
								ticks: { 
									beginAtZero: true 
									} 
							}] 
						} 
					} 
					}); 
			}
			
			</script>

