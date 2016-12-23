<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	$("#moveMain").click(function(){
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	});
});
</script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>업체등록</h1>
	</div>
	
	<div class="complate_cha">
		<img src="../../img/board/add_company_complate.png" width="60%" />
	</div>
	
	<div data-role=footer data-position="fixed" class="guide_footer">
		<input type="button" value="메인으로" id="moveMain">
	</div>	
</div>
</body>
</html>