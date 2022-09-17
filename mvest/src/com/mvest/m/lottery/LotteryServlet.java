package com.mvest.m.lottery;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.lf5.util.StreamUtils;

import com.mvest.m.lottery.action.*;
import com.mvest.model.ServletModel;

/**
 * Servlet implementation class SiteServlet
 */
@WebServlet({
	"/lottery/list",
	"/lottery/list/all",
	"/lottery/edit",
	"/lottery/add",
	"/lottery/delete",
	"/lottery/search",
	"/lottery/last",
	"/lottery/game",
	"/lottery/my/c",
	"/lottery/my/c/all",
	"/lottery/my/list",
	"/lottery/my/json"
})
public class LotteryServlet extends ServletModel {
	private static final long serialVersionUID = 1L;
	public static final Logger LOG			= Logger.getLogger(LotteryServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LotteryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		setCommand("/lottery/", request, response);
		
		LOG.debug(toConfig());
		
		
		switch(COMMAND){
		case "list" 			:  listAction(request,response); break;
		case "list/all"			:  listAllAction(request,response); break;
		case "last"				:  lastAction(request,response); break;
		case "game"				:  gameAction(request,response); break;
		/*case "add" 				:  insertAction(request, response); break;
		
	 	case "list/all"			:  listAllAction(request,response); break;
		case "search"			:  selectAction(request, response); break;
	
		case "edit" 			:  updateAction(request, response); break;
		case "delete" 			:  deleteAction(request, response); break;*/
		case "my/list"			: listMyWinAction(request,response); break;
		case "my/c"				: insertMyWinAction(request,response); break;
		case "my/c/all"			: insertMyWinAllAction(request,response); break;
		case "my/json"			: jsonTestAction(request,response); break;
		}
	}
	
	
	
	public void listAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryListAction action = new LotteryListAction();
		action.execute(request, response);
	}
	
	public void listAllAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryListAllAction action = new LotteryListAllAction();
		action.execute(request, response);
	}
	
	public void lastAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryLastAction action = new LotteryLastAction();
		action.execute(request, response);
	}
	public void gameAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryGameAction action = new LotteryGameAction();
		action.execute(request, response);
	}
	/*
	public void insertAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TodayInsertAction action = new TodayInsertAction();
		action.execute(request, response);
	}
	public void listAllAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiteListAllAction action = new SiteListAllAction();
		action.execute(request, response);
	}
	public void selectAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiteSelectAction action = new SiteSelectAction();
		action.execute(request, response);
	}
	
	public void updateAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiteUpdateAction action = new SiteUpdateAction();
		action.execute(request, response);
	}
	public void deleteAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiteDeleteAction action = new SiteDeleteAction();
		action.execute(request, response);
	}*/
	
	public void listMyWinAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryMyWinListAction action = new LotteryMyWinListAction();
		action.execute(request, response);
	}
	public void insertMyWinAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryInsertMyWinAction action = new LotteryInsertMyWinAction();
		action.execute(request, response);
	}
	public void insertMyWinAllAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LotteryInsertMyWinAllAction action = new LotteryInsertMyWinAllAction();
		action.execute(request, response);
	}
	public void jsonTestAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	System.out.println("test json receive");
		 	request.setCharacterEncoding("UTF-8");
		 	response.setContentType("text/html);charset=utf-8");
		 	Enumeration enu = request.getParameterNames();
			String param = "";
			int first= 0;
			
			while(enu.hasMoreElements()){
				String key = (String)enu.nextElement();
				String value = (String)request.getParameter(key);
				param  += (first == 0 ? "?" : "&")+key + "=" +value;
			}
		 	System.out.println(param);
		 	
		 	
		 	String t1 = (String) request.getParameter("t1");
		 	System.out.println("T1 :  "+t1);
	}

}
