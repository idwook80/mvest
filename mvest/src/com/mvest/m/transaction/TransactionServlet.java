package com.mvest.m.transaction;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.mvest.m.transaction.action.*;
import com.mvest.model.ServletModel;

/**
 * Servlet implementation class SiteServlet
 */
@WebServlet({
	"/transaction/list",
	"/transaction/list/all",
	"/transaction/edit",
	"/transaction/add",
	"/transaction/delete",
	"/transaction/search"
})
public class TransactionServlet extends ServletModel {
	private static final long serialVersionUID = 1L;
	public static final Logger LOG			= Logger.getLogger(TransactionServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransactionServlet() {
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
		setCommand("/transaction/", request, response);
		
		LOG.debug(toConfig());
		
		
		switch(COMMAND){
		case "list" 			:  listAction(request,response); break;
		case "add" 				:  insertAction(request, response); break;
		
		/*case "list/all"			:  listAllAction(request,response); break;
		case "search"			:  selectAction(request, response); break;
	
		case "edit" 			:  updateAction(request, response); break;
		case "delete" 			:  deleteAction(request, response); break;*/
		}
	}
	
	
	
	
	
	public void listAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TransactionListAction action = new TransactionListAction();
		action.execute(request, response);
	}
	public void insertAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TransactionInsertAction action = new TransactionInsertAction();
		action.execute(request, response);
	}
	/*public void listAllAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

}
