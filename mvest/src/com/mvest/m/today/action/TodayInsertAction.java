package com.mvest.m.today.action;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.today.Today;
import com.mvest.m.today.TodayDao;
import com.mvest.model.ActionModel;

public class TodayInsertAction  extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			createJsonOut(request, response);
			
			Today today = new Today();
			
			//today.setTo_id(getParameter("to_id"));
			today.setTo_date(getParameter("to_date"));
			today.setCo_code(getParameter("co_code"));
			today.setCo_name(getParameter("co_name"));
			today.setTo_balance(getParameter("to_balance").replace(",", ""));
			today.setTo_average(getParameter("to_average").replace(",", ""));
			today.setTo_price(getParameter("to_price").replace(",", ""));
			
			int balance = Integer.parseInt(today.getTo_balance());
			int average = Integer.parseInt(today.getTo_average());
			int price 	= Integer.parseInt(today.getTo_price());
			
			int purchase = balance * average;
			int evaluation = balance * price;
			int profit = (evaluation - purchase) - (int) (evaluation * 0.0025);
			float ration = (float)(profit / (float) (purchase/100));
			
			
			//today.setTo_purchase(getParameter("to_purchase").replace(",", ""));
			//today.setTo_evaluation(getParameter("to_evaluation").replace(",", ""));
			//today.setTo_profit(getParameter("to_profit").replace(",", ""));
			//today.setTo_ration(getParameter("to_ration").replace(",", ""));
			
			 today.setTo_purchase(String.valueOf(purchase));
			 today.setTo_evaluation(String.valueOf(evaluation));
			 today.setTo_profit(String.valueOf(profit));
			 today.setTo_ration(String.valueOf(ration));
			
			//String gr_id = getParameter("gr_id");
			//paramNullCheck(site.getSi_name(),site.getSi_ip());
			
			//if(!checkSiteIp(site.getSi_ip())) return;
			
			int to_id =  TodayDao.getInstace().insert(today);
			
			if(to_id > 0){
				today.setTo_id(String.valueOf(to_id));
				setResultOk();
				setResultData(today);
			}else {
				setResultFail();
			}
			 
			/*int si_id = SiteDao.getInstace().insert(site);
			if(si_id > 0){
				setResultOk();
				setResultData(site);
				AdminLogDao.getInstace().doLogAction(USER_ID, SiteDao.TABLE, AdminLog.REG, site.getSi_name() + ","+site.getSi_ip(), site.getSi_id());
				if(isNotNull(gr_id)){
					GroupSite gs = new GroupSite();
					gs.setGr_id(gr_id);
					gs.setSi_id(site.getSi_id());
					
					int gs_no = GroupSiteInsertAction.executeAction(gs, USER_ID, true);
					if(gs_no > 0){
						gs.setGs_no(String.valueOf(gs_no));
						addJsonObject("groupSite", gs);
					}else {
						//
						setResultFail("group fail");
					}
				}
			}else {
				setResultFail();
			}*/
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}

		outJsonObject();
	}
	/*public boolean checkSiteIp(String ip) throws Exception{
		Site ipCheck = (Site) SiteDao.getInstace().selectSi_ip(ip);
		
		if(ipCheck != null){
			if(ipCheck.getSi_ip().equals(ip)){
				setResultStatus(310);
				setResultData(ipCheck);
				outJsonObject();
				return false;
			}
		}
		
		Connection con = null;
		try{
			con = DerbyDBManager.getConnection(ip);
		}catch(Exception e){
			setResultStatus(320);
			setResultMessage(e.getMessage());
			outJsonObject();
			return false;
			
		}finally{
			try{
				if(con != null) con.close();
			}catch(Exception e){}
		}
		return true;
	}*/
}
