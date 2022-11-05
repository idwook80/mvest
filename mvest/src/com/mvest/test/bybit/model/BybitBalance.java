package com.mvest.test.bybit.model;

import java.util.Date;

public class BybitBalance {
	String id;
	String symbol;
	String equity;
	String available_balance;
	String cum_realised_pnl;
	String given_cash;
	String occ_closing_fee;
	String occ_funding_fee;
	String order_margin;
	String position_margin;
	String realised_pnl;
	String service_cash;
	String unrealised_pnl;
	String used_margin;
	String wallet_balance;
	String reg_date;
	String reg_datetime;
	 
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getEquity() {
		return equity;
	}

	public void setEquity(String equity) {
		this.equity = equity;
	}

	public String getAvailable_balance() {
		return available_balance;
	}

	public void setAvailable_balance(String available_balance) {
		this.available_balance = available_balance;
	}

	public String getCum_realised_pnl() {
		return cum_realised_pnl;
	}

	public void setCum_realised_pnl(String cum_realised_pnl) {
		this.cum_realised_pnl = cum_realised_pnl;
	}

	public String getGiven_cash() {
		return given_cash;
	}

	public void setGiven_cash(String given_cash) {
		this.given_cash = given_cash;
	}

	public String getOcc_closing_fee() {
		return occ_closing_fee;
	}

	public void setOcc_closing_fee(String occ_closing_fee) {
		this.occ_closing_fee = occ_closing_fee;
	}

	public String getOcc_funding_fee() {
		return occ_funding_fee;
	}

	public void setOcc_funding_fee(String occ_funding_fee) {
		this.occ_funding_fee = occ_funding_fee;
	}

	public String getOrder_margin() {
		return order_margin;
	}

	public void setOrder_margin(String order_margin) {
		this.order_margin = order_margin;
	}

	public String getPosition_margin() {
		return position_margin;
	}

	public void setPosition_margin(String position_margin) {
		this.position_margin = position_margin;
	}

	public String getRealised_pnl() {
		return realised_pnl;
	}

	public void setRealised_pnl(String realised_pnl) {
		this.realised_pnl = realised_pnl;
	}

	public String getService_cash() {
		return service_cash;
	}

	public void setService_cash(String service_cash) {
		this.service_cash = service_cash;
	}

	public String getUnrealised_pnl() {
		return unrealised_pnl;
	}

	public void setUnrealised_pnl(String unrealised_pnl) {
		this.unrealised_pnl = unrealised_pnl;
	}

	public String getUsed_margin() {
		return used_margin;
	}

	public void setUsed_margin(String used_margin) {
		this.used_margin = used_margin;
	}

	public String getWallet_balance() {
		return wallet_balance;
	}

	public void setWallet_balance(String wallet_balance) {
		this.wallet_balance = wallet_balance;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getReg_datetime() {
		return reg_datetime;
	}

	public void setReg_datetime(String reg_datetime) {
		this.reg_datetime = reg_datetime;
	}

	@Override
	public String toString() {
		return "BybitBalance [id=" + id + ", symbol=" + symbol + ", equity=" + equity + ", available_balance="
				+ available_balance + ", cum_realised_pnl=" + cum_realised_pnl + ", given_cash=" + given_cash
				+ ", occ_closing_fee=" + occ_closing_fee + ", occ_funding_fee=" + occ_funding_fee + ", order_margin="
				+ order_margin + ", position_margin=" + position_margin + ", realised_pnl=" + realised_pnl
				+ ", service_cash=" + service_cash + ", unrealised_pnl=" + unrealised_pnl + ", used_margin="
				+ used_margin + ", wallet_balance=" + wallet_balance + ", reg_date=" + reg_date + ", reg_datetime="
				+ reg_datetime + "]";
	}
	
}
