package com.mvest.m.coin;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.mvest.m.coin.action.BinanceTestAction;
import com.mvest.m.coin.action.BybitAlarmsAction;
import com.mvest.m.coin.action.BybitBalanceListAction;
import com.mvest.m.coin.action.BybitBalanceListDailyAction;
import com.mvest.m.coin.action.BybitBalancesAction;
import com.mvest.m.coin.action.BybitBalancesListAction;
import com.mvest.m.coin.action.BybitOrderCancelAction;
import com.mvest.m.coin.action.BybitOrderCreateAction;
import com.mvest.m.coin.action.BybitOrdersAction;
import com.mvest.m.coin.action.BybitTestAction;
import com.mvest.m.coin.action.ExchangeScraping;
import com.mvest.model.ServletModel;

/**
 * Servlet implementation class SiteServlet
 */
@WebServlet({
	"/bybit/test",
	"/bybit/price",
	"/bybit/orders",
	"/bybit/order/cancel",
	"/bybit/order/create",
	"/bybit/balances",
	"/bybit/balances/list",
	"/bybit/balance/list",
	"/bybit/balance/list/daily",
	"/bybit/alarms"
})
public class BybitServlet extends ServletModel {
	private static final long serialVersionUID = 1L;
	public static final Logger LOG			= Logger.getLogger(BybitServlet.class);
	public static final String URL_FOLDER = "/bybit/";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BybitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    public void init() throws ServletException {
       
       Thread thread = new Thread(new Runnable() {
    	   public void run() {
    		   UUID uuid = UUID.randomUUID();
    		   
    		   while(true) {
    			   try {
    				   ExchangeScraping.scraping();
    				   System.out.println(uuid+" 현재 시간 : " + LocalDateTime.now() + " 환율 : " + ExchangeScraping.usd);
    				   Thread.sleep(1000*60*60);
    			   }catch(Exception e) {
    				   e.printStackTrace();
    			   }
    			   
    		   }
    	   }
       });
       thread.start();
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
		case "price"			:  priceAction(request,response); break;
		case "orders"			:  getOrdersAction(request,response); break;
		case "balances"			:  getBalancesAction(request, response); break;
		case "balances/list"	:  getBalancesListAction(request, response); break;
		case "balance/list"		:  getBalanceListAction(request, response); break;
		case "balance/list/daily": getBalanceListDailyAction(request, response); break;
		case "order/cancel"		:  cancelOrderAction(request, response); break;
		case "order/create"		:  createOrderAction(request, response); break;
		
		case "alarms"			:  getAlarmsAction(request,response); break;
		/*case "list/all"		:  listAllAction(request,response); break;
		case "search"			:  selectAction(request, response); break;
		case "add" 				:  insertAction(request, response); break;
		case "edit" 			:  updateAction(request, response); break;
		case "delete" 			:  deleteAction(request, response); break;*/
		}
	}
	
	public void testAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitTestAction action = new BybitTestAction();
		action.execute(request, response);
	}
	public void priceAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BinanceTestAction action = new BinanceTestAction();
		action.execute(request, response);
	}
	/** ORDER **/
	public void getOrdersAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitOrdersAction action = new BybitOrdersAction();
		action.execute(request, response);
	}
	/** ALARM **/
	public void getAlarmsAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitAlarmsAction action = new BybitAlarmsAction();
		action.execute(request, response);
	}
	
	/** BALANCES**/
	
	public void getBalancesAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitBalancesAction action = new BybitBalancesAction();
		action.execute(request, response);
	}
	public void getBalancesListAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitBalancesListAction action = new BybitBalancesListAction();
		action.execute(request, response);
	}
	public void getBalanceListAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitBalanceListAction action = new BybitBalanceListAction();
		action.execute(request, response);
	}
	public void getBalanceListDailyAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitBalanceListDailyAction action = new BybitBalanceListDailyAction();
		action.execute(request, response);
	}
	public void cancelOrderAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitOrderCancelAction action = new BybitOrderCancelAction();
		action.execute(request, response);
	}
	public void createOrderAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BybitOrderCreateAction action = new BybitOrderCreateAction();
		action.execute(request, response);
	}

}
