package com.mvest.m.lottery.action;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvest.m.lottery.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;

public class LotteryGameAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String sort 	= getParameter("sort");
		String orderby  = getParameter("order");
		
		
		String where = "";
	 
		
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
			LotteryGame game = new LotteryGame();
			
			LotteryWinAnalyze a = 	new LotteryWinAnalyze();
			a.analyze(a.limit);
			a.executeGame2();
			
			ArrayList<Integer[]> results = a.getResults();
			
			
			List<Lottery> wins = new ArrayList();
			for(int i=0; i<results.size(); i++) {
				Integer[] rr = results.get(i);
				wins.add(new Lottery(rr));
			}
			
			
			/*
			wins.add(new Lottery(game.executeGameNumbers()));
			wins.add(new Lottery(game.executeGameNumbers()));
			wins.add(new Lottery(game.executeGameNumbers()));
			wins.add(new Lottery(game.executeGameDefault()));
			wins.add(new Lottery(game.executeGameDefault()));
			*/
			if(wins != null) addJsonArray("wins", wins);
			
			
			Lottery win = (Lottery) LotteryDao.getInstace().selectLast();
			LotteryWin w = new LotteryWin();
			
			if(!w.checkDate(win.getDate())) {
				win  = w.getLastWin();  
			}
			
			addJsonObject("win", win); 
			
			
			setResultOk();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		

		outJsonObject();
		
	}

}
