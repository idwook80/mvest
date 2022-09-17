package com.mvest.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

//import etr_cr.config.LangManager;
//import etr_cr.config.WebConfig;
//import etr_cr.login.Login;
//import etr_cr.member.Member;


public abstract class ActionModel  {
	public static final Logger LOG = Logger.getLogger(ActionModel.class);
	public final static String DEFAULT_CHARSET		= "UTF-8";
	
	public final static String COMMON_CUR_PAGE 		= 	"curPage";
	public final static String COMMON_PER_PAGE 		= 	"perPage";
	public final static String COMMON_PER_BLOCK 	= 	"perBlock";
	
	public final static String P_SEARCH_PARAM		= 	"search_param";
	public final static String P_KEYWORD			= 	"keyword";
	public final static String P_SORT				= 	"sort";
	public final static String P_ORDER				= 	"order";
	
	public final static String IS_MEMBER 			= 	"isMember";
	public final static String LOGIN_ID 			= 	"loginId";
	public final static String LOGIN_NO 			= 	"loginNo";
	
	protected PrintWriter	out;					/*protected Gson gson = new GsonBuilder().setPrettyPrinting().create();*/
	protected Gson 			gson 					= 	new Gson();
	protected ResultModel 	resultModel 			= 	new ResultModel();
	protected Hashtable 	inputTable 				= 	new Hashtable();
	protected Hashtable 	outputTable 			= 	new Hashtable();
	
	protected String CLIENT 						= 	"";
	protected String CONTEXT_ROOT_PATH 				=	"";
	protected String USER_ID 						= 	"";
	protected String USER_NO 						= 	"";
	protected String USER_LEVEL 					= 	"";
	protected String FULL_URL 						= 	"";
	protected String FULL_URI 						= 	"";
	protected String LOCATION 						= 	"";
	//protected String LANG	  						= 	WebConfig.get("CF_DEFAULT_LANG","JP");
	protected String LANG	  						= 	"KO";
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	
	protected int 		curPage 			= 1;
	protected int 		numPerPage 			= 10;
	protected int 		pagePerBlock 		= 10;
	protected String 	search_param 		= "";
	protected String 	keyword 			= "";
	
	
	public void setDefaultParameter() throws UnsupportedEncodingException{
		
		Enumeration<String>  keys = request.getParameterNames();
		while(keys.hasMoreElements()) {
			String key = keys.nextElement();
			String value = request.getParameter(key);
			
			LOG.debug(key + "  : "+value);
		}
		
		
		
		curPage					= 		getParameterInt(COMMON_CUR_PAGE, 1);
		numPerPage			 	= 		getParameterInt(COMMON_PER_PAGE, 10);
		pagePerBlock 		 	= 		getParameterInt(COMMON_PER_BLOCK, 10);
		
		search_param 			= 		getParameter(P_SEARCH_PARAM);
		keyword 				= 		getParameterUTF8(P_KEYWORD); 
		
	}
	public void executeLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.request 		= request;
		this.response 		= response;
		CLIENT 				= request.getRemoteAddr();
		CONTEXT_ROOT_PATH 	= request.getServletContext().getRealPath("/");
		
		//HttpSession session 			= request.getSession();
		setLang();
		setPath();
		perform(request, response);
		 
	}
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.request 		= request;
		this.response 		= response;
		CLIENT 				= request.getRemoteAddr();
		CONTEXT_ROOT_PATH 	= request.getServletContext().getRealPath("/");
		
		//System.out.println(request.getHeader("accept"));
		//HttpSession session 			= request.getSession(false);
		//if(session == null) session 	= request.getSession(true);
		HttpSession session 			= request.getSession(false);
		
		
		/**
		if(session.getAttribute(Login.LOGIN_YN) == null ) session.setAttribute(Login.LOGIN_YN, Login.LOGIN_N);
		
		USER_ID 	= session.getAttribute(Login.LOGIN_ID) 		!= null ? (String) session.getAttribute(Login.LOGIN_ID) 	:	"";
		USER_NO 	= session.getAttribute(Login.LOGIN_NO) 		!= null ? (String) session.getAttribute(Login.LOGIN_NO) 	:	"";
		USER_LEVEL 	= session.getAttribute(Login.LOGIN_LEVEL) 	!= null ? (String) session.getAttribute(Login.LOGIN_LEVEL) 	:	"1";
		**/
		setLang();
		setPath();
		if(checkLogin(session)){
			perform(request, response);
		}else {
			String view = request.getContextPath()+"/login/logout.jsp";
			/*LOG.debug("redirect! "+view);
			response.sendRedirect(view);
			LOG.debug("forward! "+view);
			ServletContext sc 		= request.getServletContext();
			RequestDispatcher rd	= sc.getRequestDispatcher(view);
			rd.forward(request, response);*/
			
			createJsonOut(request, response);
			setResult(ResultModel.RESULT_REDIRECT,"redirect");
			setResultData(view);
			outJsonObject();
		}
		
	
		
		/**
		session = request.getSession(false);
		if(session == null) session = request.getSession(true);
		if(session.getAttribute(Login.LOGIN_YN) == null ) {
			session.setAttribute(Login.LOGIN_YN, Login.LOGIN_N);
			session.setAttribute("lang", LANG);
		}
		
		outputTable.put(ResultModel.RESULT_KEY, getResult());
		request.setAttribute(ResultModel.OUTPUT_KEY, outputTable);
		if(session != null) session.setAttribute(ResultModel.OUTPUT_KEY, outputTable);
		**/
	}
	public void execute(HttpServletRequest request, HttpServletResponse response,String view,boolean isRedirect) throws ServletException, IOException {
		this.request 		= request;
		this.response  		= response;
		CLIENT 				= request.getRemoteAddr();
		CONTEXT_ROOT_PATH 	= request.getServletContext().getRealPath("/");
		//setLang();
		//setPath();
		
		HttpSession session = request.getSession(false);
		if(session == null) session = request.getSession(true);
		/**
		LOG.debug("Session : "+session + " LOGIN : " +(session != null ? session.getAttribute(Login.LOGIN_YN) : "NULL"));
		
		if(session == null) session = request.getSession(true);
		if(session.getAttribute(Login.LOGIN_YN) == null || Login.LOGIN_N.equals(session.getAttribute(Login.LOGIN_YN))) {
			session.setAttribute(Login.LOGIN_YN, 	Login.LOGIN_N);
			session.setAttribute("lang", 			LANG);
			session.setAttribute("url", 			FULL_URL);
			view = request.getContextPath()+"/jsp/login/login.jsp";
			isRedirect =true;
		}else{
			USER_ID 	= session.getAttribute(Login.LOGIN_ID) 		!= null ? (String) session.getAttribute(Login.LOGIN_ID) :"";
			USER_NO 	= session.getAttribute(Login.LOGIN_NO) 		!= null ? (String) session.getAttribute(Login.LOGIN_NO) :"";
			USER_LEVEL 	= session.getAttribute(Login.LOGIN_LEVEL) 	!= null ? (String) session.getAttribute(Login.LOGIN_LEVEL) :"";
			
			//checkLogin(session);
			perform(request, response);
			
			outputTable.put(							ResultModel.RESULT_KEY, getResult());
			request.setAttribute(						ResultModel.OUTPUT_KEY, outputTable);
			if(session != null) session.setAttribute(	ResultModel.OUTPUT_KEY, outputTable);
		}
		
		*/
		perform(request, response);
		
		if(view != null){
			if(isRedirect){
				LOG.debug("redirect! "+view);
				response.sendRedirect(view);
			}else{
				LOG.debug("forward! "+view);
				ServletContext sc 		= request.getServletContext();
				RequestDispatcher rd	= sc.getRequestDispatcher(view);
				rd.forward(request, response);
			}
		}
		
	}
	public void setLang(){
		String _lang = request.getParameter("lang");
		if(_lang != null && !_lang.equals("")){
			LANG = _lang;
		}else {
			HttpSession sess = request.getSession(false);
			if(sess != null ){
				_lang = (String) sess.getAttribute("lang");
			}
			if(_lang != null && !_lang.equals("")) LANG = _lang;
		}
		//if(!LangManager.isLoadedLang(_lang)) _lang = WebConfig.get("CF_DEFAULT_LANG","JP");
		LOG.debug("LANG : "+LANG);
		
	}
	public void setPath(){
		String contextPath = request.getContextPath();
		
		FULL_URI = request.getRequestURI();
		FULL_URL = request.getRequestURL().toString();
		Enumeration enu = request.getParameterNames();
		String param = "";
		int first= 0;
		
		while(enu.hasMoreElements()){
			String key = (String)enu.nextElement();
			String value = (String)request.getParameter(key);
			param  += (first == 0 ? "?" : "&")+key + "=" +value;
			first++;
		}
		FULL_URL += param;
		LOG.debug("URL : "+FULL_URL);
	}
	public boolean checkLogin(HttpSession session) throws IOException{
		/*if(session == null ) return false;
		String loginYn = (String) session.getAttribute(Login.YN);
		
		if(loginYn != null && loginYn.equals(Login.LOGIN_Y)){
			Member member = (Member)session.getAttribute(Login.LOGIN_MEMBER);
			if(member != null){
				USER_ID 	= member.getMb_id().trim();
				USER_LEVEL 	= member.getMb_level().trim();
			}
			return true;
		}else {
			return false;
		}*/
		
		return true;
		
		/**
		Login login = new Login();
		login.setMb_no(USER_NO);
		login.setMb_id(USER_ID);
		login.setLo_ip(CLIENT);
		login.setLo_location(FULL_URI);
		login.setLo_url(FULL_URL);
		login.setLo_session(session.getId());
		long lastTime = session.getLastAccessedTime();
		
		login.setLo_update_datetime(TimeUtil.getDateFormat("yyyy-MM-dd HH:mm:ss", lastTime));
		
		try{
			int ret =LoginDao.getInstance().insert(login);
		}catch(Exception e){
			e.printStackTrace();
		}
		**/
	}
	public String getParameter(String key,String def){
		if(request == null) return def;
		return request.getParameter(key) != null ? request.getParameter(key) : def;
	}
	public final static String getParameter(HttpServletRequest req,String key){
		return getParameter(req, key, "");
	}
	public final static String getParameter(HttpServletRequest req,String key,String def){
		if(req == null) return def;
		return req.getParameter(key) != null ? req.getParameter(key) : def;
	}
	public int getParameterInt(String key,int def){
		try{
			if(request == null) return def;
			return request.getParameter(key) != null ? Integer.parseInt(request.getParameter(key)) : def;
		}catch(Exception e){
			return def;
		}
	}
	
	public String getParameter(String key){
		return getParameter(key,"");
	}
	public String getParameterUTF8(String key) throws UnsupportedEncodingException{
		return URLDecoder.decode(getParameter(key,"") , "UTF-8");
	}
	abstract public void perform(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException;
	public void createJsonOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getHeader("accept").indexOf("application/json") != -1) {
            response.setContentType("application/json; charset=UTF-8");
        } else {
            // IE workaround
            response.setContentType("text/plain; charset=UTF-8");
        }        
       out = response.getWriter();
	}
	public void outJson(Object obj){
		outJson(gson.toJson(obj));
	}
	public void outJson(String str){
		LOG.debug(str);
		Gson pson = new GsonBuilder().setPrettyPrinting().create();
		JsonParser jp = new JsonParser();
		JsonElement je = jp.parse(str);
		String prettyJsonString = pson.toJson(je);
		out.println(prettyJsonString);
	}
	
	JsonObject resultObject =null;
	public void addJsonObjectProperty(String key, String value){
		if(resultObject == null) resultObject = new JsonObject();
		resultObject.addProperty(key, value);
	}
	public void addJsonObjectProperty(String key, String[] values){
		List<HashMap> list = new ArrayList<HashMap> ();
		for(int i=0; i<values.length; i++){
			HashMap<String, String> value = new HashMap<>();
			value.put("value", values[i]);
			list.add(value);
		}
		addJsonArray(key, list);
	}
	
	public void addJsonObject(String key,Object obj){
		String json = gson.toJson(obj);
		JsonParser parser = new JsonParser();
		JsonObject jobject = parser.parse(json).getAsJsonObject();
		if(resultObject == null) resultObject = new JsonObject();
		resultObject.add(key, jobject);
	}
	
	public void addJsonArray(String key,List list){
		JsonArray  jsonArray = new JsonArray();
		JsonParser parser = new JsonParser();
		for(int i=0; i<list.size(); i++){
			String json = gson.toJson(list.get(i));
			
			jsonArray.add(parser.parse(json).getAsJsonObject()); 
		}
		if(resultObject == null) resultObject = new JsonObject();
		resultObject.add(key, jsonArray);
	}
	
	
	private void outJsonResult(){
		addJsonObject(ResultModel.KEY, getResult());
	}
	public void outJsonObject(){
		outJsonResult();
		if(resultObject != null){
			outJson(gson.toJson(resultObject));
		}
	}
	
	public Vo getNumbersForPaging(int totalRecord, int curPage, int numPerPage, int pagePerBlock) {
        int totalPage = totalRecord / numPerPage;
        if (totalRecord % numPerPage != 0) totalPage++;
        int totalBlock = totalPage / pagePerBlock;
        if (totalPage % pagePerBlock != 0) totalBlock++;

        int block = curPage / pagePerBlock;
        if (curPage % pagePerBlock != 0) block++;

        int firstPage = (block - 1) * pagePerBlock + 1;
        int lastPage = block * pagePerBlock;

        int prevPage = 0;
        if (block > 1) {
            prevPage = firstPage - 1;
        }

        int nextPage = 0;
        if (block < totalBlock) {
            nextPage = lastPage + 1;
        }
        if (block >= totalBlock) {
            lastPage = totalPage;
        }

        int listItemNo = totalRecord - (curPage - 1) * numPerPage;
        int startRecord = (curPage - 1) * numPerPage;
        int endRecord = numPerPage;
         

        Vo vo = new Vo();
        
        vo.setCurPage(curPage);
        vo.setTotalPage(totalPage);
        vo.setFirstPage(firstPage);
        vo.setLastPage(lastPage);
        vo.setPrevPage(prevPage);
        vo.setNextPage(nextPage);
        vo.setListItemNo(listItemNo);
        vo.setTotalRecord(totalRecord);
        vo.setStartRecord(startRecord);
        vo.setEndRecord(endRecord);
        return vo;
    }
	
 
	public void setResultOk(){
		setResultOk(null);
	}
	public void setResultOk(String message){
		setResult(ResultModel.RESULT_OK, message);
	}
	
	public void setResultFail(){
		setResultFail(null);
	}
	public void setResultFail(String message){
		setResult(ResultModel.RESULT_FAIL, message);
	}
	
	public void setResultError(){
		setResultError(null);
	}	
	public void setResultError(String message){
		setResult(ResultModel.RESULT_ERROR, message);
	}
	
	private void setResult(String result, String message){
		resultModel.setResult(result);
		if(message != null) resultModel.setMessage(message);
	}
	
	public void setResultStatus(int status){
		resultModel.setException(status);
	}
	public void setResultMessage(String message){
		if(message != null) resultModel.setMessage(message);
	}
	 
	public ResultModel getResult(){
		return resultModel;
	}
	public void setResultData(Object data){
		resultModel.setData(data);
	}
	public void paramNullCheck(Object... args)throws Exception{
		int idx = 0;
		for(Object o : args){
			if(isNull(o)) throw new Exception(o + " [" + (idx++) + "] Parameter Format Exception ");
		}
	}
	public boolean isNull(Object o){
		if(o == null) return true;
		if(o.toString().trim().equals("") || o.toString().toUpperCase().equals("NULL")) return true;
		return false;
	}
	public boolean isNotNull(Object o){
		return !isNull(o);
	}


}
