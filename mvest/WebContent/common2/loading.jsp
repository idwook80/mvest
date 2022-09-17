<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <!--Loading Modal -->
   
  <link href="<%=request.getContextPath() %>/css/bootstrap.min.css" rel="stylesheet"> 
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-2.1.1.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script> 
  <div class="modal fade" id="loading" role="dialog" tabindex="-1" data-backdrop="false" aria-hidden="true" data-keyboard="false" style="margin-top:150px;opacity:0.8;">
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
        		<img src="<%=request.getContextPath() %>/common/loading.gif" width="50px" height="50px">
        	</div>
        </div>
        <!-- <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div> -->
      </div>
      
    </div>
  </div>
 	<script>
	function loadingShow(){
		$("#loading").modal('show');
	}
	function loadingHide(){
		$("#loading").modal('hide');
	}
	</script>
	<!-- /Loading Modal -->
  
