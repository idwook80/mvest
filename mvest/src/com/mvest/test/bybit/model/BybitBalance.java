package com.mvest.test.bybit.model;

import java.util.Date;

import com.mvest.util.TimeUtil;

public class BybitBalance {
	String id = "";
	String symbol = "USDT";
	double equity = 0.0;
	double available_balance= 0.0;
	double cum_realised_pnl = 0.0;
	double given_cash = 0.0;
	double occ_closing_fee = 0.0;
	double occ_funding_fee = 0.0;
	double order_margin = 0.0;
	double position_margin = 0.0;
	double realised_pnl = 0.0;
	double service_cash = 0.0;
	double unrealised_pnl = 0.0;
	double used_margin = 0.0;
	double wallet_balance = 0.0;
	Date reg_date = null;
	Date reg_datetime = null;
	double deposit = 0.0;
	double withdraw = 0.0;
	 
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSymbol() {
		return symbol;
	}

	public double getEquity() {
		return equity;
	}

	public void setEquity(double equity) {
		this.equity = equity;
	}
	public void setEquity(String equity) {
		this.equity = Double.valueOf(equity);
	}
	public double getAvailable_balance() {
		return available_balance;
	}

	public void setAvailable_balance(double available_balance) {
		this.available_balance = available_balance;
	}
	public void setAvailable_balance(String available_balance) {
		this.available_balance = Double.valueOf(available_balance);
	}

	public double getCum_realised_pnl() {
		return cum_realised_pnl;
	}

	public void setCum_realised_pnl(double cum_realised_pnl) {
		this.cum_realised_pnl = cum_realised_pnl;
	}
	public void setCum_realised_pnl(String cum_realised_pnl) {
		this.cum_realised_pnl = Double.valueOf(cum_realised_pnl);
	}
	
	public double getGiven_cash() {
		return given_cash;
	}

	public void setGiven_cash(double given_cash) {
		this.given_cash = given_cash;
	}
	public void setGiven_cash(String given_cash) {
		this.given_cash = Double.valueOf(given_cash);
	}
	
	public double getOcc_closing_fee() {
		return occ_closing_fee;
	}

	public void setOcc_closing_fee(double occ_closing_fee) {
		this.occ_closing_fee = occ_closing_fee;
	}
	public void setOcc_closing_fee(String occ_closing_fee) {
		this.occ_closing_fee = Double.valueOf(occ_closing_fee);
	}

	public double getOcc_funding_fee() {
		return occ_funding_fee;
	}

	public void setOcc_funding_fee(double occ_funding_fee) {
		this.occ_funding_fee = occ_funding_fee;
	}
	public void setOcc_funding_fee(String occ_funding_fee) {
		this.occ_funding_fee = Double.valueOf(occ_funding_fee);
	}

	public double getOrder_margin() {
		return order_margin;
	}

	public void setOrder_margin(double order_margin) {
		this.order_margin = order_margin;
	}
	public void setOrder_margin(String order_margin) {
		this.order_margin = Double.valueOf(order_margin);
	}

	public double getPosition_margin() {
		return position_margin;
	}

	public void setPosition_margin(double position_margin) {
		this.position_margin = position_margin;
	}
	public void setPosition_margin(String position_margin) {
		this.position_margin = Double.valueOf(position_margin);
	}
	
	public double getRealised_pnl() {
		return realised_pnl;
	}

	public void setRealised_pnl(double realised_pnl) {
		this.realised_pnl = realised_pnl;
	}
	public void setRealised_pnl(String realised_pnl) {
		this.realised_pnl = Double.valueOf(realised_pnl);
	}

	public double getService_cash() {
		return service_cash;
	}

	public void setService_cash(double service_cash) {
		this.service_cash = service_cash;
	}
	public void setService_cash(String service_cash) {
		this.service_cash = Double.valueOf(service_cash);
	}

	public double getUnrealised_pnl() {
		return unrealised_pnl;
	}

	public void setUnrealised_pnl(double unrealised_pnl) {
		this.unrealised_pnl = unrealised_pnl;
	}
	public void setUnrealised_pnl(String unrealised_pnl) {
		this.unrealised_pnl = Double.valueOf(unrealised_pnl);
	}
	
	public double getUsed_margin() {
		return used_margin;
	}

	public void setUsed_margin(double used_margin) {
		this.used_margin = used_margin;
	}
	public void setUsed_margin(String used_margin) {
		this.used_margin = Double.valueOf(used_margin);
	}

	public double getWallet_balance() {
		return wallet_balance;
	}

	public void setWallet_balance(double wallet_balance) {
		this.wallet_balance = wallet_balance;
	}
	public void setWallet_balance(String wallet_balance) {
		this.wallet_balance = Double.valueOf(wallet_balance);
	}
	
	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public void setReg_date(String reg_date) {
		//this.reg_date = new Date(reg_date);
		try {
		setReg_date(TimeUtil.getDefaultDate(reg_date+" 09:00:00"));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public Date getReg_datetime() {
		return reg_datetime;
	}

	public void setReg_datetime(Date reg_datetime) {
		this.reg_datetime = reg_datetime;
	}
	public void setReg_datetime(String reg_datetime) {
		try {
		setReg_datetime(TimeUtil.getDefaultDate(reg_datetime));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public double getDeposit() {
		return deposit;
	}

	public void setDeposit(double deposit) {
		this.deposit = deposit;
	}
	public void setDeposit(String deposit) {
		this.deposit = Double.valueOf(deposit);
	}
	
	public double getWithdraw() {
		return withdraw;
	}

	public void setWithdraw(double withdraw) {
		this.withdraw = withdraw;
	}
	public void setWithdraw(String withdraw) {
		this.withdraw = Double.valueOf(withdraw);
	}
	
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	@Override
	public String toString() {
		return "BybitBalance [id=" + id + ", symbol=" + symbol + ", equity=" + equity + ", available_balance="
				+ available_balance + ", cum_realised_pnl=" + cum_realised_pnl + ", given_cash=" + given_cash
				+ ", occ_closing_fee=" + occ_closing_fee + ", occ_funding_fee=" + occ_funding_fee + ", order_margin="
				+ order_margin + ", position_margin=" + position_margin + ", realised_pnl=" + realised_pnl
				+ ", service_cash=" + service_cash + ", unrealised_pnl=" + unrealised_pnl + ", used_margin="
				+ used_margin + ", wallet_balance=" + wallet_balance + ", reg_date=" + reg_date + ", reg_datetime="
				+ reg_datetime + ", deposit=" + deposit + ", withdraw=" + withdraw + "]";
	}

	 
}
