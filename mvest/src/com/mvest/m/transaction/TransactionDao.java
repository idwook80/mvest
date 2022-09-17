package com.mvest.m.transaction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mvest.db.QueryBuffer;
import com.mvest.db.WebDBManager;
import com.mvest.model.DaoModel;

public class TransactionDao implements DaoModel {

	public final static String DB			= "mvest";
	public final static String TABLE		= "m1_transaction ";
	public final static String[] COLUMNS  	= {"tr_id","co_code", "co_code", "co_name", "to_balance","to_average","to_price","to_purchase","to_evaluation","to_profit","to_ration"};
	
	public volatile static TransactionDao instance;
	
	public synchronized  static TransactionDao getInstace(){
		if(instance == null){
			synchronized(TransactionDao.class){
				instance = new TransactionDao();
			}
		}
		return instance;
	}
	
	@Override
	public int insert(Object o) throws Exception {
		
		// TODO Auto-generated method stub
		Transaction t = (Transaction)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		query.intoValueStr(		"co_code"		, t);
		query.intoValueInt(		"bk_id"			, t);
		query.intoValueStr(		"tr_type"		, t);
		query.intoValueInt(		"tr_price"		, t);
		query.intoValueInt(		"tr_quantity"	, t);
		query.intoValueDate(    "tr_date"		, t);
		
		
		int tr_id = WebDBManager.getInstance().insertAndIndex(query.getInsert());
		//t.setTo_id(String.valueOf(to_id));
		
		return tr_id;
	}

	@Override
	public int update(Object o) throws Exception {
/*		// TODO Auto-generated method stub
		Company s = (Company)o;
		
		QueryBuffer query = new QueryBuffer(DB, TABLE);
		
		//query.setValueInt(	"si_id"		, s);
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
		String sql = "SELECT count(*) FROM m1_transaction A " + (where != null ? ("  WHERE " + where) : "");
		
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
		
		String from = "SELECT A.*,B.co_name,C.bk_name FROM m1_transaction A";
		String join = " INNER JOIN m1_company B ON A.co_code = B.co_code INNER JOIN m1_bank C ON A.bk_id = C.bk_id ";
		
	 
		String option = " ORDER BY A.tr_date DESC  LIMIT " + start + " , " + offset;
		
			
		String query =  from + join +  ( where != null ? (" WHERE " + where) :  " ") + option;
		
		List<HashMap> list  = WebDBManager.getInstance().queryForList(query);
		if(list == null) return null;
		
		List<Transaction> transactions = new ArrayList();
		for(HashMap row : list){
			Transaction c = new Transaction();
			setObject(c, row);
			transactions.add(c);
		}
		return transactions;
	}
	public List getTodaySum() {
		String query = "SELECT A.tr_date, A.tr_type, SUM(A.tr_price * A.tr_quantity";
			query += " FROM m1_transaction A ";
			query += " GROUP BY A.tr_date , A.tr_type";
			query += " ORDER BY A.tr_date DESC";
			
			return null;
		
		
	}
	public void setObject(Object obj, HashMap map) {
		java.lang.reflect.Method[] methods = obj.getClass().getMethods();
		
		for(int i=0; i<methods.length; i++) {
			String name = methods[i].getName();
			if(name.startsWith("set")) {
				try {
					String key = name.replace("set", "").toLowerCase();
					if(map.containsKey(key)) methods[i].invoke(obj, (String)map.get(key));
					
				}catch(Exception e) {
					
				}
			}
		}
	}
	
	
}
