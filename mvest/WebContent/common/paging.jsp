<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <script type="text/javascript">
		  function updatePaging(vo){
			  var totalPage = vo.totalPage;
			  var prevPage 	= vo.prevPage;
			  var nextPage 	= vo.nextPage;
			  var firstPage = vo.firstPage;
			  var lastPage 	= vo.lastPage;
			  var curPage 	= vo.curPage;
			  
			  $(".pagination").html('');
			  
			  if(vo == null || totalPage == 0){
				  $(".pagination").append("<li class=\"page-item disabled pre-item\"><a class=\"page-link\" href=\"javascript:void(0)\"><<</a></li>");
				  $(".pagination").append("<li class=\"page-item disabled pre-item\"><a class=\"page-link\" href=\"javascript:void(0)\">>></a></li>");
				  return;
			  }
			  
			  if(prevPage == 0){
				  $(".pagination").append("<li class=\"page-item disabled pre-item\"><a class=\"page-link\" href=\"#\"><<</a></li>");
			  }else {
				  $(".pagination").append("<li class=\"page-item pre-item\"><a class=\"page-link\" href=\"javascript:goPage('" + prevPage + "');\"><<</a></li>");
				  
			  }
			  for(var i=firstPage; i<lastPage+1; i++){
				  if(i == curPage) {
					  $(".pagination").append("<li class=\"page-item active\"><a class=\"page-link\" href=\"javascript:goPage('"+i+"');\">"+i+"</a></li>");
				  }else if(i == curPage-1 || i== curPage+1) {
					  $(".pagination").append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:goPage('"+i+"');\">"+i+"</a></li>");
				  }else {
					  $(".pagination").append("<li class=\"page-item\" style=\"width:25px;\"><a class=\"page-link\" href=\"javascript:goPage('"+i+"');\">"+i+"</a></li>");
				  }
			  }
			  
			  if(nextPage == 0){
				  $(".pagination").append("<li class=\"page-item disabled pre-item\"><a class=\"page-link\" href=\"#\">>></a></li>");
			  }else {
				  $(".pagination").append("<li class=\"page-item next-item\"><a class=\"page-link\" href=\"javascript:goPage('" + nextPage + "');\">>></a></li>");
			  }
		  }
 </script>



<!-- paging start  -->
	  <div class="paging container-fluid" style="margin:20px 0">
		  <ul class="pagination pagination-sm justify-content-center pagination-secondary">
	     </ul>
		</div>
<!-- paging end -->