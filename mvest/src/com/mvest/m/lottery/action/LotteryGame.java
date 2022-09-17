package com.mvest.m.lottery.action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class LotteryGame {
	int lastGameRound = 0;
	
	ArrayList wins;
	public LotteryGame() {
		load();
		ready();
		find();
		setDefault();
		
	}
	public void execute() {
		Integer[] win1 = executeGameNumbers();
		Integer[] win2 = executeGameNumbers();
		Integer[] win3 = executeGameNumbers();
		
		
		Integer[] win4 = executeGameDefault();
		Integer[] win5 = executeGameDefault();
		
		/**
		
		System.out.println("############################################################################");
		System.out.println("#######################       Auto Game Result    ##########################");
		int[] last =  (int[]) wins.get(wins.size()-1);
		
		System.out.println("Game  = " + Arrays.toString((int[]) wins.get(wins.size()-2)));
		System.out.println("Last  = " + Arrays.toString((int[]) wins.get(wins.size()-1)));
		System.out.println("Next Max Numbers : " + defaultBox.size() + " , "+ Arrays.toString(defaultBox.toArray()));
		System.out.println("Check Out Numbers : " + checkedNumbers.size() + " , "+ Arrays.toString(checkedNumbers.toArray()));
		
		System.out.println(Arrays.toString(win1));
		System.out.println(Arrays.toString(win2));
		System.out.println(Arrays.toString(win3));
		
		System.out.println(Arrays.toString(win4));
		System.out.println(Arrays.toString(win5));
		System.out.println("############################################################################");
		**/
		
		
	}
	public void load() {
		
		wins = new ArrayList();
		
		Connection conn;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			
			String url = "jdbc:mysql://218.148.204.16:3306/lottery?useUnicode=true&serverTimezone=Asia/Seoul";

            // @param  getConnection(url, userName, password);
            // @return Connection
            conn = DriverManager.getConnection(url, "idwook80", "80idwook");
            System.out.println("연결 성공");
            Statement stmt  =  conn.createStatement();
            
            String sql = "SELECT * FROM  lottery.win";
            ResultSet rs  = stmt.executeQuery(sql);
            rs.getMetaData();
            
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
            	
            	//System.out.println(Arrays.toString(win));
            	wins.add(win);
            }
            
            stmt.close();
            conn.close();
            int[] lastWin = (int[])wins.get(wins.size()-1);
            lastGameRound =  lastWin[0];
            
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	ArrayList numbers;
	ArrayList sames;
	
	public void ready() {
		numbers = new ArrayList();
		sames = new ArrayList();
		for(int i=0; i<45; i++) {
			numbers.add(new int[45]);
			sames.add(new int[45]);
		}
		
		
		int[] pre = null;
		int[] next = null;
		for(int i=0; i<wins.size(); i++) {
			
			int[] win = (int[]) wins.get(i);
			
			if(pre != null) {
				addNumberCount(pre[1],win);
				addNumberCount(pre[2],win);
				addNumberCount(pre[3],win);
				addNumberCount(pre[4],win);
				addNumberCount(pre[5],win);
				addNumberCount(pre[6],win);
			}
			
			if(i  == 0) pre = new int[win.length];
			System.arraycopy(win, 0, pre, 0, win.length);
			addSamesNumbers(win);
			
		}
		
		/**
		System.out.print("NO  [");
		for(int i=0; i<45; i++) {
			System.out.print(" "+(i+1) + ",");
		}
		System.out.println("] ");
		for(int i=0; i<sames.size(); i++) {
			System.out.println((i+1) + " = " + Arrays.toString((int[])sames.get(i)));
		}
		**/
		for(int i=0; i<sames.size(); i++) {
			findSame(i+1);
		}
	}
	public void addSamesNumbers(int[] w) {
		addSamesNumbers(w[1],w);
		addSamesNumbers(w[2],w);
		addSamesNumbers(w[3],w);
		addSamesNumbers(w[4],w);
		addSamesNumbers(w[5],w);
		addSamesNumbers(w[6],w);
	}
	public void addSamesNumbers(int idx,int[] w) {
		int[] no = (int[]) sames.get(idx - 1);
		for(int i=1; i<7; i++) {
			if(idx != w[i]) no[w[i] -1]++;
		}
		
	}
	public void addNumberCount(int n, int[] win) {
		int[] no =    (int[]) numbers.get(n - 1);
		
		no[win[1]-1]++;
		no[win[2]-1]++;
		no[win[3]-1]++;
		no[win[4]-1]++;
		no[win[5]-1]++;
		no[win[6]-1]++;
		
		
		numbers.set(n-1, no);
	}
	
	public void find() {
		
		System.out.print("NO  [");
		for(int i=0; i<45; i++) {
			System.out.print(" "+(i+1) + ",");
		}
		System.out.println("] ");
		
		for(int i=0; i<numbers.size(); i++) {
			findNext(i+1);
		}
	}
	
	public ArrayList findNext(int n) {
		int[] next = (int[]) numbers.get(n-1);
		int maxCount = 0;
		int maxNum = 0;
		ArrayList maxArr = new ArrayList();
		for(int j=0; j<next.length; j++) {
			if(maxCount < next[j]) {
				maxCount = next[j];
				maxNum = j+1;
			}
		}
		for(int j=0; j<next.length; j++) {
			if(maxCount == next[j]) {
				maxArr.add(j+1);
			}
		}
		//System.out.println((n) + " = Max(" +maxCount+")," + Arrays.toString(maxArr.toArray()) + "  --> " + Arrays.toString((int[])numbers.get(n-1))  );
		return maxArr;
	}
	
	public ArrayList findSame(int n) {
		int[] same = (int[]) sames.get(n-1);
		int sameCount = 0;
		int sameNum = 0;
		ArrayList sameArr = new ArrayList();
		for(int j=0; j<same.length; j++) {
			if(sameCount < same[j]) {
				sameCount = same[j];
				sameNum = j+1;
			}
		}
		for(int j=0; j<same.length; j++) {
			if(sameCount == same[j]) {
				sameArr.add(j+1);
			}
		}
		//System.out.println((n) + " = Same(" +sameCount+")," + Arrays.toString(sameArr.toArray()) + "  --> " + Arrays.toString((int[])sames.get(n-1))  );
		return sameArr;
	}
	
	
	ArrayList defaultBox;
	ArrayList numberBox;
	ArrayList doubleCheck;
	ArrayList checkedNumbers;
	
	public void setDefault() {
		numberBox = new ArrayList();
		defaultBox = new ArrayList();
		doubleCheck = new ArrayList();
		checkedNumbers = new ArrayList();
		
		
		setDoubleCheck(lastGameRound);
		setDoubleCheck(lastGameRound-1);
		
		addDefaultBoxFromGame(lastGameRound);
		addDefaultBoxFromGame(lastGameRound-1);
		
		
		//System.out.println("DEFAULT : "+ Arrays.toString(defaultBox.toArray()));
		//System.out.println("DOUBLE  : "+ Arrays.toString(checkedNumbers.toArray()));
		
		
		initNumberBox();
		
		//System.out.println(numberBox.size() + " , " + Arrays.toString(numberBox.toArray()));
	}
	
	public void setDoubleCheck(int game) {
		int[] g =   (int[]) wins.get(game-1);
		containsDoubleCheck(g[1]);
		containsDoubleCheck(g[2]);
		containsDoubleCheck(g[3]);
		containsDoubleCheck(g[4]);
		containsDoubleCheck(g[5]);
		containsDoubleCheck(g[6]);
	}
	public void containsDoubleCheck(int n) {
		if(doubleCheck.contains(Integer.valueOf(n))) {
			checkedNumbers.add(Integer.valueOf(n));
		}else {
			doubleCheck.add(Integer.valueOf(n));
		}
		Collections.sort(defaultBox);
		Collections.sort(checkedNumbers);
	}
	
	
	public void removeWinGame(int round) {
		for(int i=0; i<wins.size(); i++) {
			int[] win = (int[]) wins.get(i);
			if(round == win[0]) {
				removeNumber(win[1],win[2],win[3],win[4],win[5],win[6]);
			}
			
		}
	}
	
	public void addDefaultBoxFromGame(int game) {
		int[] g =   (int[]) wins.get(game-1);
		
		addDefaultBox(findNext(g[1]));
		addDefaultBox(findNext(g[2]));
		addDefaultBox(findNext(g[3]));
		addDefaultBox(findNext(g[4]));
		addDefaultBox(findNext(g[5]));
		addDefaultBox(findNext(g[6]));
	}
	public void addDefaultBox(ArrayList arr) {
		for(int i=0; i<arr.size(); i++) {
			int n = (Integer) arr.get(i);
			addDefaultBox(n);
		}
	}
	public void addDefaultBox(int n) {
		if(!defaultBox.contains(Integer.valueOf(n))) {
			defaultBox.add(Integer.valueOf(n));
		}
		Collections.sort(defaultBox);
	}
	public void removeDefaultBox(int n) {
		if(defaultBox.contains(Integer.valueOf(n))) {
			defaultBox.remove(Integer.valueOf(n));
		}
	}
	
	public void initOnlyDefault() {
		numberBox = new ArrayList();
		addNumber((Integer[]) defaultBox.toArray(new Integer[0]));
		
		removeNumber((Integer[]) checkedNumbers.toArray(new Integer[0]));
	}
	public void initNumberBox() {
		numberBox = new ArrayList();
		
		for(int i=0; i<45; i++) {
				numberBox.add(Integer.valueOf(i+1));
		}

		removeWinGame(lastGameRound);
		removeWinGame(lastGameRound-1);
		removeWinGame(lastGameRound-2);
		
		addNumber((Integer[]) defaultBox.toArray(new Integer[0]));
		removeNumber((Integer[]) checkedNumbers.toArray(new Integer[0]));
		
	}
	public void addNumber(Integer... arg) {
		for(int i=0; i<arg.length; i++) {
			if(!numberBox.contains(Integer.valueOf(arg[i]))) {
				numberBox.add(Integer.valueOf(arg[i]));
			}
		}
		Collections.sort(numberBox);
	}
	public void removeNumber(Integer... arg) {
		for(int i=0; i<arg.length; i++) {
			if(numberBox.contains(Integer.valueOf(arg[i]))) {
				numberBox.remove(Integer.valueOf(arg[i]));
			}
		}
	}
	
	public Integer[] executeGameDefault() {
		//System.out.println("auto lottery system numbers default ");
		initOnlyDefault();
		return executeGame();
	}
	public Integer[] executeGameNumbers() {
		//System.out.println("auto lottery system numbers numbers");
		initNumberBox();
		return executeGame();
	}
	
	public Integer[] executeGame() {
		//System.out.println(numberBox.size() + " "  + Arrays.toString(numberBox.toArray()));
		
		Integer[] values = new Integer[6];
		Random rd = new Random();
		for(int i=0; i<values.length; i++) {
			Integer value = (Integer) numberBox.get(rd.nextInt(numberBox.size()));
			values[i] = value;
			removeNumber(value);
			
			ArrayList nextSames = findSame(value);
			boolean isSelected = false;
			for(Object s : nextSames.toArray()) {
				for(int j=0; j<i; j++) {
					isSelected = values[j] == Integer.valueOf(s.toString());
					if(isSelected) break;
				}
				if(isSelected) break;
			}
			if(!isSelected) {
				addNumber((Integer[]) nextSames.toArray(new Integer[0]));
			}
			
		}
		sort(values);
		//System.out.println(numberBox.size() + " "  + Arrays.toString(numberBox.toArray()));
		//System.out.println("Result : "+ Arrays.toString(values));
	
		 
		if(values[0] > 13) {
			int n = (Integer) numberBox.get(0);
			if(n > 13) return values;
			else {
				addNumber(values);
				return executeGame();
			}
			
		}
		return values;
	}
	
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
}
