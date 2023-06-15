package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.model.ActionModel;
import com.mvest.model.Vo;
import com.mvest.test.bybit.db.BybitBalanceDao;
import com.mvest.test.bybit.model.BybitBalance;

public class BybitBalanceListDailyAction extends ActionModel {
	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		String id		= getParameter("id");
	  
		
		String symbol = getParameter("symbol");
		
		if(isNotNull(id)) where = " id = '"+id +"'";
		if(isNotNull(symbol)) {
			if(isNotNull(where)) where += " AND ";
			where += " A.symol = '"+symbol +"'";
		}
		numPerPage = 30;
		
		if(isNull(where)) where = null;
		
			if(isNull(orderby)) orderby = null;
		
		try {
			int total = BybitBalanceDao.getInstace().getListDailyCount();
			Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
			addJsonObject("vo", vo);
			
			List<BybitBalance> balances= BybitBalanceDao.getInstace().getListDaily(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
			if(balances != null) addJsonArray("balances", balances);
			addJsonObjectProperty("total", String.valueOf(total));
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		
		
		outJsonObject();
  
		
	}
	 
 

}