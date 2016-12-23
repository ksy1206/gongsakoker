<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>
<script type="text/javascript">
	$(document).ready(function(){		
		$("#addAdvertise").click(function(){
			var session = $("#session").val();
			if(session == ""){
				$("#popupCheck").popup("open");
			} else {
	 			location.href="${pageContext.request.contextPath}/advertise/move_addQuestion.do";				
			}
		});
	});

	//뒤로가기
	function call_back(){
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	}
</script>
</head>
<body>
<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no() }" id="session">
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" onclick="call_back()"  class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>광고문의</h1>
	</div>
	
	<div>
		<c:if test="${advertise_list == '[]' }">
			<div data-role="content" class="advertise_content">
				<img src="../img/board/background_cha.gif" />
				<h3>문의 주신 내용이 없습니다.</h3>
				<p>공사콕커 광고에 대한 궁금한 모든 질문을<br /> 광고 문의로 해결하세요.</p>  
			</div>
		</c:if>
	
		<c:if test="${advertise_list != null }">
			<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
				<c:forEach var="data" items="${advertise_list }">
				    <div data-role="collapsible" data-collapsible="true" class="board_list">
						<c:if test="${data.answer_content != null }">
					        <h3>
								<p style="color:#29A9C8 !important;">광고 문의 답변 완료</p>
								<p>(질문) ${data.board_content }</p>
								<p class="list_gray">${data.board_date }</p>
							</h3>
				        <textarea readonly="readonly">(답변) ${data.answer_content }</textarea>
						<p class="list_gray">${data.answer_date }</p>
						</c:if>
						<c:if test="${data.answer_content == null }">
					        <h3>
								<p class="list_gray">광고 문의 답변 확인중</p>
								<p>(질문) ${data.board_content }</p>
								<p>${data.board_date }</p>
							</h3>
				        <textarea readonly="readonly">(답변) 준비중입니다.</textarea>
						<p class="list_gray">(작성일자) ${data.board_date }</p>
						</c:if>
				    </div>
				</c:forEach>
			</div>
		</c:if>
	</div>
	
	<div id="popupCheck" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다. 로그인 해주세요.</p>
	      	<a class="" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>	
	
	<div id="footer" data-position="fixed" class="board_footer_wright">
		<a href="#" class="" id="addAdvertise">문의 하기</a>
	</div><!-- /footer -->
</div>
</body>
</html>