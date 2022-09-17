package com.mvest.model;

import java.util.List;

public interface DaoModel {
	
	public final static String CURRENT_DATE 	= "now()";
	public final static String CURRENT_NOW 		= "now()";
	public final static String CURRENT_DATE_DERBY 		= "CURRENT_TIMESTAMP";
	public final static String CURRENT_NOW_DERBY		= "CURRENT_TIMESTAMP";
	
	public final static String INSERT_ID		= "0";
	public final static String DELETE_YES		= "Y";
	public final static String DELETE_NO		= "N";
	
	public final static int QUERY_SELECT		= 0;
	public final static int QUERY_INSERT 		= 1;
	public final static int QUERY_UPDATE 		= 2;
	public final static int QUERY_DELETE 		= 3;
	
	abstract public int insert(Object o) throws Exception;
	abstract public int update(Object o) throws Exception;
	abstract public int delete(Object o) throws Exception;
	abstract public Object select(String id) throws Exception;
	
	abstract public int getListCount() throws Exception;
	abstract public int getListCount(String where) throws Exception;
	
	abstract public List getList(int start, int offset) throws Exception;
	abstract public List getList(int start, int offset, String where, String orderby) throws Exception;



}
