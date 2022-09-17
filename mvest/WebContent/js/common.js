function trim(str)
{
	var count = str.length;
	var len = count;
	var st = 0;

	while ((st < len) && (str.charAt(st) <= ' '))
	{
		st++;
	}
	while ((st < len) && (str.charAt(len - 1) <= ' '))
	{
		len--;
	}
	return ((st > 0) || (len < count)) ? str.substring(st, len) : str ;   
}

function isEngNum(orgNum)
{
	var oxEngNum = false;
	for(x=0; x<orgNum.length; x++)
	{
		n = orgNum.substring(x, x+1);
		if(n!="0" && n!="1" && n!="2" && n!="3" && n!="4" && n!="5" && n!="6" && n!="7" && n!="8" && n!="9"
			&& n!="a" && n!="b" && n!="c" && n!="d" && n!="e" && n!="f" && n!="g" && n!="h" && n!="i" && n!="j"
			&& n!="k" && n!="l" && n!="m" && n!="n" && n!="o" && n!="p" && n!="q" && n!="r" && n!="s" && n!="t"
			&& n!="u" && n!="v" && n!="w" && n!="x" && n!="y" && n!="z")
		{
			oxEngNum = true;
			break;
		}
	}
	return oxEngNum;
}

function isEmailChar(orgChar)
{
	var oxEmailChar = false;
	for(x=0; x<orgChar.length; x++)
	{
		n = orgChar.substring(x, x+1);
		if(n!="0" && n!="1" && n!="2" && n!="3" && n!="4" && n!="5" && n!="6" && n!="7" && n!="8" && n!="9"
			&& n!="a" && n!="b" && n!="c" && n!="d" && n!="e" && n!="f" && n!="g" && n!="h" && n!="i" && n!="j"
			&& n!="k" && n!="l" && n!="m" && n!="n" && n!="o" && n!="p" && n!="q" && n!="r" && n!="s" && n!="t"
			&& n!="u" && n!="v" && n!="w" && n!="x" && n!="y" && n!="z" && n!="@" && n!=".")
		{
			oxEmailChar = true;
			break;
		}
	}
	return oxEmailChar;
}

function isNum(orgNum)
{
	var oxNum = true;
	for(x=0; x<orgNum.length; x++)
	{
		n = orgNum.substring(x, x+1);
		if(n!="0" && n!="1" && n!="2" && n!="3" && n!="4" && n!="5" && n!="6" && n!="7" && n!="8" && n!="9")
		{
			oxNum = false;
			break;
		}
	}
	return oxNum;
}



function comma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//공백
function checkSpace(str) { 
	return str.search(/\s/) != -1;
} 
// 특수 문자
function checkSpecial(str) { 
	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;  // 특수문자 
	if(pattern3.test(str)){
		return true;
	} 
	var special_pattern =  /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
	return special_pattern.test(str);
} 

/*
function setDateDefault(obj,defDate){
	 $(obj).datetimepicker({
     	format: 'L', 
     	locale: 'ja',
     	defaultDate: defDate
     });
}

function setDate(obj){
	 $(obj).datetimepicker({
     	format: 'L', 
     	locale: 'ja',
     	defaultDate: new Date()
     });
}
function setTime(obj){
	 $(obj).datetimepicker({
    	format: 'LT',
    	locale: 'ja',
    	defaultDate: moment().format("YYYY-MM-DD 09:00")
    });
}
function setTimeDefault(obj,defTime){
	 $(obj).datetimepicker({
   	format: 'LT',
   	locale: 'ja',
   	defaultDate: moment().format("YYYY-MM-DD "+defTime)
   });
}
function setDateTimeDefault(obj,defDate){
	 $(obj).datetimepicker({
  	format: 'LLLL',
  	locale: 'ja',
  	defaultDate: defDate
  });
}
function setDateTime(obj){
	 $(obj).datetimepicker({
   	format: 'LLLL',
   	locale: 'ja',
   	defaultDate: new Date()
   });
}
$('tr[data-href]').on("click", function() {
    document.location = $(this).data('href');
});

function goForm(form,action){
	$("#"+form).attr("action",action);
	$("#"+form).submit();
}
function getFormData($form){
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function(n, i){
        indexed_array[n['name']] = n['value'];
    });

    return indexed_array;
}*/
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
Date.prototype.yymmdd = function(){
	 	var yyyy 	= this.getFullYear().toString();
	    var mm 	= (this.getMonth() + 1).toString();
	    var dd 	= this.getDate().toString();
	    return  yyyy.substring(2,4) + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
}
Date.prototype.yyyymmdd = function() {
    var yyyy 	= this.getFullYear().toString();
    var mm 	= (this.getMonth() + 1).toString();
    var dd 	= this.getDate().toString();
    return  yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
}
Date.prototype.mmdd = function() {
	var yyyy 	= this.getFullYear().toString();
    var mm 	= (this.getMonth() + 1).toString();
    var dd 	= this.getDate().toString();
    return (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
}
Date.prototype.hhmm = function() {
	var hh = this.getHours().toString();
	var mm = this.getMinutes().toString();
	return (hh[1] ? hh : "0"+hh[0]) + ":" + (mm[1] ? mm : "0"+mm[0]);
}
Date.prototype.yyyymmddhhmm = function(){
	return this.yyyymmdd() + " " + this.hhmm();
}