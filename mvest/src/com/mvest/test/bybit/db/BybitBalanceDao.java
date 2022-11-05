package com.mvest.test.bybit.db;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.m.bank.Account;
import com.mvest.model.DaoModel;
import com.mvest.test.bybit.model.BybitBalance;
import com.mvest.test.bybit.model.BybitWebUser;

public class BybitBalanceDao implements DaoModel {
	public final static String DB			= "bybit";
	public final static String TABLE		= "balance";
	public final static String[] COLUMNS  	= {"id","symbol","equity",
												"available_balance","cum_realised_pnl","given_cash",
												"occ_closing_fee","occ_funding_fee",
												"order_margin","position_margin","realised_pnl",
												"service_cash","unrealised_pnl",
												"used_margin","wallet_balance",
												"reg_date","reg_datetime"};
												
												
	public volatile static BybitBalanceDao instance;
	
	public synchronized  static BybitBalanceDao getInstace(){
		if(instance == null){
			synchronized(BybitBalanceDao.class){
				instance = new BybitBalanceDao();
			}
		}
		return instance;
	}
    public int insert(Object o) throws Exception{
	   return 0;
    }
	public int update(Object o) throws Exception {
		return 0;
	}
	public int delete(Object o) throws Exception{
		return 0;
	}
	
	public Object select(String id) throws Exception{
		//BotConfig config = new BotConfig();
		WebDBManager mgr = WebDBManager.getInstance();
		StringBuffer queryBuffer = new StringBuffer();
		queryBuffer.append("SELECT * from "+DB + "."+ TABLE );

		if(id != null) {
			queryBuffer.append(" WHERE id = '"+ id +"'");
		}
		
		return mgr.selectHashMap(queryBuffer.toString());
		/*if(map != null) {
			config.setMap(map);
		}
		return config;*/
	}
	public int getListCount() throws Exception{
		return getListCount(null);
	}
	public int getListCount(String where) throws Exception{
		String sql = "SELECT count(*) FROM " + DB + "." + TABLE + (where != null ? ("  WHERE " + where) : "");
		
		Object[][] result = WebDBManager.getInstance().select(sql);
		if(result == null) return 0;
		System.out.println(result[0][0]);
		return Integer.parseInt(result[0][0].toString());
	}
	public List getList(int start, int offset) throws Exception{
		return getList(start, offset, null , null);
	}
	public List getList(int start, int offset, String where, String orderby) throws Exception{
		QueryBuffer query = new QueryBuffer(DB,TABLE);
		
		query.setSelect(COLUMNS);
		if(where != null) query.setWhere(where);
		if(orderby != null) query.setOrder(orderby);
		else query.setOrder("reg_date", "DESC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<BybitBalance> balances = new ArrayList();
		for(HashMap row : list){
			BybitBalance c = new BybitBalance();
			query.setSelectObject(row, c);
			balances.add(c);
		}
		return balances;
	}
}
