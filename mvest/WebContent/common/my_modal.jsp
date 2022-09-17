<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function addMyModal(){
     loadMember(); 
	 $("#myModal").modal("show");
}
function loadMember(){
	var mb_id = e1_member_id
	if(mb_id == null) return;
	
	var param		= "mb_id=" + mb_id;
	var REQ_TYPE 	= "POST";
	var REQ_URL  	= "<%=G_CONTEXT_PATH %>/member/search";
	
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: param,
		dataType	: "json", 
		//async		: false,
		beforeSend	: function(){ loadingShow(); },
		success		: function(res){
					loadingHide();
					var str 		= JSON.stringify(res,null,2);
					var result 		= res.result;
					var status 		= result.status;
					var message 	= result.message;
					var data		= result.data;
					
				 	/* alert(result.result+"\n"+message+"\n"+data);  */
					console.log(res);
				 	
					if(status <= 100){
						updateMember(res.member);
					}else if(status <= 300)	{
					}else {
						ajaxActionFail(result);
					} 
				 	
		},
		error		: function(){
						ajaxError();
		}
	});
}
function updateMember(member){
	$("#myForm #gr_name").val(member.gr_name);
	$("#myForm #gr_id").val(member.gr_id);
	
	$("#myForm #mb_id").val(member.mb_id);
	$("#myForm #mb_name").val(member.mb_name);
	$("#myForm #mb_password").val(member.mb_password);
	$("#myForm #mb_password2").val(member.mb_password);
	$("#myForm #mb_tel").val(member.mb_tel);
	$("#myForm #mb_address").val(member.mb_address);
	
	$("#myForm #mb_level").val(member.mb_level);
	var level_name = "<%=Lang.get("member.label.level_user") %>";
	if(member.mb_level == "20") level_name = "<%=Lang.get("member.label.level_group") %>";
	if(member.mb_level == "30") level_name = "<%=Lang.get("member.label.level_system") %>";
	$("#myForm #mb_level_name").val(level_name);
	
	
}
function inputCheckMyModal(){
	var mb_password  	= $("#myForm #mb_password").val();
	var mb_password2 	= $("#myForm #mb_password2").val();
	var mb_name 		= $("#myForm #mb_name").val();
	
	
	if(mb_id.length == 0 || mb_password.length == 0 || mb_password2.length == 0 || mb_name.length == 0){
		alert('<%=Lang.get("member.msg.required_input_error") %>');
		return false;
	}
	if(mb_password != mb_password2){
		alert('<%=Lang.get("member.msg.password_diff") %>');
		return false;
	}
	
	return checkMyPassword(mb_password);
}

function editMyModalAction(){
	if(!inputCheckMyModal()) return;
	var param 		= $("#myForm").serialize();
	
	var REQ_TYPE 	= "POST";
	var REQ_URL  	= "<%=G_CONTEXT_PATH %>/member/edit";
	$.ajax({
		type		: REQ_TYPE,
		url			: REQ_URL,
		data		: param,
		dataType	: "json", 
		beforeSend	: function(){ loadingShow(); },
		success		: function(res){
					loadingHide();
					var str 		= JSON.stringify(res,null,2);
					var result 		= res.result;
					var status 		= result.status;
					var message 	= result.message;
					var data		= result.data;
					
					//alert(result.result+"\n"+message);
					if(status <= 100){
						alert('<%=Lang.get("common.success") %>');
						closeMyModal();
					}else {
						ajaxActionFail(result);			
					}
				 	
		},
		error		: function(){
					ajaxError();
		}
	});
}
function checkMyPass(obj){
	var pass = obj.value;
	if(!checkMyPassword(pass)){
		setTimeout(function() {
			obj.value = "";
			obj.focus();
		}, 10);
		return;
	}
	
	var mb_password  	= $("#memberForm #mb_password").val();
	var mb_password2 	= $("#memberForm #mb_password2").val();
	
	if(mb_password.length > 0 && mb_password2.length > 0){
		if(mb_password != mb_password2){
			alert('<%=Lang.get("member.msg.password_diff") %>');
			setTimeout(function() {
				obj.focus();
			}, 10);
			return;
		}
	}
	
}
function checkMyPassword(mb_pass){
	if(checkSpace(mb_pass)){
		alert("<%=Lang.get("member.msg.unuse_space") %>");
		return false;
	} 
	var idReg = /^[A-za-z0-9!@#$%^&*_]{12,32}$/g;
	if(!idReg.test(mb_pass)){
		alert("<%=Lang.get("member.msg.pass_limit") %>");
		return false;
	}
	return true;
}
function closeMyModal(){
	$("#myModal").modal("hide");
}
$(function(){
	$("#myModal").on('hidden.bs.modal',function(){
	});
});
		
</script>
<style>
.input-group-text.input-label {
	width:180px;
}
.modal-dialog.modal-800 {
    width: 800px !important;
    margin: 30px auto;
}
.modal-content.modal-950 {
 	width: 950px;
    margin: 30px auto !important;
}
</style>
<!-- The Modal -->
<div class="modal" id="myModal">
  <input type="hidden" id="modal-action" value="add" />
  <div class="modal-dialog">
    <div class="modal-content" >

      <!-- Modal Header -->
      <div class="modal-header bg-warning">
        <h4 class="modal-title"><%=Lang.get("member.title.my") %></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
 			 <div class="container" >
				    <div class="card">
				   	<div class="card-header"><h2 id="card-title"><%=Lang.get("common.modify") %></h2></div>
					  <div class="card-body" >
					  		  <div class=""><span class="text-info">(*)</span><span><%=Lang.get("common.required_input_item") %></span></div>
					  	 	  <form id="myForm" name="myForm">
							    <input type="hidden" id="mb_no" name="mb_no" value="" />
							    <input type="hidden" id="admin_id" name="admin_id" value="" />
							    <input type="hidden" id="mb_use" name="mb_use" value="Y" />
							    <input type="hidden" id="mb_expire" name="mb_expire" value="N" />
							    <div class="input-group mb-3">
							      <div class="input-group-prepend" >
							        <span class="input-group-text input-label"><span class="text-info">*</span><%=Lang.get("group.label.group_name") %></span>
							      </div>
							       <input type="text" class="form-control" placeholder="" id="gr_name" name="gr_name" readonly="readonly"/>
							       <input type="hidden" id="gr_id" name="gr_id" />
							      </select>
							    </div> 
							     
							    <div class="input-group mb-3">
							      <div class="input-group-prepend" >
							        <span class="input-group-text input-label"><span class="text-info">*</span><%=Lang.get("member.label.member_id") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_id" name="mb_id" readonly="readonly">
							    </div>  
							    
							     <div class=""><span style="font-size: 12px;">*<%=Lang.get("member.msg.pass_limit") %></span></div>
							     
							   <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><span class="text-info">*</span><%=Lang.get("member.label.member_password") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_password" name="mb_password" onchange="checkMyPass(this)">
							    </div>  
							    
							     <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><span class="text-info">*</span><%=Lang.get("member.label.member_password2") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_password2" name="mb_passwrod2" onchange="checkMyPass(this)">
							    </div>  
							    
							   <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><span class="text-info">*</span><%=Lang.get("member.label.member_level") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_level_name" name="mb_level_name" readonly="readonly"/>
							      <input type="hidden" id="mb_level" name="mb_level" />
							    </div>  
							    
							     <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><span class="text-info">*</span> <%=Lang.get("member.label.member_name") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_name" name="mb_name">
							    </div>  
							    
							     <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><%=Lang.get("member.label.member_tel") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_tel" name="mb_tel">
							    </div>  
							    
							      <div class="input-group mb-3">
							      <div class="input-group-prepend">
							        <span class="input-group-text input-label"><%=Lang.get("member.label.member_address") %></span>
							      </div>
							      <input type="text" class="form-control" placeholder="" id="mb_address" name="mb_address">
							    </div>  
							  </form>
					  </div>
					</div>
				  </table>
				</div>
      </div>
	
      <!-- Modal footer -->
      <div class="modal-footer">
 
      	<a href="javascript:void(0)" class="btn btn-warning" onclick="editMyModalAction()" id="modal-ok-button"><%=Lang.get("common.ok") %></a>
        <a href="javascript:void(0)" class="btn btn-default" onclick="closeMyModal()" id="modal-cancel-button"><%=Lang.get("common.cancel") %></a>
      </div>

    </div>
  </div>
</div>


