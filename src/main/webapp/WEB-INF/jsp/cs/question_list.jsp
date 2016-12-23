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
</head>

<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>자주 묻는 질문</h1>
	</div>

	<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
		<c:forEach var="data" items="${cs_list}">
			<div data-role="collapsible" data-collapsible="true" class="board_list question_list">
				<h3>
					<p>(질문) ${data.board_content }</p>
				</h3>
				<textarea readonly="readonly">(답변) ${data.answer_content }</textarea>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>