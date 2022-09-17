package com.mvest.m.coin.upbit.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.coin.upbit.BotConfig;
import com.mvest.m.coin.upbit.db.ConfigDao;
import com.mvest.model.ActionModel;

public class ConfigAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
		/**
		   if(isNotNull(orderby)) {
				orderby = "A."+orderby;
			}else {
				orderby  = "A.si_id";
			}
			if(isNotNull(sort)){
				orderby += " "+ sort;
			}else {
				orderby += " ASC";
			}
		**/
		
		if(isNull(orderby)) orderby = null;
		
		try {
			BotConfig config = (BotConfig)ConfigDao.getInstace().select("KRW-BTC");
			addJsonObject("config", config);
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}

}
 
