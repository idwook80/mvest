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
		n = orgNum.substring(x, x+1).toLowerCase();
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
function trim0(orgNum){
	var oxNum = false;
	var trim0 = "";
	for(x=0; x<orgNum.length; x++)
	{
		n = orgNum.substring(x, x+1);
		
		if(n!="0" && !oxNum ){
			oxNum = true;
		}
		
		if(oxNum) trim0 += n;
	}
	return trim0;
}
function pad(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}
function comma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function uncomma(x) {
    x = String(x);
    return x.replace(/[^\d]+/g, '');
}
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
function setTime(obj,def){
	 $(obj).datetimepicker({
   	format: 'LT',
   	locale: 'ja',
   	defaultDate: moment().format("YYYY-MM-DD "+def)
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
  	format: 'LLL',
  	locale: 'ja',
  	defaultDate: defDate
  });
}
function setDateTime(obj){
	 $(obj).datetimepicker({
   	format: 'LLL',
   	locale: 'ja',
   	defaultDate: new Date()
   });
}
function setDateTimePicker(obj){
	 $(obj).datetimepicker({
	   	format: 'LLL',
	   	locale: 'ja',
	   	defaultDate: new Date()
	   });
}
function setVisitDatePicker(obj){
	$(obj).datetimepicker({
	   	format: 'YYYY-MM-DD HH:mm',
	   	 locale: 'ja',
	   	stepping: 30,
	    enabledHours: [9, 10, 11, 12, 13, 14, 15],
	   	defaultDate: moment(new Date()).format("YYYY-MM-DD 09:00")
	   });
}
function getTimeFormat(form,datetime){
	return moment(datetime).format(form);
}
function testCommonJs(id){
	alert(id+" test Common");
}
function goForm(form,action){
	$("#"+form).attr("action",action);
	$("#"+form).submit();
}
$('tr[data-href]').on("click", function() {
    document.location = $(this).data('href');
});