package com.mvest.m.transaction.action;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.mystock.MyStockDao;
import com.mvest.m.transaction.*;
import com.mvest.model.ActionModel;

public class TransactionInsertAction  extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			createJsonOut(request, response);
			
			Transaction tr = new Transaction();
			tr.setCo_code(getParameter("co_code"));
			tr.setBk_id(getParameter("bk_id"));
			tr.setTr_type(getParameter("tr_type"));
			tr.setTr_price(getParameter("tr_price"));
			tr.setTr_quantity(getParameter("tr_quantity"));
			tr.setTr_date(getParameter("tr_date"));
			
			int price = Integer.parseInt(tr.getTr_price());
			int quantity = Integer.parseInt(tr.getTr_quantity());
			
			int total = price * quantity;
			int tr_id = TransactionDao.getInstace().insert(tr);
		
			
			if(tr_id > 0){
				tr.setTr_id(String.valueOf(tr_id));
				 
				MyStockDao.getInstace().updateTransaction(tr);
				
				setResultOk();
				setResultData(tr);
			}else {
				setResultFail();
			}
			
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
