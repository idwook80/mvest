package com.mvest.test.bybit.model;

public class BybitWebUser {
	String id;
	String password;
	String user_id;
	String api_key;
	String api_secret;
	String user_name;
	String alarm_model;
	String default_qty;
	
	public Object balance;
	public Object positions;
	public Object kline;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getApi_key() {
		return api_key;
	}
	public void setApi_key(String api_key) {
		this.api_key = api_key;
	}
	public String getApi_secret() {
		return api_secret;
	}
	public void setApi_secret(String api_secret) {
		this.api_secret = api_secret;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getAlarm_model() {
		return alarm_model;
	}
	public void setAlarm_model(String alarm_model) {
		this.alarm_model = alarm_model;
	}
	public String getDefault_qty() {
		return default_qty;
	}
	public void setDefault_qty(String default_qty) {
		this.default_qty = default_qty;
	}
	@Override
	public String toString() {
		return "BybitWebUser [id=" + id + ", password=" + password + ", user_id=" + user_id + ", api_key=" + api_key
				+ ", api_secret=" + api_secret + ", user_name=" + user_name + ", alarm_model=" + alarm_model
				+ ", default_qty=" + default_qty + ", balance=" + balance + ", positions=" + positions + ", kline="
				+ kline + "]";
	}
	
}
