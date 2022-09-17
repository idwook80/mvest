package com.mvest.log4j;

import java.io.IOException;
import java.util.ArrayDeque;
import java.util.Deque;


import org.apache.log4j.Level;
import org.apache.log4j.spi.LoggingEvent;

import com.mvest.util.TimeUtil;

public class Log4Manager {
	public static boolean DEBUG = false;
	Deque<LoggingEvent> que 			= new ArrayDeque<>();
	public static  int MAX_SIZE			= 1000;
	
	public static Log4Manager instance;
	
	public static Log4Manager getInstance(){
		if(instance == null){
			synchronized(Log4Manager.class){
				instance = new Log4Manager();
			}
		}
		return instance;
	}
	public static Log4Appender 	appender;
	public static Log4Socket 	socket;
	public Log4Manager(){
		if(appender == null) {
			appender = new Log4Appender();
			org.apache.log4j.LogManager.getRootLogger().addAppender(appender);
		}
		if(socket == null){
			socket = new Log4Socket();
		}
		
	}
	public void doAppend(LoggingEvent event){
		synchronized(que){
			String msg = toString(event);
			if(DEBUG) {
				que.push(event);
				System.out.println(msg);
			}
			try {
				if(socket != null) socket.onMessageAll(msg);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(que.size() > MAX_SIZE){
				while(que.size() < MAX_SIZE) que.pop();
			}
		}
		
	}
	public void clear(){
		synchronized(que){
			while(que.isEmpty()){
				que.pop();
			}
		}
	}
	public LoggingEvent[] getLogs(){
		LoggingEvent[] ret = null;
		synchronized(que){
			 ret =  que.toArray(new LoggingEvent[0]);
		}
		clear();
		return ret;
	}
	public String toString(LoggingEvent event){
		Object message 	= event.getMessage();
		Level level 	= event.getLevel();
		Long startTime 	= event.getStartTime();
		String info 	= event.getLocationInformation().fullInfo;
		
		return  "["+level.toString()+"]["+TimeUtil.getDateFormat("yyyy-MM-dd HH:mm:ss.SSS", System.currentTimeMillis())+"] "
				/*+info*/+"- "+message;
	}
}	
