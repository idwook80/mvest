package com.mvest.m.lottery;

import java.util.ArrayList;
import java.util.Arrays;

import javax.swing.plaf.synth.Region;

public class Lottery {
		String round;
		String n1;
		String n2;
		String n3;
		String n4;
		String n5;
		String n6;
		String b1;
		String date;
		String reg_date;
		
		Integer[] results = null;
		public Lottery() {
			
		}
		public Lottery(Integer[] wins) {
			setWins(wins);
		}
		public Lottery(int round, int n1, int n2, int n3, int n4, int n5, int n6, int b1) {
			setRound(String.valueOf(round));
			setN1(String.valueOf(n1));
			setN2(String.valueOf(n2));
			setN3(String.valueOf(n3));
			setN4(String.valueOf(n4));
			setN5(String.valueOf(n5));
			setN6(String.valueOf(n6));
			setB1(String.valueOf(b1));
			
		}
		public String getRound() {
			return round;
		}
		public void setRound(String round) {
			this.round = round;
		}
		public String getN1() {
			return n1;
		}
		public void setN1(String n1) {
			this.n1 = n1;
		}
		public String getN2() {
			return n2;
		}
		public void setN2(String n2) {
			this.n2 = n2;
		}
		public String getN3() {
			return n3;
		}
		public void setN3(String n3) {
			this.n3 = n3;
		}
		public String getN4() {
			return n4;
		}
		public void setN4(String n4) {
			this.n4 = n4;
		}
		public String getN5() {
			return n5;
		}
		public void setN5(String n5) {
			this.n5 = n5;
		}
		public String getN6() {
			return n6;
		}
		public void setN6(String n6) {
			this.n6 = n6;
		}
		public String getB1() {
			return b1;
		}
		public void setB1(String b1) {
			this.b1 = b1;
		}
		public void setWins(Integer[] win) {
			setN1(String.valueOf(win[0]));
			setN2(String.valueOf(win[1]));
			setN3(String.valueOf(win[2]));
			setN4(String.valueOf(win[3]));
			setN5(String.valueOf(win[4]));
			setN6(String.valueOf(win[5]));
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		
		public String getReg_date() {
			return reg_date;
		}
		public void setReg_date(String reg_date) {
			this.reg_date = reg_date;
		}
		public String toString() {
			return round + "," + n1 + "," + n2 + ","  + n3 +"," + n4 + "," + n5+"," + n6+ ","+ "+"+b1 + ","+date;
		}
		
		public Integer[] getResults() {
			return results;
		}
		public void setResults(Integer[] results) {
			this.results = results;
		}
		public String toStringResults() {
			Integer[] sames = getSameNumber();
			return round + " [ " + n1 + "," + n2 + ","  + n3 +"," + n4 + "," + n5+"," + n6+ "],WIN" + 
					"[ " + results[1] + "," +  results[2]  + ","  +  results[3]  +"," +  results[4]  + "," +  results[5] +"," +  results[6] + " + " + results[7] + "]," + sames.length + " Same " +
					Arrays.toString(sames);
		}
		
		public Integer[] getSameNumber() {
			ArrayList<Integer> list =new ArrayList();
			 if(checkResults(Integer.valueOf(n1))) list.add(Integer.valueOf(n1));
			 if(checkResults(Integer.valueOf(n2))) list.add(Integer.valueOf(n2));
			 if(checkResults(Integer.valueOf(n3))) list.add(Integer.valueOf(n3));
			 if(checkResults(Integer.valueOf(n4))) list.add(Integer.valueOf(n4));
			 if(checkResults(Integer.valueOf(n5))) list.add(Integer.valueOf(n5));
			 if(checkResults(Integer.valueOf(n6))) list.add(Integer.valueOf(n6));
			 
			return  list.toArray(new Integer[0]);
		}
		public boolean checkResults(Integer n) {
			for(int i=1; i<results.length-1; i++) {
				if(results[i] == n) return true;
			}
			return false;
		}

}
