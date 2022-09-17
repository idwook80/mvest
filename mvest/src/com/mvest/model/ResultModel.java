package com.mvest.model;

public class ResultModel {
	public static final String KEY					= "result";
	
	public static final String RESULT_OK					= "ok";
	public static final String RESULT_FAIL					= "fail";
	public static final String RESULT_ERROR					= "error";
	public static final String RESULT_REDIRECT				= "redirect";
	public static final String RESULT_PERMISSION			= "permission";
			
	
	public final static int 	STATUS_OK 					= 100;
	public final static int 	STATUS_FAIL					= 300;
	public final static int 	STATUS_REDIRECT				= 301;
	public final static int 	STATUS_PERMISSION			= 302;
	public final static int		STATUS_ERROR				= 500;
	
	
	
	int 			status		= 0;
	String 			result 		= "";
	String 			message 	= "";
	Object			data;
	
	
	public int getStatus() {
		return status;
	}
	private void setStatus(int status) {
		this.status = status;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
		switch(result){
		case RESULT_OK 		: setStatus(STATUS_OK); break;
		case RESULT_FAIL 	: setStatus(STATUS_FAIL); break;
		case RESULT_ERROR 	: setStatus(STATUS_ERROR); break;
		case RESULT_REDIRECT : setStatus(STATUS_REDIRECT); break;
		case RESULT_PERMISSION : setStatus(STATUS_PERMISSION); break;
		}
	}
	public void setException(int status){
		setResult(RESULT_FAIL);
		setStatus(status);
		
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}
