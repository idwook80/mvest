package com.mvest.test.bybit.model;

import java.util.Date;

import com.mvest.util.TimeUtil;

public class BybitAlarm {
	String alarm_id;
	String parent_alarm_id;
	String user_id;
	String symbol;
	double trigger;
	String is_over;
	String position;
	String side;
	double price;
	double qty;
	int repeat;
	String parent_order_id;
	String next_id;
	String order_id;
	String alarm_kind;
	String msg;
	Date update_at;
	BybitAlarm next;
	public String getAlarm_id() {
		return alarm_id;
	}
	public void setAlarm_id(String alarm_id) {
		this.alarm_id = alarm_id;
	}
	public String getParent_alarm_id() {
		return parent_alarm_id;
	}
	public void setParent_alarm_id(String parent_alarm_id) {
		this.parent_alarm_id = parent_alarm_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public double getTrigger() {
		return trigger;
	}
	public void setTrigger(double trigger) {
		this.trigger = trigger;
	}
	public void setTrigger(String trigger) {
		this.trigger = Double.valueOf(trigger);
	}
	public String getIs_over() {
		return is_over;
	}
	public void setIs_over(String is_over) {
		this.is_over = is_over;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getSide() {
		return side;
	}
	public void setSide(String side) {
		this.side = side;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public void setPrice(String price) {
		this.price = Double.valueOf(price);
	}
	public double getQty() {
		return qty;
	}
	public void setQty(double qty) {
		this.qty = qty;
	}
	public void setQty(String qty) {
		this.qty = Double.valueOf(qty);
	}
	public int getRepeat() {
		return repeat;
	}
	public void setRepeat(int repeat) {
		this.repeat = repeat;
	}
	public void setRepeat(String repeat) {
		this.repeat = Integer.valueOf(repeat);
	}
	public String getParent_order_id() {
		return parent_order_id;
	}
	public void setParent_order_id(String parent_order_id) {
		this.parent_order_id = parent_order_id;
	}
	public String getNext_id() {
		return next_id;
	}
	public void setNext_id(String next_id) {
		this.next_id = next_id;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getAlarm_kind() {
		return alarm_kind;
	}
	public void setAlarm_kind(String alarm_kind) {
		this.alarm_kind = alarm_kind;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Date getUpdate_at() {
		return update_at;
	}
	public void setUpdate_at(Date update_at) {
		this.update_at = update_at;
	}
	public void setUpdate_at(String reg_datetime) {
		try {
			setUpdate_at(TimeUtil.getDefaultDate(reg_datetime));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void setNext(BybitAlarm next) {
		this.next = next;
	}
	public BybitAlarm getNext() {
		return next;
	}
	
	@Override
	public String toString() {
		return "BybitAlarm [alarm_id=" + alarm_id + ", parent_alarm_id=" + parent_alarm_id + ", user_id=" + user_id
				+ ", symbol=" + symbol + ", trigger=" + trigger + ", is_over=" + is_over + ", position=" + position
				+ ", side=" + side + ", price=" + price + ", qty=" + qty + ", repeat=" + repeat + ", parent_order_id="
				+ parent_order_id + ", next_id=" + next_id + ", order_id=" + order_id + ", alarm_kind=" + alarm_kind
				+ ", msg=" + msg + ", update_at=" + update_at + "]";
	}
	
	
}
