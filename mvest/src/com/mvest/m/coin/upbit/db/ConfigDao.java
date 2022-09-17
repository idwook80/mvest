package com.mvest.m.coin.upbit.db;

import java.util.HashMap;
import java.util.List;

import com.mvest.db.WebDBManager;
import com.mvest.m.coin.upbit.BotConfig;
import com.mvest.m.company.CompanyDao;
import com.mvest.model.DaoModel;

public class ConfigDao implements DaoModel {
	
	public volatile static ConfigDao instance;
	
	public synchronized  static ConfigDao getInstace(){
		if(instance == null){
			synchronized(ConfigDao.class){
				instance = new ConfigDao();
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
		BotConfig config = new BotConfig();
		WebDBManager mgr = WebDBManager.getInstance();
		StringBuffer queryBuffer = new StringBuffer();
		queryBuffer.append("SELECT * from upbit.config A");

		if(id != null) {
			queryBuffer.append(" WHERE A.market = '"+ id +"'");
		}
		queryBuffer.append(" ORDER BY A.created_at DESC");
		
		HashMap  map = mgr.selectHashMap(queryBuffer.toString());
		if(map != null) {
			config.setMap(map);
		}
		return config;
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
