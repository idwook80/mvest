package com.mvest.m.transaction.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.transaction.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;


public class TransactionListAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
		
		
		String co_code = getParameter("co_code");
		String tr_type = getParameter("tr_type");
		
		
		String where = "";
		if(isNotNull(co_code)) where += " A.co_code = '"+co_code +"'";
		if(isNotNull(tr_type)) {
			if(isNotNull(where)) where += " AND ";
			where += " A.tr_type = '"+tr_type +"'";
		}
	 
		
		if(isNull(where)) where = null;
		
	/*	if(isNotNull(orderby)) {
			orderby = "A."+orderby;
		}else {
			orderby  = "A.si_id";
		}
		if(isNotNull(sort)){
			orderby += " "+ sort;
		}else {
			orderby += " ASC";
		}*/
			if(isNull(orderby)) orderby = null;
		
		try {
			
			
			int total = TransactionDao.getInstace().getListCount(where);
			Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
			addJsonObject("vo", vo);
			
			List<Transaction>  transactions= TransactionDao.getInstace().getList(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
			if(transactions != null) addJsonArray("transactions", transactions);
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
