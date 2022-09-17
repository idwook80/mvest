package com.mvest.m.company;

public class Company {
	String to_date;
	String co_id;
	String co_code;
	String co_name;
	String to_price;
	String to_yesterday;
	String to_previous;
	
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public String getCo_id() {
		return co_id;
	}
	public void setCo_id(String co_id) {
		this.co_id = co_id;
	}
	public String getCo_code() {
		return co_code;
	}
	public void setCo_code(String co_code) {
		this.co_code = co_code;
	}
	public String getCo_name() {
		return co_name;
	}
	public void setCo_name(String co_name) {
		this.co_name = co_name;
	}
	public String getTo_price() {
		return to_price;
	}
	public void setTo_price(String to_price) {
		this.to_price = to_price;
	}
	public String getTo_yesterday() {
		return to_yesterday;
	}
	public void setTo_yesterday(String to_yesterday) {
		this.to_yesterday = to_yesterday;
	}
	public String getTo_previous() {
		return to_previous;
	}
	public void setTo_previous(String to_previous) {
		this.to_previous = to_previous;
	}
	public void setTo_previous_exe(){
		int y = Integer.parseInt(to_yesterday);
		int t = Integer.parseInt(to_price);
		int p = t - y;
		setTo_previous(String.valueOf(p));
	}
	
	
}	
