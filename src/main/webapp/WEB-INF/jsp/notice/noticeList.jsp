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
<script type="text/javascript">

//뒤로가기
function call_back(){
	var class_code = $("#class_code").val();
	location.href="${pageContext.request.contextPath}/appMain/appMain.do";
}
</script>
</head>
<!-- 공지알림 페이지 -->
<body style="margin:0;	background-color:#fff;">
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>공지사항</h1>
	</div>
	<div data-role="collapsible-set">
		<c:forEach var="data" items="${notice_list}">
		    <div data-role="collapsible" data-collapsible="true" class="board_list">
			        <h3>
						<p>${data.title}</p>
						<p class="list_gray" style="font-size:12px;">${data.insert_date}</p>
					</h3>
		        <textarea readonly="readonly">${data.content}</textarea>
				<p class="list_gray">${data.insert_date}</p>
		    </div>
		</c:forEach>
	</div>
</div>


</body>
</html>