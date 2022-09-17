package com.mvest.m.lottery.action;

import java.awt.Toolkit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Random;

import com.mvest.m.lottery.Lottery;

public class LotteryWinAnalyze {
	int start = 0;
	int lastGameRound = 0;
	int limit = 20;
	int successCount = 0;
	int totalCount = 0;
	int bestCount = 0;
	int totalWin[] = new int[7];
	int start_idx = 5;
	int end_idx = 30;
	
	ArrayList<Lottery> successList = new ArrayList<Lottery>();
	
	public static void main(String[] args) {
		LotteryWinAnalyze a = 	new LotteryWinAnalyze();
		a.ex1();
	}
	ArrayList wins;
	public LotteryWinAnalyze() {
		//load(20);
		//execute2();
	}
	public void ex1() {
		while(true) {
			try {
				System.out.println("##### GAME START ##");
				
				//if(a.totalCount > 5000 * 10 * 10) break;
				
				if(totalCount >  1 * 1 * 1) break;
				
				if(start >=900 ) start = 1;
				
				analyze(limit);
				executeGame2();
				ArrayList<Integer[]> results = getResults();
				for(int i=0; i<results.size(); i++) {
					Integer[] rr = results.get(i);
					System.out.println(Arrays.toString(rr));
				}
				
				Thread.sleep(10*1);
				start++;
			}catch(Exception e) {
				
			}
		} 
		dbClose();
		
		double ableValue = totalWin[3] * 0.5;
		ableValue += totalWin[4] * 5;
		ableValue += totalWin[5] * 100;
		ableValue += totalWin[6] * 100000;
		
		DecimalFormat df = new DecimalFormat("###,###");
		
		double per =   ((double)successCount / (double)totalCount)*100;
		System.out.println("전체 시도 횟수  : " + totalCount);
		System.out.println("성공 횟수 : " + successCount);
		System.out.println("성공률 : " + String.format("%.2f", per) + "%");
		System.out.println("분석   범위 :  " + limit + " ");
		System.out.println("초기화 범위 : " + start_idx + " ~ " + end_idx);
		System.out.println("5등  : " + totalWin[3]);
		System.out.println("4등 : " + totalWin[4]);
		System.out.println("3등  : " + totalWin[5]);
		System.out.println("1등  : " + totalWin[6]);
		System.out.println("구입   금액  : " +  df.format( totalCount/ 10) + " 만원");
		System.out.println("당첨   금액  : " +  df.format((int)ableValue) + " 만원");
		
		successListPrint();
		
		Toolkit toolkit = Toolkit.getDefaultToolkit();
		for(int i=0; i<3; i++) {
			try {
				Thread.sleep(1500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			toolkit.beep();
		}
	}
	
	public void ex2() {
		load(0);
		 
	}
	public int containsNumber(int[] w1, int[] w2) {
		int count = 0;
		for(int i=1; i<w1.length; i++) {
			for(int j=1; j<w2.length; j++) {
				if(w1[i] == w2[j]) count++;
			}
		}
		return count;
	}
	public int containsNumber(int[] w1, int[] w2, int[] w3) {
		int count = 0;
		
		for(int i=1; i<w1.length; i++) {
			for(int j=1; j<w2.length; j++) {
				if(w1[i] == w2[j]) {
					for(int k=1; k<w3.length; k++) {
						if(w1[i] == w3[k]) return count++;
					}
				}
			}
		}
		return count;
	}
	
	ArrayList<WinInfo>numbers;
	
	
	public void analyze(int limit) {
	   numbers = new ArrayList<WinInfo>();
	   analyzeTotal();
	   analyzeLimit(limit);
	}
	
	Connection conn;
	public void laodDB() throws ClassNotFoundException ,  SQLException {
		if(conn != null) {
			if(conn.isClosed()) {
				conn = null;
			}
		}
		
		if(conn == null) {
			Class.forName("com.mysql.jdbc.Driver");
			
			String url = "jdbc:mysql://localhost:3306/lottery?useUnicode=true&serverTimezone=Asia/Seoul";
		    conn = DriverManager.getConnection(url, "root", "80idwook");
		}
		
	}
	public void dbClose() {
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
			conn = null;
		}
	}
	public void load(int limit) {
		this.limit = limit;
		wins = new ArrayList();
		try {
		/*	Class.forName("com.mysql.jdbc.Driver");
			
			String url = "jdbc:mysql://218.148.204.16:3306/lottery?useUnicode=true&serverTimezone=Asia/Seoul";*/

            // @param  getConnection(url, userName, password);
            // @return Connection
           /* conn = DriverManager.getConnection(url, "idwook80", "80idwook");*/
           // System.out.println("연결 성공");
			laodDB();
            Statement stmt  =  conn.createStatement();
            
            String sql = "SELECT * FROM  lottery.win  ORDER BY round DESC LIMIT "+ start +" , " + limit;
            if(limit == 0 ) sql = "SELECT * FROM  lottery.win  ORDER BY round DESC LIMIT "+ start +" , 2000 ";
            //System.out.println(sql);
            ResultSet rs  = stmt.executeQuery(sql);
            rs.getMetaData();
            
            int last = 0;
            while(rs.next()) {
            	int round = rs.getInt(1);
            	int n1 = rs.getInt("n1");
            	int n2 = rs.getInt("n2");
            	int n3 = rs.getInt("n3");
            	int n4 = rs.getInt("n4");
            	int n5 = rs.getInt("n5");
            	int n6 = rs.getInt("n6");
            	int b1 = rs.getInt("b1");
            	
            	int[] win = new int[] {round,n1,n2,n3,n4,n5,n6,b1};
            	Lottery l = new Lottery(round,n1,n2,n3,n4,n5,n6,b1);
             
            	
            	if(last < round) last = round;
            	//System.out.println(Arrays.toString(win));
            	wins.add(win);
            }
            
            stmt.close();
            int[] lastWin = (int[])wins.get(wins.size()-1);
            lastGameRound =  last;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
		}
	}
	
	public void analyzeTotal() {
		load(0);
		int total = wins.size();
		
		for(int i=0; i<45; i++) {
			String key = String.valueOf(i+1);
			WinInfo info = new WinInfo(key);
			info.setLast_round(this.lastGameRound);
			info.setTotal(total);
			numbers.add(info);
		}
		
		for(int i=0; i<wins.size(); i++) {
			int[] win = (int[])wins.get(i);
			for(int j=0; j<6; j++) {
				
				int idx = win[j+1] -1;
				WinInfo info = numbers.get(idx);
				info.addTotal_count();
				info.setRecently_round(win[0]);
				
			}
		}
	}
	
	ArrayList doubleCheck;
	public void analyzeLimit(int limit) {
		load(limit);
		System.out.println("double check init");
		for(int i=0; i<45; i++) {
			WinInfo info = numbers.get(i);
			info.setLimit(limit);
		}
		
		Hashtable doubleTable = new Hashtable<>();
		for(int i=0; i<2; i++) {
			int[] win = (int[])wins.get(i);
			System.out.println(Arrays.toString(win));
			if(i<2) {
				for(int j=1; j<7; j++) {
					if(doubleTable.containsKey(win[j])){
						int count = (int) doubleTable.get(win[j]);
						doubleTable.put(win[j], ++count);
					}else {
						doubleTable.put(win[j], 1);
					}
					
				}
			}
			
			for(int j=0; j<6; j++) {
				int idx = win[j+1] -1;
				WinInfo info = numbers.get(idx);
				info.addRecently_count();
				info.setRecently_round(win[0]);
			}
			int idx = win[6]-1;
			WinInfo info = numbers.get(idx);
			info.addRecently_count_half();
		}
		
		doubleCheck = new ArrayList();
		Enumeration enu = doubleTable.keys();
		while(enu.hasMoreElements()) {
			int key = (int) enu.nextElement();
			int value = (int) doubleTable.get(key);
			System.out.println(key + "," + value);
			if(value > 1) doubleCheck.add(key);
			
		}
		
		System.out.println(Arrays.toString(doubleCheck.toArray()));
		Collections.sort(numbers);
	}
	public void initNumberBox() {
		    defaultBox = new ArrayList<Integer>();
		    lastDefaultBox    = new ArrayList<Integer>();
		
			ArrayList defaultWins  = (ArrayList<WinInfo>) numbers.clone();
			Collections.reverse(defaultWins);
			
			System.out.println("번호 초기화 중입니다...	");
			for(int i=0; i<defaultWins.size(); i++) {
				System.out.println(defaultWins.get(i));
			}
			
			for(int i=0; i<15; i++) {
				WinInfo info = (WinInfo) defaultWins.get(i);
				defaultBox.add(Integer.parseInt(info.getNo()));
				//System.out.println("ADD : "+info.getNo());
			}
			
			for(int i=0; i<2; i++) {
				int[] win = (int[])wins.get(i);
				System.out.println(Arrays.toString(win));
				for(int j=1; j<7; j++) {
					if(!defaultBox.contains(Integer.valueOf(win[j]))){
						//defaultBox.add(Integer.valueOf(win[j]));
						//System.out.println("ADD : "+win[j]);
						lastDefaultBox.add(Integer.valueOf(win[j]));
					}
				}
			} 
			 for(int i=0; i<doubleCheck.size(); i++) {
				 int value = (int) doubleCheck.get(i);
				 defaultBox.remove(Integer.valueOf(value));
			 }
			 
		 System.out.println("번호 초기화 되었습니다...	");
	}
	public void initNumberBox2() {
		
		ArrayList defaultWins  = (ArrayList<WinInfo>) numbers.clone();
		Collections.reverse(defaultWins);
		
		System.out.println("번호 초기화 중입니다...	");
		for(int i=0; i<defaultWins.size(); i++) {
			System.out.println(defaultWins.get(i));
		}
		
		defaultBox = new ArrayList<Integer>();
		
		Random rd = new Random();
		for(int i=start_idx; i<end_idx; i++) {
			WinInfo info = (WinInfo) defaultWins.get(i);
			if(info.getRecently_count() < (int)(info.getLimit()/4)) {
				defaultBox.add(Integer.parseInt(info.getNo()));
				// System.out.println("ADD : "+info.getNo());
			}
		}
		
		 int half = (start_idx/2);
		// int ppre =   rd.nextInt(half);
		// int pre = rd.nextInt(start_idx - half) + half;
		 int pre = rd.nextInt(start_idx) ;
		 int next = rd.nextInt(defaultWins.size() - end_idx ) + end_idx;
		 
		/* WinInfo info = (WinInfo) defaultWins.get(ppre);
		 defaultBox.add(Integer.parseInt(info.getNo()));*/
		 
		 WinInfo info   = (WinInfo) defaultWins.get(pre);
		 defaultBox.add(Integer.parseInt(info.getNo()));
		 //System.out.println("PRE : "+info.getNo());
		 
		 info = (WinInfo) defaultWins.get(next);
		 defaultBox.add(Integer.parseInt(info.getNo()));
		 //System.out.println("NEXT : "+info.getNo());
		 
		 for(int i=0; i<doubleCheck.size(); i++) {
			 int value = (int) doubleCheck.get(i);
			 defaultBox.remove(Integer.valueOf(value));
		 }
		 
		 System.out.println("번호 초기화 되었습니다...	");
	}
	public Integer removeNumberBox(int idx) {
		Integer value  = (Integer) numberBox.remove(idx);
		int size = numberBox.size();
		for(int i=size-1; i>=0; i--) {
			Integer check = (Integer)numberBox.get(i);
			if(check == value) numberBox.remove(i);
		}
		return value;
	}
	
	public void addNumberBox(int value) {
		numberBox.remove(Integer.valueOf(value));
		numberBox.add(value);
	}
	
	public ArrayList<Integer[]> getResults(){
		return results;
	}
	
	ArrayList<Integer[]> results = null;
	public void executeGame2() {
		ArrayList defaultWins  = (ArrayList<WinInfo>) numbers.clone();
		Integer[] nextWin = nextGameWin(lastGameRound+1);
		
		System.out.println("NEXT : " + Arrays.toString(nextWin));
		Random rd = new Random();
		int good = 0;
		int gameCount = 5;
		int winCount[] = new int[7];
		
		results = new ArrayList<Integer[]>();
		
		
		initNumberBox();
		Collections.sort(defaultBox);
		System.out.println("ROUND : "+lastGameRound+ ", Next" + (lastGameRound+1));
		System.out.println("defaultWins " + defaultBox.size() + ": "+ Arrays.toString(defaultBox.toArray()));
		for(int i=0; i<defaultBox.size(); i++) {
			//System.out.println(defaultBox.get(i));
		}
		
		ArrayList lastBox;
		for(int r=0; r<gameCount; r++) {
			  numberBox = (ArrayList<Integer>) defaultBox.clone();
			  lastBox   = (ArrayList<Integer>) lastDefaultBox.clone();
			  
			//System.out.println("defaultBox " +defaultBox.size()+ ": "+ Arrays.toString(defaultBox.toArray()));
			//System.out.println("lastBox " +numberBox.size()+ ": "+ Arrays.toString(lastBox.toArray()));
			
			
			 /*if(r > 1) {
				 for(int j=0; j<2; j++) {
					 Integer[] win = (Integer[]) results.get(j);
					 for(int k=0; k<win.length; k++) {
						 numberBox.remove(win[k]);
					 }
				 }
			 }*/
			
			Integer[] result = new Integer[6];
			//System.out.println("Round :"+(r+1)+" Result : "+ Arrays.toString(numberBox.toArray()));
			for(int i=0; i<2; i++) {
				Integer value;
				value  = (Integer) lastBox.remove(rd.nextInt(lastBox.size()));
				result[i] = value;
				//System.out.println(value);
				
			}
			for(int i=2; i<result.length; i++) {
				Integer value;
				if(i == 0 )   value = (Integer) removeNumberBox(rd.nextInt(5));
				else value = (Integer) removeNumberBox(rd.nextInt(numberBox.size()));
				result[i] = value;
				Collections.shuffle(numberBox);
				
			}
			sort(result);
			//System.out.println("numberBox " +numberBox.size()+ ": "+ Arrays.toString(numberBox.toArray()));
			//System.out.println("Round :"+(r+1)+" Result : "+ Arrays.toString(result));
			if(result[0] > 13 || result[3] < 10) {
				r = r-1;
			}else {
				results.add(result);
				if(nextWin != null) {
					int sameCount = sameCount(nextWin, result);
					winCount[sameCount]++;
					totalWin[sameCount]++;
					if(sameCount > 2) {
						successCount++;
						System.out.println("Round :"+(r+1)+" Result : "+ Arrays.toString(result) + " " + sameCount);
						if(bestCount < sameCount )  bestCount = sameCount;
						good++;
						if(sameCount >= 5) {
							try {
								Thread.sleep(1000*3);
								Lottery ss = new Lottery(result);
								ss.setRound(""+nextWin[0]);
								ss.setResults(nextWin);
								successList.add(ss);
							}catch(Exception e) {}
						}else {
							try {
								Thread.sleep(10*1);
							}catch(Exception e) {}
						}
					}
				
				}
			}
			totalCount++;
		}
		
		
		for(int i=0; i<winCount.length; i++) {
			System.out.print("( "+i + " : "+winCount[i] + "), ");
		}
		
		System.out.println();
		
		for(int i=0; i<totalWin.length; i++) {
			System.out.print("( "+i + " : "+totalWin[i] + "), ");
		}
		
		System.out.println();
		
		System.out.println("Game Done! + ( "+good + " / "+ gameCount + ") , total success : " + successCount + " / " + totalCount + " BEST : " + bestCount);
		System.out.println();
		
	}
	
	public int sameCount(Integer[] win, Integer[] b) {
		int count = 0;
		for(int i=1; i<win.length-1; i++) {
			for(int j=0; j<b.length; j++) {
				if(win[i] == b[j]) count++;
			}
		}
		return count;
	}
	
	
	ArrayList defaultBox;
	ArrayList lastDefaultBox;
	ArrayList numberBox;
	
	 
	
	public void sort(Integer[] data) {
		int j=0;
		for(int i=1; i<data.length; i++) {
			int tmp = data[i];
			for(j=i-1; j>=0 && tmp < data[j]; j--) {
				data[j+1] = data[j];
			}
			data[j+1] = tmp;
		}
	}
	public Integer[] nextGameWin(int r) {
	    Integer[] win = null;
		try {
			laodDB();
            Statement stmt  =  conn.createStatement();
            
            String sql = "SELECT * FROM  lottery.win where round = "+r;
            System.out.println(sql);
            ResultSet rs  = stmt.executeQuery(sql);
            rs.getMetaData();
            
            int last = 0;
            if(rs.next()) {
            	int round = rs.getInt(1);
            	int n1 = rs.getInt("n1");
            	int n2 = rs.getInt("n2");
            	int n3 = rs.getInt("n3");
            	int n4 = rs.getInt("n4");
            	int n5 = rs.getInt("n5");
            	int n6 = rs.getInt("n6");
            	int b1 = rs.getInt("b1");
            	
            	 win = new Integer[] {round,n1,n2,n3,n4,n5,n6,b1};
            	
            	System.out.println(Arrays.toString(win));
            }
            
            stmt.close();
           
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		}
		
	     return win;
	}
	
	public void successListPrint() {
		for(int i=0; i<successList.size(); i++) {
			Lottery lo= successList.get(i);
			System.out.println(lo.toStringResults());
		}
	}
}
