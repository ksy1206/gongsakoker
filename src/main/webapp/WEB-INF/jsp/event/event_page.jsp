<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<!-- 이벤트 상세 페이지 -->
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img
				src="../img/relback.gif" /></a>
		</div>
		<h1>이벤트</h1>
	</div>
	
	<div class="event_sub_more">
		<c:forEach var="data" items="${event_page}">
			<div class="event_sub">

				<img src="/upload/event/sub/${data.event_content_img}" width="100%" />
				<c:if test="${not empty data.event_participation}">
					<div class="event_sub_group">
						<p class="event_p_title">참여 방법</p>
						<textarea readonly="readonly">${data.event_participation}</textarea>
					</div>
				</c:if>
				<c:if test="${not empty data.event_date1}">
					<div class="event_sub_group">
						<p class="event_p_title">참여 기간 </p>
						<p class="event_p_ny"> ${data.event_date1} ~ ${data.event_date2}</p>
					</div>
				</c:if>
				<c:if test="${not empty data.event_pay}">
					<div>
						<p class="event_p_title">지급</p>
						<p class="event_p_ny"> ${data.event_pay}</p>
					</div>
				</c:if>
				<c:if test="${not empty data.event_url}">
					<div class="event_btn">
						<a href="http://${data.event_url}">${data.event_url_text}</a>
						
					</div>
				</c:if>	
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>