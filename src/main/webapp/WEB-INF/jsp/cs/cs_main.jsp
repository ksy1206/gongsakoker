<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">	
$(document).ready(function(){
	$("#question_list").click(function(){
		 location.href="${pageContext.request.contextPath}/cs/cs_FAQ_list.do";
	});
	
	$("#inquiry_main").click(function(){
		var member_no = $("#member_no").val();
		if(member_no == ""){
			$("#popupCheck_txt").text("로그인이 필요한 서비스입니다.");
			$("#popupCheck").popup("open");
		} else {
			 location.href="${pageContext.request.contextPath}/cs/inquiry_main.do?member_no="+member_no;
		}		
	});
	
	$("#connect_phone").click(function(){
		var d = new Date();
		if(d.getDay() == 0 || d.getDay() == 6){
	 		$("#dialog_txt_check").text("주말에는 고객지원실을 운영하지 않습니다.");
	 		$("#popupCall_check").popup("open");
		} else if(d.getHours() < 9 || d.getHours() >= 18){
			$("#dialog_txt_check").text("고객지원실 운영 시간이 아닙니다.");
	 		$("#popupCall_check").popup("open");
		} else {
	 		$("#dialog_txt").text("1566-5831");
	 		$("#popupDialog").popup("open");
		}

	});

});

//뒤로가기
function call_back(){
	var class_code = $("#class_code").val();
	location.href="${pageContext.request.contextPath}/appMain/appMain.do";
}
function moveAdvertise(){
	var member_no = $("#member_no").val();
	var member_code = $("#session_member_code").val();
	if(member_no == null || member_no == ""){
		$("#popupCheck_txt").text("로그인이 필요한 서비스입니다.");
		$("#popupCheck").popup("open");
	} else if(member_code == 02 || member_code == ""){
		$("#popupCheck_txt").text("업체인증 완료 후 사용가능합니다.");
		$("#popupCheck").popup("open");
	} 
	else {
		 location.href="${pageContext.request.contextPath}/advertise/advertise_main.do?member_no="+member_no;
	}
}
</script>
</head>
<body>
<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no() }" id="member_no">
<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_code()}" id="session_member_code">
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>고객지원실</h1>
	</div>
	
	<div>
	    <div onclick="location.href='<%=cp%>/appMain/clause.do'" class="question_or_inquiry">	
			<p style="font-size: 18px;">약관보기 </p>		 
	    </div>		
	    <div onclick="moveAdvertise()" class="question_or_inquiry">	
			<p style="font-size: 18px;">광고문의 </p>		 
	    </div>	
		<div class="question_or_inquiry" id="question_list">
			<p style="font-size: 18px;">자주 묻는 질문 </p>		
	    </div>
	    <div class="question_or_inquiry" id="inquiry_main">	
			<p style="font-size: 18px;">1:1 문의 </p>		 
	    </div>			
	</div>
	<div class="copyright_text">
		<p>(주)공간<span>공사콕커</span><a href="http://www.ftc.go.kr/info/bizinfo/communicationView.jsp?apv_perm_no=2015401023930200173&area1=&area2=&currpage=1&searchKey=04&searchVal=1408192864&stdate=&enddate=">사업자정보 확인</a></p>
		<p>대표이사 : 김철민 ㅣ 사업자등록번호 : 140-81-92864 </p>
		<p>통신판매업신고번호 : 제2015-경기시흥 0173호</p>
		<p>경기도 시흥시 봉우재로 51번길 지성프라자 5층</p>
		<p>개인정보관리책임자 : 김기윤 s.w@gonggan2014.com</p>
		<div class="copyright_box">
			<p>공사콕커는 통신판매중개자이며, 통신판매의</p>
			<p>당사자가 아닙니다. 따라서 공사콕커는 상품거래 정보</p>
			<p>및 거래에 대한 책임은 지지 않습니다.</p>
		</div>
	</div>
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>	

	
	<div data-role=footer id="connect_phone" data-position="fixed" class="cs_call_btn">
		<h6>고객지원실 전화문의</h6>
		<p class="tel_text"><img src="../../img/board/cs_call_icon.gif" />1566-5831</p>
		<p>운영시간 오전 09시 오후 06시 (주말, 공휴일 휴무)</p>
		
		<div id="popupDialog" style="max-width: 400px; box-shadow:0 0 0 #000 !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    	<div class="ui-content" role="main">
				<p id="dialog_txt"></p>
	      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
	      	  	<a style="background-color:#29A9C8;" href="tel:1566-5831"  data-ajax="false" id="confirm">연결</a>    
	  	  	</div>    
	    </div>
	    
	    <div id="popupCall_check" style="max-width: 400px; box-shadow:0 0 0 #000 !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    	<div class="ui-content" role="main">
				<p id="dialog_txt_check"></p>
	      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	  	</div>    
	    </div>
	</div>
	
</div>
</body>
</html>