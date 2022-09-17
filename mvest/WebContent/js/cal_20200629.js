// 캘린더 객체
var calendar = {
	LEAF : [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ], //윤년
	PLAIN : [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ], //평년
	iscLeafCheck :
	//윤년 판단
	function(year) {
		var isc = false;
		if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) { // 윤년이면
			isc = true;
		}
		return isc;
	},
	daysY :
	//년도에 따른 일수 누적
	function(year) {
		var daySum = 0;
		for (var i = 1; i < year; i++) {
			if (this.iscLeafCheck(i)) {
				daySum += 366;
			} else {
				daySum += 365;
			}
		}
		return daySum;
	},
	daysM :
	//년도누적 + 월 일수 누적
	function(year, month) {
		var daySum = this.daysY(year);
		for (var i = 1; i < month; i++) {
			daySum += this.PLAIN[i - 1];
		}
		if (month >= 2 && this.iscLeafCheck(year)) {
			daySum++;
		}
		return daySum;
	},
	daysD :
	//년도누적 + 월 누적 + 일수 누적
	function(year, month, day) {
		return this.daysM(year, month) + day;
	},
	lastDay :
	// 구하고자 하는 년월의 최대 일수
	function(year, month) {
		var last_day = 0;
		if (this.iscLeafCheck(year)) {
			last_day = this.LEAF[month - 1];
		} else {
			last_day = this.PLAIN[month - 1];
		}
		return last_day;
	},
	isBeforeDays :
	// 앞의 달에 년도 분기
	function(year, month) {
		var days = 0;
		if (month == 1) {
			days = this.lastDay(year - 1, 12);
		} else {
			days = this.lastDay(year, month - 1);
		}
		return days;
	},
	make :
	// 해당달력을 배열로 반환
	function(year, month) {
		var date = new Date(year,month-1,1);
		
		var beforeYear 	= month-1 == 0 ? year-1 : year;
		var beforeMonth = month-1 == 0 ? 12 : month-1;
		
		var nextYear   = month+1 == 13 ? year+1 : year;
		var nextMonth  = month+1 == 13 ? 1 : month+1;
		
		 var last 		= this.lastDay(year, month);
		 var beforeLast = this.lastDay(beforeYear, beforeMonth);
		 var nextLast	= this.lastDay(nextYear, nextMonth);
		 
		 var dayOfWeek = date.getDay();
		 var pastDay   = dayOfWeek;
		 
		 var dayArray = new Array();
		/* console.log(beforeLast+","+dayOfWeek + ", " + (beforeLast- dayOfWeek));*/
		 
		 var startDay = beforeLast - dayOfWeek +1;
		 
		 var cnt = 0;
		
		 for (var i=startDay; i<beforeLast+1; i++){
			 dayArray[cnt] =  new Date(beforeYear, beforeMonth-1, i);
			 cnt++;
		 }
		 for (var i=0; i<last; i++){
			 dayArray[cnt++] =  new Date(year, month-1, (i+1)); 
		 }
		 for (var i=1; i<nextLast; i++){
			 dayArray[cnt++] = new Date(nextYear, nextMonth-1, i);
			 if(cnt >= 42) break;
		 }
		 console.log(dayArray[0]);
		 return dayArray;
	},
	makeOne :
	// 달력 한개만
	function(year, month){
		var last_day = this.lastDay(year, month); // 구하고자 하는 년월의 최대 일수
		var dayArray = new Array();
		var cnt = 0;
		for (var i = 1; i <= last_day; i++, cnt++) {
			dayArray[cnt] = i;
		}
		return dayArray;
	},
	makeWeek :
	function(year, month, date){
		var select = new Date(year,month-1,date);
		var monthly = this.make(year, month);
		var start_idx = 0;
		for(var i=0; i<monthly.length; i++)	{
			start_idx = parseInt(i/7);
			if(monthly[i].getTime() >= select.getTime()) break;
		}
		start_idx = start_idx*7;
		var cnt = 0;
		var weekly = new Array();
		for(var i=start_idx; i<start_idx+7; i++){
			weekly[cnt++] = new Date(monthly[i].getTime());
		}
		return weekly;
	}
}

var stringBuffer;
var StringBuffer = function() {
	this.stringBuffer = new Array();
}

StringBuffer.prototype.append = function(obj) {
     this.stringBuffer.push(obj);
}

StringBuffer.prototype.toString = function(){
     return this.stringBuffer.join("");
}
