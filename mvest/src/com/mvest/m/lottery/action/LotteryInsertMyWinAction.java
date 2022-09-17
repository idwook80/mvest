package com.mvest.m.lottery.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.lottery.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;

public class LotteryInsertMyWinAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		Lottery win = new Lottery();
		win.setRound(getParameter("round"));
		win.setN1(getParameter("n1"));
		win.setN2(getParameter("n2"));
		win.setN3(getParameter("n3"));
		win.setN4(getParameter("n4"));
		win.setN5(getParameter("n5"));
		win.setN6(getParameter("n6"));
		
		try {
			
			int ret = LotteryMyWinDao.getInstace().insert(win);
			 
			setResultOk();
			setResultData(win);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		

		outJsonObject();
		
	}

}
