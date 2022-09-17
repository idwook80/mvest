package com.mvest.m.mystock;

import java.lang.reflect.Method;

public class MyStock {
	String to_date;
	String bk_id;
	String bk_name;
	String co_id;
	String co_code;
	String co_name;
	String ms_balance;
	String ms_average;
	String ms_yesterday;
	String ms_today;
	String ms_previous;
	
	String ms_buy_1;
	String ms_buy_2;
	String ms_buy_3;
	String ms_sell_1;
	String ms_sell_2;
	String ms_sell_3;
	
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public String getBk_id() {
		return bk_id;
	}
	public void setBk_id(String bk_id) {
		this.bk_id = bk_id;
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
	public String getMs_balance() {
		return ms_balance;
	}
	public void setMs_balance(String ms_balance) {
		this.ms_balance = ms_balance;
	}
	public String getMs_average() {
		return ms_average;
	}
	public void setMs_average(String ms_average) {
		this.ms_average = ms_average;
	}
	public String getMs_yesterday() {
		return ms_yesterday;
	}
	public void setMs_yesterday(String ms_yesterday) {
		this.ms_yesterday = ms_yesterday;
	}
	public String getMs_today() {
		return ms_today;
	}
	public void setMs_today(String ms_today) {
		this.ms_today = ms_today;
	}
	
	public String getBk_name() {
		return bk_name;
	}
	public void setBk_name(String bk_name) {
		this.bk_name = bk_name;
	}
	public String getMs_buy_1() {
		return ms_buy_1;
	}
	public void setMs_buy_1(String ms_buy_1) {
		this.ms_buy_1 = ms_buy_1;
	}
	public String getMs_buy_2() {
		return ms_buy_2;
	}
	public void setMs_buy_2(String ms_buy_2) {
		this.ms_buy_2 = ms_buy_2;
	}
	public String getMs_buy_3() {
		return ms_buy_3;
	}
	public void setMs_buy_3(String ms_buy_3) {
		this.ms_buy_3 = ms_buy_3;
	}
	public String getMs_sell_1() {
		return ms_sell_1;
	}
	public void setMs_sell_1(String ms_sell_1) {
		this.ms_sell_1 = ms_sell_1;
	}
	public String getMs_sell_2() {
		return ms_sell_2;
	}
	public void setMs_sell_2(String ms_sell_2) {
		this.ms_sell_2 = ms_sell_2;
	}
	public String getMs_sell_3() {
		return ms_sell_3;
	}
	public void setMs_sell_3(String ms_sell_3) {
		this.ms_sell_3 = ms_sell_3;
	}
	public String getMs_previous() {
		return ms_previous;
	}
	public void setMs_previous(String ms_previous) {
		this.ms_previous = ms_previous;
	}
	public void setMs_previous_exe(){
		int y = Integer.parseInt(ms_yesterday);
		int t = Integer.parseInt(ms_today);
		int p = t - y;
		setMs_previous(String.valueOf(p));
	}
	
}
