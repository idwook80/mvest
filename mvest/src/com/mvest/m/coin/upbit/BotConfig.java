package com.mvest.m.coin.upbit;

import java.util.HashMap;

public class BotConfig {
	String uuid;
	String currency;
	String unit_currency;
	String market;
	String volume;
	String goal;
	String buy;
	String buy_wait_timeout;
	String sell_wait_timeout;
	String stop;
	String created_at;
	
	public void setMap(HashMap map) {
		if(map.containsKey("uuid")) uuid =  map.get("uuid").toString();
		if(map.containsKey("currency")) currency =  map.get("currency").toString();
		if(map.containsKey("unit_currency")) unit_currency =  map.get("unit_currency").toString();
		if(map.containsKey("market")) market =  map.get("market").toString();
		if(map.containsKey("volume")) volume =  map.get("volume").toString();
		if(map.containsKey("goal")) goal =  map.get("goal").toString();
		if(map.containsKey("buy")) buy =  map.get("buy").toString();
		if(map.containsKey("buy_wait_timeout")) buy_wait_timeout =  map.get("buy_wait_timeout").toString();
		if(map.containsKey("sell_wait_timeout")) sell_wait_timeout =  map.get("sell_wait_timeout").toString();
		if(map.containsKey("stop")) stop = map.get("stop").toString();
		if(map.containsKey("created_at")) created_at = map.get("created_at").toString();
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getUnit_currency() {
		return unit_currency;
	}

	public void setUnit_currency(String unit_currency) {
		this.unit_currency = unit_currency;
	}

	public String getMarket() {
		return market;
	}

	public void setMarket(String market) {
		this.market = market;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	public String getBuy() {
		return buy;
	}

	public void setBuy(String buy) {
		this.buy = buy;
	}

	public String getBuy_wait_timeout() {
		return buy_wait_timeout;
	}

	public void setBuy_wait_timeout(String buy_wait_timeout) {
		this.buy_wait_timeout = buy_wait_timeout;
	}

	public String getSell_wait_timeout() {
		return sell_wait_timeout;
	}

	public void setSell_wait_timeout(String sell_wait_timeout) {
		this.sell_wait_timeout = sell_wait_timeout;
	}

	public String getStop() {
		return stop;
	}

	public void setStop(String stop) {
		this.stop = stop;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	@Override
	public String toString() {
		return "BotConfig [uuid=" + uuid + ", currency=" + currency + ", unit_currency=" + unit_currency + ", market="
				+ market + ", volume=" + volume + ", goal=" + goal + ", buy=" + buy + ", buy_wait_timeout="
				+ buy_wait_timeout + ", sell_wait_timeout=" + sell_wait_timeout + ", stop=" + stop + ", created_at="
				+ created_at + "]";
	}
	
	
}
