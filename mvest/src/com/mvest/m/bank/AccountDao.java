package com.mvest.m.bank;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.swing.RepaintManager;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;


public class AccountDao implements DaoModel {

	public final static String DB			= "mvest";
	public final static String TABLE		= "m1_account";
	public final static String[] COLUMNS  	= {"ac_id", "bk_id", "bk_name", "ac_balance", "ac_stock", "ac_date"};
	
	public volatile static AccountDao instance;
	
	public synchronized  static AccountDao getInstace(){
		if(instance == null){
			synchronized(AccountDao.class){
				instance = new AccountDao();
			}
		}
		return instance;
	}
	
	@Override
	public int insert(Object o) throws Exception {
	/*	// TODO Auto-generated method stub
		Company  s = (Company)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		
		//query.intoValueInt(		"si_id"		, s);
		query.intoValueStr(		"si_name"		, s);
		query.intoValueStr(		"si_ip"			, s);
		query.intoValueStr(		"si_address"	, s);
		query.intoValueDate(	"si_register"	, CURRENT_NOW);
		query.intoValueDate(	"si_update"		, CURRENT_NOW);
		
		
		int si_id = WebDBManager.getInstance().insertAndIndex(query.getInsert());
		
		s.setSi_id(String.valueOf(si_id));
		
		return si_id;*/
		return 0;
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
		else query.setOrder("ac_id", "DESC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<Account> accounts = new ArrayList();
		for(HashMap row : list){
			Account c = new Account();
			query.setSelectObject(row, c);
			accounts.add(c);
		}
		return accounts;
	}
	
	
}
