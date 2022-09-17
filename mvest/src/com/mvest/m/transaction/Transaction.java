package com.mvest.m.transaction;

public class Transaction {
	public final static String SELL = "SELL";
	public final static String BUY 	= "BUY";
	String tr_id;
	String tr_type;
	String bk_id;
	String mb_id;
	String co_code;
	String tr_date;
	String tr_price;
	String tr_quantity;
	String co_name;
	String bk_name;
	String tr_avg;
	
	public String getTr_id() {
		return tr_id;
	}
	public void setTr_id(String tr_id) {
		this.tr_id = tr_id;
	}
	public String getTr_type() {
		return tr_type;
	}
	public void setTr_type(String tr_type) {
		this.tr_type = tr_type;
	}
	public String getBk_id() {
		return bk_id;
	}
	public void setBk_id(String bk_id) {
		this.bk_id = bk_id;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getCo_code() {
		return co_code;
	}
	public void setCo_code(String co_code) {
		this.co_code = co_code;
	}
	public String getTr_date() {
		return tr_date;
	}
	public void setTr_date(String tr_date) {
		this.tr_date = tr_date;
	}
	public String getTr_price() {
		return tr_price;
	}
	public void setTr_price(String tr_price) {
		this.tr_price = tr_price;
	}
	public String getTr_quantity() {
		return tr_quantity;
	}
	public void setTr_quantity(String tr_quantity) {
		this.tr_quantity = tr_quantity;
	}
	public static String getSell() {
		return SELL;
	}
	public static String getBuy() {
		return BUY;
	}
	public String getCo_name() {
		return co_name;
	}
	public void setCo_name(String co_name) {
		this.co_name = co_name;
	}
	public String getBk_name() {
		return bk_name;
	}
	public void setBk_name(String bk_name) {
		this.bk_name = bk_name;
	}
	public String getTr_avg() {
		return tr_avg;
	}
	public void setTr_avg(String tr_avg) {
		this.tr_avg = tr_avg;
	}
	
	
}
