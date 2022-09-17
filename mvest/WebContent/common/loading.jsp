<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <!--Loading Modal -->
  <div class="modal fade" id="loading" role="dialog" tabindex="-1" data-backdrop=true aria-hidden="true" data-keyboard="true" style="margin-top:150px;opacity:0.8;">
    <div class="modal-dialog modal-sm" role="document">
      <!-- Modal content-->
      <div class="modal-content">
        <!-- <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h5 class="modal-title">loading</h5>
        </div> -->
        <div class="modal-body text-center" style="min-height:150px;">
        	<button type="button" class="close" data-dismiss="modal">&times;</button>
        	<div class="container-fluid " style="vertical-align: middle;height:150px;padding:50px;">
        		<img src="<%=request.getContextPath() %>/images/loading.gif" width="50px" height="50px">
        	</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" onclick="loadingHide()">Close</button>
        </div> 
      </div>
      
    </div>
  </div>
 	<script>
	function loadingShow(){
		// $("#loading").modal("show");
		//$('.overlay').addClass('active');
		 showLoadingBar();
	}
	function loadingHide(){
		//$("#loading").modal("hide");
		//$('.overlay').removeClass('active');
		hideLoadingBar();
	}
	function showLoadingBar() { 
			 var imgURL = "<%=G_CONTEXT_PATH %>/images/loading.gif";
		   	 var maskHeight = $(document).height(); 
		   	 var maskWidth = window.document.body.clientWidth; 
		   	 var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>"; 
		   	 var loadingImg = ''; 
		   	 loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:; z-index:10000;'>"; 
		   	 loadingImg += " <img src='" + imgURL + "'/>"; 
		   	 loadingImg += "</div>";
		   	 $('body').append(mask).append(loadingImg);
		   	 $('#mask').css({ 'width' : maskWidth , 'height': maskHeight , 'opacity' : '0.3' }); 
		   	 $('#mask').show();
		   	 $('#loadingImg').show(); 
		   	 $("#mask").on("click",function(event){
		   		hideLoadingBar();
		   	 });
   
    }
    function hideLoadingBar() { 
   	 $('#mask, #loadingImg').hide(); 
   	 $('#mask, #loadingImg').remove(); 
    }
    
	</script>
	<!-- /Loading Modal -->
  
