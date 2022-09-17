package com.mvest.m.mystock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.swing.RepaintManager;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;
import com.mysql.jdbc.BalanceStrategy;
import com.mvest.m.transaction.*;

public class MyStockDao implements DaoModel {

	public final static String DB			= "mvest";
	public final static String TABLE		= "m1_mystock ";
	public final static String[] COLUMNS  	= {"ms_id", "bk_id","co_code","co_name","ms_balance","ms_average","ms_yesterday","ms_today","ms_buy_1","ms_buy_2","ms_buy_3","ms_sell_1","ms_sell_2","ms_sell_3"};
	
	public volatile static MyStockDao instance;
	
	public synchronized  static MyStockDao getInstace(){
		if(instance == null){
			synchronized(MyStockDao.class){
				instance = new MyStockDao();
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
	
	public int updateTransaction(Transaction tr) throws Exception {
		String co_code 		= tr.getCo_code();
		String bk_id 		= tr.getBk_id();
		String tr_type 		= tr.getTr_type();
		int tr_price 		= Integer.parseInt(tr.getTr_price());
		int tr_quantity 	= Integer.parseInt(tr.getTr_quantity());
		int tr_total		= tr_price * tr_quantity;
		
		boolean isBuy = tr_type.toUpperCase().equals(Transaction.BUY);
		MyStock ms = select(co_code, bk_id);
		
		
		int ms_balance = Integer.parseInt(ms.getMs_balance());
		int ms_average = Integer.parseInt(ms.getMs_average());
		int ms_purchase = ms_balance * ms_average;
		
		double fee = 0.00005;
		if(isBuy) {
			ms_balance += tr_quantity;
			ms_purchase += ( tr_total + (tr_total * fee));
			ms_average = ms_purchase /  ms_balance;
		}else {
			ms_balance -= tr_quantity;
			ms_purchase -= tr_total;
		}
		
		String query = "UPDATE m1_mystock A SET A.ms_balance = " + ms_balance + " , A.ms_average = " + ms_average 
					 + " WHERE co_code = '" + co_code + "' AND bk_id = " + bk_id ;
		
		return WebDBManager.getInstance().update(query);
		
	}

	@Override
	public int delete(Object o) throws Exception {
		return 0;
	}

	@Override
	public Object select(String id) throws Exception {
		return null;
	}
	public MyStock select(String co_code, String bk_id) throws Exception {
		String query = "SELECT * FROM mvest.m1_mystock A WHERE A.co_code = '" + co_code + "' AND A.bk_id = " + bk_id;
		
		HashMap result = (HashMap) WebDBManager.getInstance().queryForObject(query);
		 
		
		MyStock ms = new MyStock();
		//"ms_id", "bk_id","co_code","co_name","ms_balance","ms_average","ms_yesterday","ms_today"
		ms.setCo_code( (String) result.get("co_code"));
		ms.setCo_name( (String) result.get("co_name"));
		ms.setBk_id( (String) result.get("bk_id"));
		ms.setMs_balance( (String) result.get("ms_balance"));
		ms.setMs_average( (String) result.get("ms_average"));
		ms.setMs_yesterday( (String) result.get("ms_yesterday"));
		ms.setMs_today( (String) result.get("ms_today"));
		
		return ms;
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
		String query = "SELECT A.*, C.bk_name FROM m1_mystock A "
					+ " INNER JOIN m1_company B ON A.co_code = B.co_code "
					+ " INNER JOIN m1_bank C ON A.bk_id = C.bk_id  "
					+ " ORDER BY A.bk_id ASC , A.ms_id ASC "
					+ " LIMIT " + start + " , " + offset;
				
	
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query);
		if(list == null) return null;
		
		List<MyStock> stocks = new ArrayList();
		for(HashMap row : list){
			MyStock c = new MyStock();
			setObject(c, row);
			System.out.println(c.getCo_name());
			stocks.add(c);
		}
		return stocks;
	}
	
	public void  setObject(Object obj,HashMap map) {
		java.lang.reflect.Method[] methods = obj.getClass().getMethods();
		
		for(int i=0; i<methods.length; i++) {
			String name = methods[i].getName();
				System.out.println(name);
				if(name.startsWith("set")) {
					try {
						String key = name.replace("set", "").toLowerCase();
						methods[i].invoke(obj, (String)map.get(key));
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
		}
	}
	
}
