package com.mvest.m.today.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.today.Today;
import com.mvest.m.today.TodayDao;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;


public class TodayListAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
		
		
		
		
		
		String co_code = getParameter("co_code");
		String co_name = getParameter("co_name");
		String to_date = getParameter("to_date");
		
		
		String where = "";
		if(isNotNull(co_code)) where += " co_code = '"+co_code +"'";
		if(isNotNull(co_name)) {
			if(isNotNull(where)) where += " AND ";
			where += " co_name = '"+co_name +"'";
		}
		if(isNotNull(to_date)) {
			if(isNotNull(where)) where += " AND ";
			where += " to_date = '"+to_date +"'";
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
			int total = TodayDao.getInstace().getListCount(where);
			Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
			addJsonObject("vo", vo);
			
			List<Today> todays = TodayDao.getInstace().getList(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
			if(todays != null) addJsonArray("todays", todays);
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
