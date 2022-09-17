package com.mvest.model;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;


public abstract class ServletModel extends HttpServlet{
	public final static String FORMAT_HTML						= "html";
	public final static String FORMAT_DO						= "do";
	public final static String FORMAT_JSON						= "json";
	public final static String FORMAT_XML						= "xml";

	
	
	public static String  CHARACTER_ENCODING 					= "UTF-8";
	
	private String COMMON_PATH									= "";
	public String URI 											= "";
	public String CONTEXT_PATH									= "";
	public String COMMAND										= "";
	public String REQUEST_FORMAT								= FORMAT_HTML;
	public String RESPONSE_FORMAT								= FORMAT_HTML;
	
	public void setConfig(String common_path , HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		request.setCharacterEncoding(CHARACTER_ENCODING);
		this.COMMON_PATH = common_path != null ? common_path : "";
		URI 			= request.getRequestURI();
		CONTEXT_PATH	= request.getContextPath();
		COMMAND = URI.substring(CONTEXT_PATH.length()).replace(COMMON_PATH, "");
	}
	public void setCommand(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		setCommand(null, request, response);
	}
	public void setCommand(String common_path , HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		//System.out.println(request.getContentType());
		request.setCharacterEncoding(CHARACTER_ENCODING);
		this.COMMON_PATH = common_path != null ? common_path : "";
		URI 			= request.getRequestURI();
		CONTEXT_PATH	= request.getContextPath();
		COMMAND = URI.substring(CONTEXT_PATH.length()).replace(COMMON_PATH, "");
	}
	 
	abstract protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException ;
	abstract protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
	public String toConfig(){
		return "URI : " + URI + ", CONTEXT_PATH : " + CONTEXT_PATH + ", COMMAND : " + COMMAND;
	}
}
