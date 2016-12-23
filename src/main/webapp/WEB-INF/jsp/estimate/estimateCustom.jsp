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

function residential_space(){
	location.href="<%=cp%>/estimate/estimateField.do?estType01_code=1";
}

function commercial_space(){
	location.href="<%=cp%>/estimate/estimateWrite.do?estType01_code=2"
}

function call_back(){
	history.go(-1);
}

</script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>맞춤견적</h1>
	</div>
	
	<div data-role="content" class="est_custom_text">
		<p style="font-size:18px; color:#29A9C8;">맞춤견적 서비스란?</p>
		<p style="font-size:12px;">간단한 정보만으로 여러 업체의 견적을 비교하여 내가 원하는 금액과 희망하는 업체를 선택 할 수 있는 서비스입니다.</p>
		<img src="../img/estimate/write_tikok.gif"/>
		<p style="font-size:14px; text-align:center; color:#888;">원하시는 공간을 선택해 주세요</p>
		
		<div class="ui-grid-a" style="margin:1em 0 .5em 0;">
			<div class="ui-block-a">
				<p onclick="residential_space()" style="text-align:center; font-size:14px; padding:1em 0; background-color:#29A9C8; color:#fff; border-right:solid 3px #fff;">주거공간</p>
			</div>
			<div class="ui-block-b">
				<p onclick="commercial_space()" style="text-align:center; font-size:14px; padding:1em 0; color:#fff; background-color:#29A9C8; border-left:solid 3px #fff;">상업공간</p>
			</div>
		</div>
		
		<p style="font-size:8px; text-align:center;">※ 콕커는 '마케팅서비스'이므로 시공에 관련된 하자는 책임지지 않습니다.</p>
	</div>
	
</div>
</body>
</html>