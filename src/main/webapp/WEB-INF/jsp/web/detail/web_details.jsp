<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta property="al:web:should_fallback" content="false"> 
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="../js/jquery.bxslider.min.js"></script>
	<link rel="stylesheet" href="<%=cp%>/css/layout.css" />
	<link rel="stylesheet" href="<%=cp%>/css/main.css" />
	<link rel="stylesheet" href="<%=cp%>/css/web_details.css">
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<style> 
	/* 마스크 뛰우기 */
	#mask {  
		position:absolute;  
		z-index:9000;  
		background-color:#000;  
		display:none;  
		left:0;
		top:0;
		background-color: rgba(0,0,0, .6);
	}
	/*
	 팝업으로 뜨는 윈도우 css  
	*/ 
	.window{
		display: none;
		position:relative;  
		width:100%;  
	}
	</style>
	<script>
	function wrapWindowByMask(){
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
		    
		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#mask').css({'width':maskWidth,'height':maskHeight});  
		//애니메이션 효과 - 일단 0초동안 까맣게 됐다가 60% 불투명도로 간다.
		$('#mask').fadeIn(0);      
		//$('#mask').fadeTo("slow",0.6);    
		//윈도우 같은 거 띄운다.
		$('.window').show();
	}
	
	var os = "";
	
	// 아래는 OS 구분에 대한 부분은 예시 코드다.  모바일이 아닌 경우도 고려해야 한다. 
	var useragent = navigator.userAgent;
	if(navigator.userAgent.toLocaleLowerCase().search("iphone") > -1){
		os = "ios";
	}else if(navigator.userAgent.toLocaleLowerCase().search("android") > -1){
		os = "android";
	}else {
		os = "else";
	}
	// 스토어 URL 정보는 각 패키지가 등록된 후에 확인 가능하다.
	function goAppStoreOrPlayStore() {
		if(os == "android") {
			var storeURL = "https://play.google.com/store/apps/details?id=com.gonggan.koker";
			location.replace(storeURL);
		} 
		else if (os == "ios") {
			var storeURL = "https://itunes.apple.com/kr/app/id1092395847?mt=8";
			location.replace(storeURL);
		} else {
			
		}
	}
	/*앱을 실행하는 코드
	 동일한 uri scheme을 Android 앱이나 iOS 앱에 적용을 시켜야 한다.
	 uri scheme 은 목적에 맞게 정의한다.
	 uri 값에 따라서 분기 목적이 다를 수 있으나, 여기에서는 단순히 샘플정도로만 이해 할 것!
	 uri scheme이 정의되어 있다면 OS에 따른 구분을 별도로 할 필요가 없다.
	 */
	function executeApp() {
		if(os == "android") {
			var appUriScheme = "koker000001://gongsakokerlink?" + ";;;" + "business="+'${memberVo.koker_no}';
			location.href = appUriScheme;
		}
		else if(os == "ios") {
			var type = "type=" + "business";
			var koker_no = "koker_no=" + '${memberVo.koker_no}';
			location.href="kokerscheme://kokerhost?" + type + "&" + koker_no;
		}else {
			
		}
	}
	// 이 코드는 대부분 사용하는 코드다. 
	function executeAppOrGoStore() {
		if(window.confirm("공사콕커로 이동합니다. \n버전이 낮거나 앱이 설치되어 있지 않을 시 설치페이지로 이동합니다.")) {
			var openAt = new Date;
		 	setTimeout(function() {
	 			if (new Date - openAt < 2000){
	 					goAppStoreOrPlayStore();
	 			}
	 		}, 1500);
		 	executeApp();
		}
	}
	
 
	$(document).ready(function() {
		$('.window .close').click(function() {
			$(this).hide();
			$('.window').hide();
			$('#mask').hide();    
			
		});
		$('.openitem').click(function() {
			
			executeAppOrGoStore();
		});
		
	});
</script>



</head>

<body style="background-color:#ebebeb;">

	<div class="wrapper">
	
		<div class="board_header"  style="background-color:#fff;">
			<jsp:include page="../../web/include/header.jsp"/>
			<div class="title" style="vertical-align: bottom; padding:0em 0 2em 0; text-align:center; border-bottom:solid 1px #ddd;background-color:#fff;">
					<div class="details_mainimg">
						<c:if test="${memberVo.logo_name == null || memberVo.logo_name == ''}">
							<img src="<%=cp%>/img/web/details_no img.png">
						</c:if>
						<div class="mainImg_rank" style="padding-top:1em;">
<%-- 						<img src="<%=cp %>/img/web/details_main_img.png"> --%>

						<c:if test="${memberVo.ranking == 1}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_01.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 2}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_02.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 3}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_03.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 4}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_04.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 5}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_05.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 6}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_06.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 7}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_07.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 8}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_08.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 9}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_09.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 10}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_10.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 11}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_11.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 12}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_12.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 13}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_13.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 14}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_14.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 15}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_15.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 16}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_16.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 17}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_17.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 18}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_18.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 19}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_19.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.ranking == 20}">
							<img src="<%=cp %>/img/web/main_details_banner/web_kokkok20_rank_20.png" style="width:100%;">
						</c:if>
						<c:if test="${memberVo.logo_name != null}">
							<img src="/upload/img/${memberVo.member_id}/${memberVo.logo_name}" style="max-width:980px; max-height:300px;">
						</c:if>
						</div>
						
					<h2 style="color:#000;margin-top:2%;">${memberVo.koker_name}</h2>
					<p style="color: #636363; vertical-align: middle; font-size:15px;margin-top:1%;">
					${memberVo.addr01} ${memberVo.addr02}</p>
					
					
					<p style="color:#636363;margin-top:1%;font-size:15px;">${memberVo.vn.substring(0,4)}-${memberVo.vn.substring(4,8)}-${memberVo.vn.substring(8,12)}</p>
					<div class="details_score_star">
			  				<span class="star-input">
										  <span class="input">
										  <c:choose>
											<c:when test="${memberVo.review_avg=='1'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" checked="checked" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='2'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled" checked="checked"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='3'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" checked="checked"><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='4'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled" checked="checked"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='5'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled" checked="checked"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='6'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled" checked="checked"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='7'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled"checked="checked" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='8'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled" checked="checked"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='9'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled" checked="checked"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${memberVo.review_avg=='10'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"  ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled" checked="checked"><label for="p10">10</label>
											</c:when>
											<c:otherwise>
											<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:otherwise>
										</c:choose>
										    
										  </span>
										</span>
					</div>
					<span style="font-size:12pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:27px;vertical-align:middle;">${memberVo.review_count}</span>
					<!-- 나중에 기능구현 -->
<!-- 					<div class="details_top_btn"> -->
<%-- 						<a href="#"><span style="background-color:#29a9c8;color:#fff;"><img src="<%=cp%>/img/web/details_call_ico.PNG">전화</span></a> --%>
<%-- 						<a href="#"><span style="background-color:#29a9c8;color:#fff;"><img src="<%=cp%>/img/web/details_message_ico.PNG">문자</span></a> --%>
<%-- 						<a href="#"><span style="background-color:#f12a38;color:#fff;"><img src="<%=cp%>/img/web/details_heart_ico.PNG">콕</span></a> --%>
<!-- 					</div> -->
				</div>
			</div>
		</div>
		
		<div class="main_container">
			<div class="content">
				<div class="details_content_01">
					<h2 style="color:#000;margin-bottom:1.5%;">전문분야</h2>
					<div class="details_content_01_list">
					
						<c:forEach var="class_code" items="${listClass_code}">
<%-- 							<input type="text" value="${class_code.category}"> --%>
							<c:forEach var="category" items="${category}">
<%-- 							<input type="text" value="${category}"> --%>
								<c:if test="${class_code.category == category.category}">
									<c:if test="${category.value=='y'}">
										<span>${class_code.code_name}</span>
									</c:if>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
				</div>
				<div class="details_content_02">
					<h2 style="color:#000;margin:3% 0 1.5% 0;">안내</h2>
					<div class="details_content_02_list">
						<div class="details_information_01" style="padding:.5em;border-bottom:2px solid #e1e1e1;">
							<span><h3 style="float:left;">업무시간</h3><p style="padding-left:7.5em;">${memberVo.call_stime} ~ ${memberVo.call_ntime}</p></span>
						</div>
						<div class="details_information_01" style="padding:.5em;border-bottom:2px solid #e1e1e1;">
							<span><h3 style="float:left;">휴	일</h3><p style="padding-left:7.5em;">${memberVo.holiday }</p></span>
						</div>
						<div class="details_information_01" style="padding:.5em;border-bottom:2px solid #e1e1e1;">
							<span><h3 style="float:left;">홈페이지</h3><p style="padding-left:7.5em;"><a href="${memberVo.koker_url}" style="color:#000;text-decoration:none;" target="_blank">${memberVo.koker_url}</a></p></span>
						</div>
						<div class="details_information_02" style="padding:.5em;">
							<p><textarea style="resize:none;">${memberVo.koker_content}</textarea></p>
						</div>
					</div>
				</div>
<!--s 				2016-03-10 아래서부터 나중에 기능추가 -->
<!-- 				<div class="details_content_01"> -->
<!-- 					<h2 style="color:#000;margin:3% 0 1.5% 0;">질문답변</h2> -->
<!-- 					<div class="details_content_03_list"> -->
<%-- 						<img src="<%=cp%>/img/web/details_tikok.PNG"> --%>
<!-- 							<div> -->
<!-- 							<h2 style="text-align:left;">질문남기기 서비스는 모바일에서만 이용가능합니다.<br> -->
<!-- 							궁금한 내용은 공사콕커 어플을 이용해 질문해주세요!</h2> -->
<!-- 							<p style="text-align:left;font-family:'Nanum Barun Gothic';color:#636363;"> -->
<!-- 							간단한 궁금증들은 질문답변을 이용해서 업체에 간편하게 물어보세요 ~</p> -->
<!-- 							</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="details_content_01"> -->
<!-- 					<h2 style="color:#000;margin:3% 0 1.5% 0;">리뷰</h2> -->
<!-- 					<div class="details_content_04_list"> -->
<%-- 						<a href="#"><p><img src="<%=cp%>/img/local/posting_icon.png"> --%>
<!-- 						첫 리뷰를 공사콕커 어플을 이용해 남겨주세요!</p></a> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!--e 				2016-03-10 아래서부터 나중에 기능추가 -->
				<div class="details_content_01">
					<h2 style="color:#000;margin:3% 0 1.5% 0;">위치</h2>
					<div class="details_content_05_list">					
<!-- 						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d12687.191892528088!2d126.7368206414305!3d37.34729133575702!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b705374aaf417%3A0x38b07b18f5f2969b!2z6rK96riw64-EIOyLnO2dpeyLnCDrtInsmrDsnqzroZwgNTE!5e0!3m2!1sko!2skr!4v1445319213999" style="width:100%;height:200px;border:2px solid #29a9c8;border-radius:10px;" allowfullscreen></iframe> -->
						<div id="map-canvas" style="width: 100%; height: 400px;"></div>
					<input type="hidden" value="${memberVo.latitude}" id="latitude">
					<input type="hidden" value="${memberVo.longitude}" id="longitude">
					</div>
				</div>
			</div>
			<div id="mask" style="position:absolute; top:0; left:0; width:100%; z-index:9999;">
	            <div class="window" style="z-index:10000;">
	     
	            	<p class="close" style="position:absolute; top:1.0em; right:0.0em; width:2.0em; height:2.0em;">X</p>
					<img width="100%" src="<%=cp %>/img/more/popuptop.png" style="position:absolute; top:6.0em; left:0;">
					<a href="#" class="openitem"><img width="100%" src="<%=cp %>/img/more/popupbottom.png" style="position:absolute; top:20.0em; left:0;"></a>
				</div>
	        </div>
		</div>
		
	</div>
		
		<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
		<div>	
		
	</div>
</body>

<!-- GoogoleMap Asynchronously Loading the API ********************************************* -->
<script type="text/javascript">
      function initialize() {
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
        var mapLocation = new google.maps.LatLng(latitude, longitude); // 지도에서 가운데로 위치할 위도와 경도 
        var markLocation = new google.maps.LatLng(latitude, longitude); // 마커가 위치할 위도와 경도         

        var mapOptions = {
          center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
          zoom: 18, // 지도 zoom단계
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById("map-canvas"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
            mapOptions);
        var size_x = 60; // 마커로 사용할 이미지의 가로 크기
        var size_y = 60; // 마커로 사용할 이미지의 세로 크기         

        // 마커로 사용할 이미지 주소
        var image = new google.maps.MarkerImage( 'http://www.larva.re.kr/home/img/boximage3.png',
                            new google.maps.Size(size_x, size_y),
                            '',
                            '',
                            new google.maps.Size(size_x, size_y));
        var marker;
        marker = new google.maps.Marker({ 
               position: markLocation, // 마커가 위치할 위도와 경도(변수)
               map: map,
               icon: image, // 마커로 사용할 이미지(변수)
//             info: '말풍선 안에 들어갈 내용',
//             title: '' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
        });        

//         var content = ""; // 말풍선 안에 들어갈 내용         

        // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
//         var infowindow = new google.maps.InfoWindow({ content: content});
//         google.maps.event.addListener(marker, "click", function() {
//             infowindow.open(map,marker);
//         });
      }

      google.maps.event.addDomListener(window, 'load', initialize);
      
	
</script>
<script type="text/javascript">
	//아래는 OS 구분에 대한 부분은 예시 코드다.  모바일이 아닌 경우도 고려해야 한다. 
	//모바일이면 씌우고 아니면 패스
	var useragent = navigator.userAgent;
	if(navigator.userAgent.toLocaleLowerCase().search("android") > -1){
		wrapWindowByMask();
	}else if(navigator.userAgent.toLocaleLowerCase().search("iphone") > -1){
		wrapWindowByMask();
	}else {
		//wrapWindowByMask();
	}
</script>
</html>