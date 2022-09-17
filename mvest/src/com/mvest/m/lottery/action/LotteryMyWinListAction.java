package com.mvest.m.lottery.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.lottery.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;

public class LotteryMyWinListAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
		
		String round = getParameter("round");
		
		
		String where = "";
		if(isNotNull(round)) where += " round = '"+round +"'";
		
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
			int total = LotteryMyWinDao.getInstace().getListCount(where);
			Vo vo = getNumbersForPaging(total, curPage, numPerPage, pagePerBlock);
			addJsonObject("vo", vo);
			
			List<Lottery> wins = LotteryMyWinDao.getInstace().getList(vo.getStartRecord(), vo.getEndRecord(), where, orderby);
			if(wins != null) addJsonArray("wins", wins);
			addJsonObjectProperty("total", String.valueOf(total));
			
			
			
			Lottery win = (Lottery) LotteryDao.getInstace().selectLast();
			LotteryWin w = new LotteryWin();
			if(!w.checkDate(win.getDate())) {
				win  = w.getLastWin();  
			}
			
			addJsonObject("win", win); 
			
			//Lottery win = (Lottery)LotteryDao.getInstace().selectLast();
			
		
			
			
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		

		outJsonObject();
		
	}

}
