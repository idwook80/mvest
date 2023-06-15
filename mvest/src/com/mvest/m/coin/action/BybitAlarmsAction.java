package com.mvest.m.coin.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.model.ActionModel;
import com.mvest.model.Vo;
import com.mvest.test.bybit.db.BybitAlarmDao;
import com.mvest.test.bybit.db.BybitDao;
import com.mvest.test.bybit.model.BybitAlarm;

public class BybitAlarmsAction extends ActionModel {
	public static String API_KEY 		= null;
	public static String SECRET_KEY 	= null;
	
	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String where	= null;
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		String id		= getParameter("id");
		String user		= getParameter("user");
		
		String bpage	= getParameter("bpage");
		String blimit	= getParameter("blimit");
		String symbol   = getParameter("symbol");
		String position = getParameter("position");
		String side = getParameter("side");
		
		numPerPage = 30;
		
		
		if(isNull(symbol)) symbol = "BTCUSDT";
		String user_id = "";
		
		try {
			Map userMap = (Map)BybitDao.getInstace().select(id);
			if(userMap != null) {
				String web_id		= (String) userMap.get("id");
				String api_key 		= (String) userMap.get("api_key");
				String api_secret 	= (String) userMap.get("api_secret");
				
				if(web_id.equals(id)) {
					user_id 	= (String) userMap.get("user_id");
					API_KEY 	= api_key.trim();
					SECRET_KEY	= api_secret.trim();
				}
			
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
 
	     if(isNull(orderby)) orderby = " `trigger` DESC";
		
		try {
			if(API_KEY != null) {
				where = " user_id = '"+user_id+"'";
				where += " AND symbol = '" + symbol +"'";
				where += " AND parent_alarm_id = 0";
				
				
				if(isNotNull(position)) where += " AND position = '" + position + "'";
				if(isNotNull(side)) where += " AND side = '" +side +"'";
				
				
				int total = BybitAlarmDao.getInstace().getListCount(where);
				Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
				addJsonObject("vo", vo);
				
				List<BybitAlarm> alarms= BybitAlarmDao.getInstace().getList(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
				if(alarms != null) addJsonArray("alarms", alarms);
				addJsonObjectProperty("total", String.valueOf(total));
				setResultOk();
			 
			}else {
				 setResultFail("Not Found User");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		outJsonObject();
		
	}

}