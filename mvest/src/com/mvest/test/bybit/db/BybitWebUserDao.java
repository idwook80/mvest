package com.mvest.test.bybit.db;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.m.bank.Account;
import com.mvest.model.DaoModel;
import com.mvest.test.bybit.model.BybitWebUser;

public class BybitWebUserDao implements DaoModel {
	public final static String DB			= "bybit";
	public final static String TABLE		= "user";
	public final static String[] COLUMNS  	= {"id", "password", "user_id", "api_key", "api_secret", "user_name","alarm_model"};
	
	public volatile static BybitWebUserDao instance;
	
	public synchronized  static BybitWebUserDao getInstace(){
		if(instance == null){
			synchronized(BybitWebUserDao.class){
				instance = new BybitWebUserDao();
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
		queryBuffer.append("SELECT * from bybit.user A");

		if(id != null) {
			queryBuffer.append(" WHERE A.id = '"+ id +"'");
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
		//else query.setOrder("ac_id", "DESC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<BybitWebUser> users = new ArrayList();
		for(HashMap row : list){
			BybitWebUser c = new BybitWebUser();
			query.setSelectObject(row, c);
			users.add(c);
		}
		return users;
	}
}
