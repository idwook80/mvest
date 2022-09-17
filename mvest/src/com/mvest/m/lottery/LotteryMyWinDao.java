package com.mvest.m.lottery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;

public class LotteryMyWinDao implements DaoModel {

	public final static String DB			= "lottery";
	public final static String TABLE		= "my";
	public final static String[] COLUMNS  	= {"round","n1", "n2", "n3","n4","n5","n6","reg_date"};
	
	public volatile static LotteryMyWinDao instance;
	
	public synchronized  static LotteryMyWinDao getInstace(){
		if(instance == null){
			synchronized(LotteryMyWinDao.class){
				instance = new LotteryMyWinDao();
			}
		}
		return instance;
	}
	
	@Override
	public int insert(Object o) throws Exception {
		
		// TODO Auto-generated method stub
		Lottery t = (Lottery)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		query.intoValueInt(		"round"		, t);
		query.intoValueInt(		"n1"		, t);
		query.intoValueInt(		"n2"		, t);
		query.intoValueInt(		"n3"		, t);
		query.intoValueInt(		"n4"		, t);
		query.intoValueInt(		"n5"		, t);
		query.intoValueInt(		"n6"		, t);
		//query.intoValueInt(		"b1"		, t);
		
		 return  WebDBManager.getInstance().insert(query.getInsert());
	}

	@Override
	public int update(Object o) throws Exception {
/*		// TODO Auto-generated method stub
		Company s = (Company)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		
		//query.setValueInt(		"si_id"		, s);
		query.setValueStr(		"si_name"		, s);
		query.setValueStr(		"si_ip"			, s);
		query.setValueStr(		"si_address"	, s);
		//query.setValueDate(		"si_register"	, CURRENT_NOW);
		query.setValueDate(		"si_update"		, CURRENT_NOW);
		
		query.addWhereInt("si_id",s.getSi_id());
		
		return WebDBManager.getInstance().update(query.getUpdate());*/
		return 0;
	}

	@Override
	public int delete(Object o) throws Exception {
		return 0;
	}

	@Override
	public Object select(String id) throws Exception {
		QueryBuffer query = new QueryBuffer(DB,TABLE);
		query.setSelect(COLUMNS);
		query.addWhereInt("round", id);
		
		
		
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null || list.isEmpty()) return null;
		HashMap row = list.get(0);
		Lottery win = new Lottery();
		query.setSelectObject(row, win);
		return win;
	}
	public Object selectLast() throws Exception {
		
		// TODO Auto-generated method stub
				QueryBuffer query = new QueryBuffer(DB,TABLE);
				query.setSelect(COLUMNS);
				query.setOrder("round", "DESC");
				
				 query.setLimit(0, 10);
				 
				 
				Object[][] obj = WebDBManager.getInstance().select(query.getSelect());
				if(obj == null) return null;
				Lottery win = new Lottery();
				
				win.setRound(obj[0][0].toString());
				win.setN1(obj[0][1].toString());
				win.setN2(obj[0][2].toString());
				win.setN3(obj[0][3].toString());
				win.setN4(obj[0][4].toString());
				win.setN5(obj[0][5].toString());
				win.setN6(obj[0][6].toString());
				win.setB1(obj[0][7].toString());
				
				return win;
	}
	 

	@Override
	public int getListCount() throws Exception {
		// TODO Auto-generated method stub
		return getListCount(null);
	}

	@Override
	public int getListCount(String where) throws Exception {
		// TODO Auto-generated method stub
		String sql = "SELECT count(*) FROM " + DB + "." + TABLE + (where != null ? ("  WHERE " + where) : "");
		
		Object[][] result = WebDBManager.getInstance().select(sql);
		if(result == null) return 0;
		System.out.println(result[0][0]);
		return Integer.parseInt(result[0][0].toString());
	}
	
	@Override
	public List getList(int start, int offset) throws Exception {
		// TODO Auto-generated method stub
		return getList(start, offset, null , null);
	}
	
	@Override
	public List getList(int start, int offset, String where, String orderby) throws Exception {
		// TODO Auto-generated method stub
		QueryBuffer query = new QueryBuffer(DB,TABLE);
		query.setSelect(COLUMNS);
		
		if(where != null) query.setWhere(where);
		if(orderby != null) query.setOrder(orderby);
		else query.setOrder("reg_date", "ASC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<Lottery> wins = new ArrayList();
		for(HashMap row : list){
			Lottery c = new Lottery();
			query.setSelectObject(row, c);
			wins.add(c);
			System.out.println(c);
		}
		return wins;
	}
	
	
}