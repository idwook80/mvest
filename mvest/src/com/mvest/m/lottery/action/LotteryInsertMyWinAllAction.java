package com.mvest.m.lottery.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonParser;
import com.mvest.m.lottery.*;
import com.mvest.model.ActionModel;
import com.mvest.model.Vo;

import com.google.gson.*;

import java.util.*;

public class LotteryInsertMyWinAllAction extends ActionModel {

	@Override
	public void perform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		createJsonOut(request, response);
		
		setDefaultParameter();
		
		String data = request.getParameter("data");
		JsonParser json = new JsonParser();
		JsonArray arr 	= 	(JsonArray) json.parse(data);
		
		try {
			for(int i=0; i<arr.size(); i++) {
				JsonObject obj = (JsonObject) arr.get(i);
				Lottery win = new Lottery();
				win.setRound(obj.get("round").toString());
				win.setN1(obj.get("n1").toString());
				win.setN2(obj.get("n2").toString());
				win.setN3(obj.get("n3").toString());
				win.setN4(obj.get("n4").toString());
				win.setN5(obj.get("n5").toString());
				win.setN6(obj.get("n6").toString());
				int ret = LotteryMyWinDao.getInstace().insert(win);
				if(ret <=0 ) throw new Exception("DB Insert Error");
		
			}
			setResultOk();
			//setResultData(win);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setResultError(e.getMessage());
		}
		

		outJsonObject();
		
	}

}
