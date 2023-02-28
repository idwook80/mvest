<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.mvest.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>로또6/45 구매번호 확인 &lt; 구매/당첨 &lt; 마이페이지 | 동행복권</title>



<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/images/common/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/common/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/common.js" charset="utf-8"></script>
<script type="text/javascript">

fn_g_init_message("");

var gameUserId = "";

function goGame(){
	var userId = "idwook80";
	
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login";
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert('접속이 원활하지 않습니다.'); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp("");
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function goGame(lottoId,agreeType){
	var userId = "idwook80";
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + lottoId);
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp(lottoId,agreeType);
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function goGamePnInfo(lottoId,agreeType,svcInfoPnPcMsgYn){
	var svcInfoPnPcMsgYn = svcInfoPnPcMsgYn;

	if (svcInfoPnPcMsgYn == "Y") {
		svcInfoPnMsg();
		return;
	}
	
	var userId = "idwook80";
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + lottoId);
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",  	// url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp(lottoId,agreeType);
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function goGameElInfo(lottoId,agreeType,svcInfoElPcMsgYn){
	var lottoId = lottoId;
	var svcInfoElPcMsgYn = svcInfoElPcMsgYn;

	/*
	if (svcInfoElPcMsgYn == "Y") {
		svcInfoElMsg();
		return;
	}
	*/

	/*
	if (svcInfoElPcMsgYn == "Y") {
		svcInfoElTrMsg();
		return;
	}
	*/
	
	if (svcInfoElPcMsgYn == "Y") {
		if (lottoId == "LI21") {
			svcInfoElTrMsg();
			return;
		} else {
			svcInfoElMsg();
			return;
		}
	}

	var userId = "idwook80";
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + lottoId);
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",  	// url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp(lottoId,agreeType);
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function goGameEnInfo(lottoId,agreeType,endInfoElPcMsgYn){
	var endInfoElPcMsgYn = endInfoElPcMsgYn;

	if (endInfoElPcMsgYn == "Y") {
		endInfoElMsg();
		return;
	}
	
	var userId = "idwook80";
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + lottoId);
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",  	// url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp(lottoId,agreeType);
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function goGameElEnInfo(lottoId,agreeType,svcInfoElPcMsgYn,endInfoElPcMsgYn){
	var svcInfoElPcMsgYn = svcInfoElPcMsgYn;
	var endInfoElPcMsgYn = endInfoElPcMsgYn;

	if (svcInfoElPcMsgYn == "Y") {
		svcInfoElMsg();
		return;
	}
	
	if (endInfoElPcMsgYn == "Y") {
		endInfoElMsg();
		return;
	}
	
	var userId = "idwook80";
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + lottoId);
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",  	// url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		timeout:3000,
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			
			if(userId == data.userId && data.userId != ""){
				doGamePopUp(lottoId,agreeType);
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});		
}

function doGamePopUp(lotid,agreeType){
	/*
	* 스피드키노 LD10, 메가빙고 LD11, 더블잭마이더스 LD20, 파워볼 LD14, 트레져헌터 LI22, 트리플럭 LI21 -> gamePop
	* 캐치미 LI23 -> catchPop
	*/
	var type;
	
	if( lotid === 'LI23' ){
		type = 'catchPop';
	}else{
		type = 'gamePop';
	}
		
	if($("#agreeChk").is(":checked") || agreeType == 2){
		var new_popup = centerPop('https://el.dhlottery.co.kr/game/TotalGame.jsp?LottoId='+ lotid, 'type', 1164, 645, 'no');
	}else{
		alert('약관에 동의해 주셔야 이용이 가능합니다.');
		$("#agreeChk").focus();
	}
	
}

//설문조사 팝업
function popCenter(url){
	var new_popup =	centerPop(url, '설문조사', 480, 800, 'yes');
}

//샘플게임 팝업
function sample_pop(code, userId){
	
	//location.href = "/gamezone.do?method=gameZoneMainView";
	//return;
	if(userId == null || userId == ""){
		alert("로그인 후 이용이 가능합니다.");
		//location.href = "/user.do?method=login";
		//location.href = "/user.do?method=login&returnUrl=/gamezone.do?method=gameZoneMainView";
		location.href = "/user.do?method=login&returnUrl=" + encodeURIComponent('/gameInfo.do?method=lottoMainView&lottoId=' + code);
		return;
	}
	if(!$("#sampleAgreeChk").is(":checked")){
		alert('약관에 동의해 주셔야 이용이 가능합니다.');
		$("#sampleAgreeChk").focus();
		return;
	}
	
	$.ajax({
		type:"POST",                            // 메소드타입
		url:"/gamezone.do?method=autoAgreeProc",// url
		dataType:"json",                        // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		async:false,
		contentType : "application/json; charset=EUC-KR",
		error: function() {                     // 에러날경우 콜백함수
			console.log("error");
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(data.successYn){
				console.log(data);
			}
		}
	});
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		//data:{"jackpot":strJackpotData},   	// 파라메터 타입
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(userId == data.userId && data.userId != ""){
				var new_popup =	centerPop('https://el.dhlottery.co.kr/game_sample/TotalGame.jsp?LottoId=' + code, 'gamePop', 1164, 645, 'no');
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});
}

//샘플게임(랜덤) 팝업
function sample_random_pop(userId){
	
	//location.href = "/gamezone.do?method=gameZoneMainView";
	//return;
	if(userId == null || userId == ""){
		alert("로그인 후 이용이 가능합니다.");
		location.href = "/user.do?method=login";
// 		location.href = "/user.do?method=login&returnUrl=/gamezone.do?method=gameZoneMainView";
// 		location.href = "/common.do?method=main";
		return;
	}
	
	var x = Math.floor((Math.random() * 7) + 1 );
	
	if(x == 1){
		var code = "LD14";
	}else if(x == 2){
		var code = "LD10";
	}else if(x == 3){
		var code = "LD20";
	}else if(x == 4){
		var code = "LI23";
	}else if(x == 5){
		var code = "LI22";
	}else if(x == 6){
		var code = "LI21";
	}else if(x == 7){
		var code = "LD11";
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"/gamezone.do?method=autoAgreeProc",// url
		dataType:"json",                        // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		async:false,
		contentType : "application/json; charset=EUC-KR",
		error: function() {                     // 에러날경우 콜백함수
			console.log("error");
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(data.successYn){
				console.log(data);
			}
		}
	});
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		//data:{"jackpot":strJackpotData},   	// 파라메터 타입
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(userId == data.userId && data.userId != ""){
				var new_popup =	centerPop('https://el.dhlottery.co.kr/game_sample/TotalGame.jsp?LottoId=' + code , 'gamePop', 1164, 645, 'no');
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});
}



function doReserve(){	
	var userId = "idwook80";
	
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		//location.href = "/user.do?method=login";
		location.href = "/user.do?method=login&returnUrl=/gameInfo.do?method=game720Method";
		return;
	}
	
	$.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(userId == data.userId && data.userId != ""){
					window.open('https://el.dhlottery.co.kr/lotto720.do?method=reserveBuy', 'pensionPop' , 'width=930, height=672, left=0, top=0, status=no, toolbar=no, menubar=no, location=no');				
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});
				
}


function jackpotViewPop(){
	var url = "/gameInfo.do?method=jackpotView&lottoId=";	
	commonPop("", url, 820, 700, 'yes');
}

function goLottoBuy(agreeType){
	var userId = "idwook80";
	
	if(userId == '' || userId == null){
		alert("로그인 후 사용 해주시기 바랍니다.");
		//location.href = "/user.do?method=login";
		location.href = "/user.do?method=login&returnUrl=/gameInfo.do?method=buyLotto";
		return;
	}
	if(agreeType == 1 && !$("#agreeChk").is(":checked")){
		alert('약관에 동의해 주셔야 이용이 가능합니다.');
		$("#agreeChk").focus();
		return;
	}
	
	
	 $.ajax({
		type:"get",                             // 메소드타입
		url:"https://el.dhlottery.co.kr/portal_login.jsp",    // url
		dataType:"jsonp",                       // 이부분이 중요 데이타타입을 jsonP로 해줘야 크로스도메인을 이용할수 있다.
		timeout:3000,
		jsonp : 'callback',                     // 콜백함수 이름 명이다. 
		error: function() {                     // 에러날경우 콜백함수
			alert("시스템이 원활하지 않습니다.\n이용에 불편을 드려 죄송합니다."); 
		}, 
		success: function(data){        		// 성공했을때 콜백함수
			if(userId == data.userId && data.userId != ""){
				var new_popup = centerPop('https://el.dhlottery.co.kr/game/TotalGame.jsp?LottoId=LO40', 'gamePop', 1164, 645, 'no');			
			}else{
				alert("로그인 세션이 해제 되었습니다.\n다시 한번 로그인해 주시기 바랍니다.");
				document.location.href = "/user.do?method=logout";
			}
	}});
				
}

function loginType(pageCode){
	var userId = "idwook80";
	var pageCodes = pageCode.split("-");
}

//엔터만 치면 로그인
function enter_check_top(eventValue) {
	if (eventValue == 13) {
		check_if_Valid_top();
		return;
	}
}

function depositAlert(){
	alert("12월 2일 이후부터 사용 가능합니다.");
}

function check_if_Valid_top() {
	var f = document.frmLogin;
	
	if (f.userId.value == "") {
		alert("아이디를 입력해 주십시오");
		f.userId.focus();
		return;
	}
	if (f.password.value == "") {
		alert("비밀번호를 입력해 주세요");
		f.password.focus();
		return;
	}
	if (f.userId.value.length >= 15) {
		alert("아이디가 자릿수가 초과되었습니다.");
		return;
	}
	if (f.password.value.length >= 101) {
		alert("비밀번호가 자릿수가 초과되었습니다.");
		return;
	}
	loginpage_top();
}

function loginpage_top(){
	
	var f = window.document.frmLogin;
	var pageUrl = document.location.href;
	var returnUrl="";
	
	f.method = "post";
	//f.target = "jform";
	if(returnUrl != ''){
		f.action = "https://www.dhlottery.co.kr/userSsl.do?method=login&returnUrl="+encodeURIComponent(returnUrl);
	}else{
		f.action = "https://www.dhlottery.co.kr/userSsl.do?method=login&returnUrl="+encodeURIComponent(pageUrl);
	}
	f.submit();

}

function getCookie(uName) {
	var flag = document.cookie.indexOf(uName + '=');
	if (flag != -1) {
		flag += uName.length + 1;
		end = document.cookie.indexOf(';', flag);
		if (end == -1)
			end = document.cookie.length;
		return unescape(document.cookie.substring(flag, end));
	}
}

function gomain() {
	location.href="/common.do?method=main";
}

$(document).ready(function() {
	$("#phoneTopMenu").html("");
	
	if(getCookie("userId") != undefined) 
	{
		$('.top_userid').val(getCookie("userId"));
	}
	
});

function svcInfoPnMsg() {
	alert("일시 판매 정지 중입니다.\n\n판매 개시일 : 2023년 1월 4일 10시");
}

function svcInfoElMsg() {
	alert("일시 판매 정지 중입니다.\n\n판매 개시일 : 2023년 1월 4일 10시");
}


function svcInfoElTrMsg() {
	alert("트리플럭 복권은 일시 판매 정지 중입니다.\n\n정지일시 : 2022년 12월 19일 20시\n\n판매 개시일 : 2023년 1월 4일 10시");
}

function endInfoElMsg() {
	alert("판매시간이 아닙니다.\n\n판매 시간 : 06시 ~ 24시");
}

</script>
<!-- <link rel="stylesheet" type="text/css" href="/css/nanum_gothic_dev.css" /> -->
<link rel="stylesheet" type="text/css" href="https://dhlottery.co.kr/css/styles.css">
<script type="text/javascript" src="https://dhlottery.co.kr/js/function.js" charset="utf-8"></script>
<script type="text/javascript" src="https://dhlottery.co.kr/js/InsertFlash.js" charset="utf-8"></script>
<script type="text/javascript" src="https://dhlottery.co.kr/js/link.js" charset="utf-8"></script>
<script type="text/javascript" src="https://dhlottery.co.kr/js/makePCookie.js" charset="utf-8"></script>
<script type="text/javascript" src="https://dhlottery.co.kr/js/jquery.cookie.js"></script>
<script type="text/javascript" src="https://dhlottery.co.kr/js/webfont.js"></script>
<script>
if (navigator.platform && /win16|win32|win64|mac/ig.test(navigator.platform) == false) {
	if ('https://m.dhlottery.co.kr'.indexOf(location.hostname) == -1 || 'https://m.dhlottery.co.kr'.indexOf(location.hostname) == -1 ) {
	  	location.href = 'https://m.dhlottery.co.kr';
	}
}
</script>
<style type="text/css">
	html,body {background:none; overflow:hidden}
</style>
</head>
<body>

<!-- 팝업 사이즈 가로 360 세로 560 스크롤 no -->
<div id="popup645paper" class="popup-645paper">
	<h2>인터넷 로또 6/45 구매번호</h2>
	<div class="date-info">
		<h3><span>복권 로또 645</span><strong>제 1049회</strong></h3>
		<ul>
			<li><span>발 행 일</span> : 2023/01/06 (금) 16:16:21</li>
			<li><span>추 첨 일</span> : 2023/01/07</li>
			<li><span>지급 기한</span> : 2024/01/08</li>
		</ul>
		<p class="barcode">
		
			<span>56635</span>
			<span>24824</span>
			<span>97872</span>
			<span>96579</span>
			<span>84162</span>
			<span>28294</span>
		
		</p>
	</div>
	<div class="selected">
		<ul>
		
		
		    <!-- loop -->
			<li>
				<strong><span>A</span>
					<span>
						
						    
								
								    
								    
										낙첨
								    
								
						    
						    
						
					</span>
				</strong>
				<div class="nums">
							
							
								<span><span class="ball_645 sml ball1">3</span></span>
								<span><span>22</span></span>
								<span><span>30</span></span>
								<span><span class="ball_645 sml ball4">37</span></span>
								<span><span>41</span></span>
								<span><span>42</span></span>
						
					
				</div>
			</li>
			<!-- //loop -->
		
		    <!-- loop -->
			<li>
				<strong><span>B</span>
					<span>
										1등
						
					</span>
				</strong>
				<div class="nums">
							
								<span><span class="ball_645 sml ball1">3</span></span>
								<span><span class="ball_645 sml ball1">5</span></span>
								<span><span class="ball_645 sml ball2">13</span></span>
								<span><span class="ball_645 sml ball2">20</span></span>
								<span><span class="ball_645 sml ball3">21</span></span>
								<span><span class="ball_645 sml ball4">37</span></span>
							
						
					
				</div>
			</li>
			<!-- //loop -->
		
		    <!-- loop -->
			<li>
				<strong><span>C</span>
					<span>
								    
								    
										낙첨
								    
						
					</span>
				</strong>
				<div class="nums">
					
							
								<span><span>8</span></span>
								<span><span class="ball_645 sml ball2">13</span></span>
								<span><span class="ball_645 sml ball2">20</span></span>
							
								<span><span>27</span></span>
							
							
								<span><span>28</span></span>
							
								<span><span>35</span></span>
							
						
					
				</div>
			</li>
			<!-- //loop -->
		
		    <!-- loop -->
			<li>
				<strong><span>D</span>
					<span>
						
						    
								
								    
								    
										낙첨
								    
								
						    
						    
						
					</span>
				</strong>
				<div class="nums">
					
						
							
							
							
							
							
							
						
						
							
							<span><span class="ball_645 sml ball1">5</span></span>
							
							
							
							
							
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>6</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>8</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>14</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
									<span><span class="ball_645 sml ball3">21</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>42</span></span>
							
						
					
				</div>
			</li>
			<!-- //loop -->
		
		    <!-- loop -->
			<li>
				<strong><span>E</span>
					<span>
						
						    
								
								    
								    
										낙첨
								    
								
						    
						    
						
					</span>
				</strong>
				<div class="nums">
					
						
							
							
							
							
							
							
						
						
							
							<span><span class="ball_645 sml ball1">5</span></span>
							
							
							
							
							
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>9</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>19</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>28</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>32</span></span>
							
						
					
						
							
							
							
							
							
							
						
						
							
							
							
							
							
							
							
							
								<span><span>41</span></span>
							
						
					
				</div>
			</li>
			<!-- //loop -->
		
		</ul>
		<div class="total">
		
		    
				<strong>당첨금액 합계</strong><strong><span class="won">\</span>1,727,810,100</strong>
		    
		    
		
		</div>
	</div>
	<div class="btns">
		<!-- <a class="btn_common mid" href="#" onclick="print(); return false;" title="새창 열림">인쇄</a> -->
		<a class="btn_common mid" href="#" onclick="self.close()">닫기</a>
	</div>
</div>
<script>
var resizeThis = function(){
	var container = $("#popup645paper");
	var width = container.outerWidth() + (window.outerWidth -  window.innerWidth);
	var height = container.outerHeight() + (window.outerHeight -  window.innerHeight);
	window.resizeTo(width, height);
}
$(window).load(function(){
	resizeThis();
});
</script>
</body>
</html>
