package com.mvest.m.coin.upbit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.mvest.m.coin.BinanceServlet;
import com.mvest.m.coin.action.BinanceTestAction;
import com.mvest.m.coin.upbit.action.ConfigAction;
import com.mvest.model.ServletModel;


@WebServlet({
	"/upbit/config",
	"/upbit/orders",
	"/upbit/test"
})
public class UpbitServlet extends ServletModel {
	private static final long serialVersionUID = 1L;
	public static final Logger LOG			= Logger.getLogger(UpbitServlet.class);
	public static final String URL_FOLDER = "/upbit/";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpbitServlet() {
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
		setCommand(URL_FOLDER, request, response);
		
		LOG.debug(toConfig());
		
		
		switch(COMMAND){
		case "test" 			:  testAction(request,response); break;
		case "orders"			:  priceAction(request,response); break;
		case "config"			:  configAction(request,response); break;
		/*case "list/all"		:  listAllAction(request,response); break;
		case "search"			:  selectAction(request, response); break;
		case "add" 				:  insertAction(request, response); break;
		case "edit" 			:  updateAction(request, response); break;
		case "delete" 			:  deleteAction(request, response); break;*/
		}
	}
	
	public void testAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BinanceTestAction action = new BinanceTestAction();
		action.execute(request, response);
	}
	public void priceAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BinanceTestAction action = new BinanceTestAction();
		action.execute(request, response);
	}
	public void configAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ConfigAction action = new ConfigAction();
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
	public void insertAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiteInsertAction action = new SiteInsertAction();
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
