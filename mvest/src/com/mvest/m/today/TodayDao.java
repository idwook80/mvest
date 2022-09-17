package com.mvest.m.today;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.swing.RepaintManager;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;


public class TodayDao implements DaoModel {

	public final static String DB			= "mvest";
	public final static String TABLE		= "m1_today ";
	public final static String[] COLUMNS  	= {"to_id","to_date", "co_code", "co_name", "to_balance","to_average","to_price","to_purchase","to_evaluation","to_profit","to_ration"};
	
	public volatile static TodayDao instance;
	
	public synchronized  static TodayDao getInstace(){
		if(instance == null){
			synchronized(TodayDao.class){
				instance = new TodayDao();
			}
		}
		return instance;
	}
	
	@Override
	public int insert(Object o) throws Exception {
		
		// TODO Auto-generated method stub
		Today t = (Today)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		query.intoValueStr(		"to_date"		, t);
		query.intoValueStr(		"co_code"		, t);
		query.intoValueStr(		"co_name"		, t);
		query.intoValueInt(		"to_balance"		, t);
		query.intoValueInt(		"to_average"		, t);
		query.intoValueInt(		"to_price"		, t);
		query.intoValueInt(		"to_purchase"		, t);
		query.intoValueInt(		"to_evaluation"		, t);
		query.intoValueInt(		"to_profit"		, t);
		query.intoValueInt(		"to_ration"		, t);
		
		
		
		int to_id = WebDBManager.getInstance().insertAndIndex(query.getInsert());
		t.setTo_id(String.valueOf(to_id));
		
		return to_id;
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
		return null;
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
		else query.setOrder("to_id", "DESC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<Today> companies = new ArrayList();
		for(HashMap row : list){
			Today c = new Today();
			query.setSelectObject(row, c);
			companies.add(c);
		}
		return companies;
	}
	
	
}
