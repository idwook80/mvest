package com.mvest.test.bybit.db;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;
import com.mvest.test.bybit.model.BybitAlarm;

public class BybitAlarmDao implements DaoModel {
	public final static String DB			= "bybit";
	public final static String TABLE		= "alarm";
	public final static String[] COLUMNS  	= {"alarm_id","parent_alarm_id","user_id",
												"symbol","trigger","is_over",
												"position","side",
												"price","qty","repeat",
												"parent_order_id","next_id",
												"order_id","alarm_kind",
												"msg","update_at"};
												
												
	public volatile static BybitAlarmDao instance;
	
	public synchronized  static BybitAlarmDao getInstace(){
		if(instance == null){
			synchronized(BybitAlarmDao.class){
				instance = new BybitAlarmDao();
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
		QueryBuffer query = new QueryBuffer(DB,TABLE);
		query.setSelect(COLUMNS);
		query.setWhere(" alarm_id = '" + id+"'");
		
		HashMap row = mgr.selectHashMap(query.getSelect());
		if(row != null) {
			BybitAlarm a = new BybitAlarm();
			query.setSelectObject(row, a);
			return a;
		}
		return null;
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
		else query.setOrder("trigger", "DESC");
		
		query.setLimit(start, offset);
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query.getSelect());
		if(list == null) return null;
		
		List<BybitAlarm> alarms = new ArrayList();
		
		for(HashMap row : list){
			BybitAlarm a = new BybitAlarm();
			query.setSelectObject(row, a);
			if(a.getNext_id() != null){
				BybitAlarm next = (BybitAlarm)select(a.getNext_id());
				if(next != null) a.setNext(next);
				
			}
			alarms.add(a);
		}
		return alarms;
	}
 
}
