package com.mvest.m.lottery.action;

import java.util.Comparator;

public class WinInfo implements Comparable<WinInfo> {
	String no;
	double total_count = 0.0;
	double recently_count = 0.0;
	int recently_round = 0;
	int last_round = 0;
	int total = 0;
	int limit = 0;
	
	public WinInfo(String no) {
		setNo(no);
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public double getTotal_count() {
		return total_count;
	}

	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	public void addTotal_count() {
		this.total_count += 1.0;
	}
	
	public void addTotal_count_half() {
		this.total_count += 0.5;
	}

	public double getRecently_count() {
		return recently_count;
	}

	public void setRecently_count(int recently_count) {
		this.recently_count = recently_count;
	}
	public void addRecently_count() {
		this.recently_count += 1.0;
	}
	public void addRecently_count_half() {
		this.recently_count += 0.5;
	}

	public int getRecently_round() {
		return recently_round;
	}
	
	int old_round = 0;
	public void setRecently_round(int recently_round) {
		if(Integer.parseInt(no)  == 1 && this.recently_round != 0) {
			int term = this.old_round - recently_round;
			//System.out.println(recently_round + " " + term);
			old_round = recently_round;
		}else {
			old_round = recently_round;
		}
		if(this.recently_round > recently_round) return;
		this.recently_round = recently_round;
	}
	
	public int getLast_round() {
		return last_round;
	}

	public void setLast_round(int last_round) {
		this.last_round = last_round;
	}

	
	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String toString() {
		return "No ["+ this.no + "], recently [ " + this.recently_count+ "/"+limit+" ], total [ " 
				+ this.total_count + "/ "+total+" ], last Round [ " + this.recently_round + " ] [ " + (this.recently_round - last_round) + "]";
	}
	 
	public int compareTo(WinInfo o2) {
		
		if(this.getRecently_count() == o2.getRecently_count()) {
			
			if(this.getTotal_count() == o2.getTotal_count()) {
				if(this.getRecently_round() == o2.getRecently_round())  return 0;
				if(this.getRecently_round() < o2.getRecently_round()) return 1;
				else return -1;
			}else if(this.getTotal_count() < o2.getTotal_count()) return 1;
			else return -1;
		
		}else if(this.getRecently_count() < o2.getRecently_count()) return 1;
		else return -1;
	 }
	
}
