<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
//이벤트 상세 페이지 이동
function event_move(event_no){
	location.href="${pageContext.request.contextPath}/event/event_movePage.do?event_no="+event_no;
}

//뒤로가기
function call_back(){
	var class_code = $("#class_code").val();
	location.href="${pageContext.request.contextPath}/appMain/appMain.do";
}
</script>
</head>

<body>	
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn"><img
				src="../img/relback.gif" /></a>
		</div>
		<h1>이벤트</h1>
	</div>

	<div>
		<c:forEach var="data" items="${event_list}">
			<div onclick="event_move(${data.event_no})" class="event_list">
				<h6>${data.event_title}</h6>
				<c:if test="${not empty data.event_date1}">
					<p class="list_gray">*기간 | ${data.event_date1} ~ ${data.event_date2}</p>
				</c:if>
				<c:if test="${not empty data.event_content}">
					<p class="list_gray">*내용 | ${data.event_content}</p>
				</c:if>
				<img src="/upload/event/banner/${data.event_title_img}"/>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>