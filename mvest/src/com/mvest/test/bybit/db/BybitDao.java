package com.mvest.test.bybit.db;

import java.util.HashMap;
import java.util.List;

import com.mvest.db.WebDBManager;
import com.mvest.m.coin.upbit.BotConfig;
import com.mvest.m.coin.upbit.db.ConfigDao;
import com.mvest.model.DaoModel;

public class BybitDao implements DaoModel {
	
	public volatile static BybitDao instance;
	
	public synchronized  static BybitDao getInstace(){
		if(instance == null){
			synchronized(BybitDao.class){
				instance = new BybitDao();
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
		return 0;
	}
	public int getListCount(String where) throws Exception{
		return 0;
	}
	public List getList(int start, int offset) throws Exception{
		return null;
	}
	public List getList(int start, int offset, String where, String orderby) throws Exception{
		return null;
	}
}
