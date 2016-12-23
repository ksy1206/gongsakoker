<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<div data-role="page" class="board_page area_board_page">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important;">지역 게시판</h1>
		<a onclick="go_move(1)" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-btn-right" style="background-color:#fff; border:0; padding:.2em 0 0 0;">
			<img src="../img/board/myList.png" class="header_icon" style="width:2em;"/>
		</a>		 
	</div>
	
	<div>
		
	</div>	
	
</div>

</body>
</html>