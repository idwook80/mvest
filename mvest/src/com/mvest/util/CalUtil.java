package com.mvest.util;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.regex.Pattern;

public class CalUtil {
	
	public final static String test() {
		test2();
		return null;
	}
	public static void test1() {
		Calendar cal = Calendar.getInstance(Locale.KOREAN);
		Date calDate = cal.getTime();
		System.out.println("year:"+calDate.getYear());
		System.out.println("month:"+calDate.getMonth());
		System.out.println("date:"+calDate.getDate());
		System.out.println("day:"+calDate.getDay());
		System.out.println(getDateFormat(calDate));
		
		Date date = new Date(System.currentTimeMillis());
		System.out.println("year:"+date.getYear());
		System.out.println("month:"+date.getMonth());
		System.out.println("date:"+date.getDate());
		System.out.println("day:"+date.getDay());
		System.out.println(getDateFormat(date));
		
		java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());
		System.out.println("year:"+sqlDate.getYear());
		System.out.println("month:"+sqlDate.getMonth());
		System.out.println("date:"+sqlDate.getDate());
		System.out.println("day:"+sqlDate.getDay());
		System.out.println(getDateFormat(sqlDate));
	}
	public static void test2() {
		String inputDate = "2020-02-22";
		String inputTime = "10:00:00";
		
		Date retDate = new Date(inputDate.replace("-", "/"));
		
		try {
			Date retTime = parseTime(inputTime);
			
			//retDate = parseDate(inputDate);
			GregorianCalendar gc = new GregorianCalendar( );
			gc.setTime(retDate);
			
			System.out.println(getDateFormat(retDate) +" , " + gc.get(Calendar.DAY_OF_WEEK) + " , "+getDay(gc.get(Calendar.DAY_OF_WEEK)));
			int day_of_week = gc.get(Calendar.DAY_OF_WEEK) ;
			
			
			gc.set(Calendar.DATE, 1);
			GregorianCalendar 	first	 	= (GregorianCalendar) gc.clone();
			Date 				firstDate 	= first.getTime();
			gc.add(GregorianCalendar.DAY_OF_MONTH, 32);
			
			gc.set(Calendar.DATE, 1);
			gc.add(GregorianCalendar.DAY_OF_MONTH, -1);
			GregorianCalendar 	last	 	= (GregorianCalendar) gc.clone();
			Date 				lastDate 	= last.getTime();
			
			System.out.println(getDateFormat(firstDate)+" ~ "+getDateFormat(lastDate));
			while(last.getTimeInMillis() >= first.getTimeInMillis()) {
				if(first.get(Calendar.DAY_OF_WEEK) == day_of_week) {
					try {
						System.out.println(getDateFormat(first.getTime()) + " , "+first.get(Calendar.DAY_OF_WEEK));
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
				first.add(GregorianCalendar.DAY_OF_MONTH, 1);
			}
			
			
			gc.setTime(retDate);
			System.out.println("YEAR: " + gc.get(Calendar.YEAR));
			System.out.println("MONTH: " + (gc.get(Calendar.MONTH)));
			System.out.println("WEEK_OF_YEAR: " + gc.get(Calendar.WEEK_OF_YEAR));
			System.out.println("WEEK_OF_MONTH: " + gc.get(Calendar.WEEK_OF_MONTH));
			System.out.println("DATE: " + gc.get(Calendar.DATE));
			System.out.println("DAY_OF_MONTH: " + gc.get(Calendar.DAY_OF_MONTH));
			System.out.println("DAY_OF_YEAR: " + gc.get(Calendar.DAY_OF_YEAR));
			System.out.println("DAY_OF_WEEK: " + gc.get(Calendar.DAY_OF_WEEK) + " , "+getDay(gc.get(Calendar.DAY_OF_WEEK)));
			System.out.println("DAY_OF_WEEK_IN_MONTH: "   + gc.get(Calendar.DAY_OF_WEEK_IN_MONTH));
			                  
			System.out.println("Maximum: " +  gc.getActualMaximum(Calendar.DAY_OF_MONTH));
			System.out.println("Minimum: " +  gc.getActualMinimum(Calendar.DAY_OF_MONTH));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getCurrentTime(String form){
		Calendar today = Calendar.getInstance(Locale.KOREA);
		SimpleDateFormat form1 = new SimpleDateFormat(form);
		return form1.format(today.getTime());
	}
	public static String getDateFormat(String form,long mili){
		Date date = new Date(mili);
		SimpleDateFormat form1 = new SimpleDateFormat(form);
		return form1.format(date.getTime());
	}
	public static String getDateFormat(Date date) {
		return getDateFormat(date,"yyyy-MM-dd");
	}
	public static String getDateFormat(long time, String form) {
		Date date = new Date(time);
		return getDateFormat(date, form);
	}
	public static String getDateFormat(Date date,String form) {
		if(date == null) return "";
		SimpleDateFormat form1 = new SimpleDateFormat(form);
		return form1.format(date.getTime());
	}
	public static String getTimeFormat(String time) throws ParseException{
		return getTimeFormat(parseTime(time));
	}
	public static String getTimeFormat(Date date) {
		return getDateFormat(date,"HH:mm:ss");
	}
	public static String getTime(Date date) {
		return getDateFormat(date,"HH:mm");
	}
	public static String getTimeFormat(Date date,String form) {
		SimpleDateFormat form1 = new SimpleDateFormat(form);
		return form1.format(date.getTime());
	}
	public static Date parseTime(String strTime)  throws ParseException {
		return  parseTime(null,strTime);
	}
	public static Date parseTime(Date date,String strTime)  throws ParseException {
		String dateStr = (date != null ? getDateFormat(date , "yyyy-MM-dd") : "1970-01-01");
		if(strTime.length() <= 5) strTime += ":00";
		long datetime =  parse(dateStr+" "+strTime).getTime()/1000;
		return new Date(datetime*1000);
	}
	public static Date parseDate(String strDate) throws ParseException {
		if(strDate == null  || strDate.trim().length() == 0) return null;
		return parse(strDate + " 00:00:00.000Z");
	}
//	문자열 (날짜)				=> SimpleDateFormat
	//	yyyy-MM-dd HH:mm:ss			=> yyyy-MM-dd HH:mm:ss
	//	yyyy-MM-dd HH:mm:ss.SSS			=> yyyy-MM-dd HH:mm:ss.SSS
	//
	//	yyyy-MM-dd HH:mm:ssZ			=> yyyy-MM-dd HH:mm:ssX
	//	yyyy-MM-dd HH:mm:ss+09			=> yyyy-MM-dd HH:mm:ssX
	//	yyyy-MM-dd HH:mm:ss+0900		=> yyyy-MM-dd HH:mm:ssX
	//	yyyy-MM-dd HH:mm:ss+09:00		=> yyyy-MM-dd HH:mm:ssXXX
	//	yyyy-MM-dd HH:mm:ssKST			=> yyyy-MM-dd HH:mm:ssZ
	//
	//	yyyy-MM-dd HH:mm:ss.SSSZ		=> yyyy-MM-dd HH:mm:ss.SSSX
	//	yyyy-MM-dd HH:mm:ss.SSS+09		=> yyyy-MM-dd HH:mm:ss.SSSX
	//	yyyy-MM-dd HH:mm:ss.SSS+0900	        => yyyy-MM-dd HH:mm:ss.SSSX
	//	yyyy-MM-dd HH:mm:ss.SSS+09:00	        => yyyy-MM-dd HH:mm:ss.SSSXXX
	//	yyyy-MM-dd HH:mm:ss.SSSKST		=> yyyy-MM-dd HH:mm:ss.SSSZ
	//
	//	yyyy-MM-ddTHH:mm:ssZ			=> yyyy-MM-dd'T'HH:mm:ssX
	//	yyyy-MM-ddTHH:mm:ss+09			=> yyyy-MM-dd'T'HH:mm:ssX
	//	yyyy-MM-ddTHH:mm:ss+0900		=> yyyy-MM-dd'T'HH:mm:ssX
	//	yyyy-MM-ddTHH:mm:ss+09:00		=> yyyy-MM-dd'T'HH:mm:ssX
	//	yyyy-MM-ddTHH:mm:ssKST			=> yyyy-MM-dd'T'HH:mm:ssZ
	//
	//	yyyy-MM-ddTHH:mm:ss.SSSZ		=> yyyy-MM-dd'T'HH:mm:ss.SSSX
	//	yyyy-MM-ddTHH:mm:ss.SSS+09		=> yyyy-MM-dd'T'HH:mm:ss.SSSX
	//	yyyy-MM-ddTHH:mm:ss.SSS+0900	        => yyyy-MM-dd'T'HH:mm:ss.SSSX
	//	yyyy-MM-ddTHH:mm:ss.SSS+09:00	        => yyyy-MM-dd'T'HH:mm:ss.SSSXXX
	//	yyyy-MM-ddTHH:mm:ss.SSSKST		=> yyyy-MM-dd'T'HH:mm:ss.SSSZ
	public static Date parse(String strDate) throws ParseException {
		if (strDate == null || strDate.isEmpty()) {
			throw new ParseException("Empty string", 0);
		}

		StringBuilder sdfSb = new StringBuilder("yyyy-MM-dd");

		if (strDate.length() < 19) { // "yyyy-MM-dd HH:mm:ss".length == 19
			throw new ParseException(strDate + " Time is needed.", 11);
		}

		if (strDate.charAt(10) == 'T') {
			sdfSb.append("'T'HH:mm:ss");
		} else if (strDate.charAt(10) == ' ') {
			sdfSb.append(" HH:mm:ss");
		} else {
			throw new ParseException(strDate + " Wrong separator", 10);
		}

		int timezoneIndex;
			// .SSS는 있을 수도 있고 없을 수도 있음, 없는 경우에는 19번째부터 timezone이고 
			// 있는 경우는 23번째부터 timezone
		if (strDate.substring(19).length() >= 4 && Pattern.matches("[.]\\d{3}", strDate.substring(19, 23))) {
			sdfSb.append(".SSS");
			timezoneIndex = 23;
		} else {
			timezoneIndex = 19;
		}

		// Timezone을 요약해보면 Z, +09, +0900은 X로, +09:00은 XXX로, KST는 Z로
		String timezone = strDate.substring(timezoneIndex);
		if (timezone.equals("")) {
			;
		} else if (timezone.equals("Z")) {
			sdfSb.append("X");
		} else if (Pattern.matches("[+|-]\\d{2}", timezone)) {
			sdfSb.append("X");
		} else if (Pattern.matches("[+|-]\\d{4}", timezone)) {
			sdfSb.append("X");
		} else if (Pattern.matches("[+|-]\\d{2}[:]\\d{2}", timezone)) {
			sdfSb.append("XXX");
		} else if (Pattern.matches("[A-Z]{3}", timezone)) {
			sdfSb.append("Z");
		} else {
			throw new ParseException(strDate + " Wrong timezone", timezoneIndex);
		}

		SimpleDateFormat sdf = new SimpleDateFormat(sdfSb.toString());

		return sdf.parse(strDate);
	}
	
	
	public static int getDay(Date date) {
		return date.getDay();
	}
	final static String[] days = new String[] {"SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"};
	public static String getDay(int field) {
		return days[field];
		/**
		switch(field+1) {
		case Calendar.SUNDAY 	: return "SUNDAY";
		case Calendar.MONDAY 	: return "MONDAY";
		case Calendar.TUESDAY 	: return "TUESDAY";
		case Calendar.WEDNESDAY	: return "WEDNESDAY";
		case Calendar.THURSDAY 	: return "THURSDAY";
		case Calendar.FRIDAY	: return "FRIDAY";
		case Calendar.SATURDAY 	: return "SATURDAY";
		}
		**/
	}

	public static GregorianCalendar getFirstDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int first = gc.getActualMinimum(Calendar.DAY_OF_MONTH);
		gc.set(Calendar.DATE, first);
		return gc;
	}
	public static GregorianCalendar getLastDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int last = gc.getActualMaximum(Calendar.DAY_OF_MONTH);
		gc.set(Calendar.DATE, last);
		return gc;
	}
	public static GregorianCalendar getFirstWeekDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int first = gc.getActualMinimum(Calendar.DAY_OF_MONTH);
		gc.set(Calendar.DATE, first);
		int day_of_week = (gc.get(Calendar.DAY_OF_WEEK)-1) * -1;
		gc.add(Calendar.DATE, day_of_week);
		return gc;
	}
	public static GregorianCalendar getLastWeekDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int last = gc.getActualMaximum(Calendar.DAY_OF_MONTH);
		gc.set(Calendar.DATE, last);
		int day_of_week = 7 - gc.get(Calendar.DAY_OF_WEEK);
		gc.add(Calendar.DATE, day_of_week);
		return gc;
	}
	public static Date getFirstDateWeekDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int day_of_week = (gc.get(Calendar.DAY_OF_WEEK)-1) * -1;
		gc.add(Calendar.DATE, day_of_week);
		return gc.getTime();
	}
	public static Date getLastDateWeekDate(Date date) {
		GregorianCalendar gc = new GregorianCalendar( );
		gc.setTime(date);
		int day_of_week = 7 - gc.get(Calendar.DAY_OF_WEEK);
		gc.add(Calendar.DATE, day_of_week);
		return gc.getTime();
	}
	public static void setTime(Date d1, Date d2) {
		d1.setHours(d2.getHours());
		d1.setMinutes(d2.getMinutes());
		d1.setSeconds(d2.getSeconds());
		long datetime = d1.getTime()/1000;
		d1.setTime(datetime*1000);
	}
	public static Date getDate(int year, int month, int day) {
		Date date = new Date();
		date.setYear(year-1900);
		date.setMonth(month-1);
		date.setDate(day);
		return date;
	}
	public static Date getTime(int hours, int minutes, int seconds) {
		Date date = getDate(1970, 0, 1);
		date.setHours(hours);
		date.setMinutes(minutes);
		date.setSeconds(seconds);
		return date;
	}
 
	public static boolean isSameDate(Date d1, Date d2) {
		return d1.getYear() == d2.getYear() && 
				d1.getMonth() == d2.getMonth() &&
				d1.getDate() == d2.getDate();
	}
	
}
