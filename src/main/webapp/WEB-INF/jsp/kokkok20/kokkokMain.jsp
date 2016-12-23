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
<link rel="stylesheet" href="../css/swiper.min.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="../js/swiper.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var swiper = new Swiper('.swiper-container', {
		pagination: '.swiper-pagination',
		paginationClickable: true,
		centeredSlides: true,
		autoplay: 3000,
		autoplayDisableOnInteraction: false,
		loop: true,
	});
	
	var data = 1;
	filterInit(data);
	
});

function moveRanking(class_code){
	var member_no = $("#session_member_no").val();
	location.href="<%=cp%>/kokkok20/kokkok20_class_code.do?class_code="+class_code+"&member_no="+member_no;
}
function call_back() {
	location.href = "<%=cp%>/appMain/appMain.do";
}
</script>
</head>
<body>
<div data-role="page">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="<%=cp%>/appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1 style="font-family:'godom'; font-weight:normal; text-shadow:none; font-size:16px;">콕콕! 20</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false"><img src="../img/header/home.png" style="width:2.5em;" /></a>
		</div>
	</div>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	
	<div data-role="content">
		<img src="../img/kokkok20/kokkok20_banner.png" style="width:100%;" />
		<div class="" style="padding:0;">
<!-- 			<p onclick="moveRanking('02')" style="background-image:url('../img/kokkok20/kokkok20_jaje_new.png');"> -->
<!-- 			</p> -->
<!-- 			<p onclick="moveRanking('05')" style="background-image:url('../img/kokkok20/kokkok20_sigong_new.png');"> -->
<!-- 			</p> -->
<!-- 			<p onclick="moveRanking('04')" style="background-image:url('../img/kokkok20/kokkok20_jangbi_new.png');"> -->
<!-- 			</p> -->
<!-- 			<p onclick="moveRanking('03')" style="background-image:url('../img/kokkok20/kokkok20_gisolja_new.png');"> -->
<!-- 			</p> -->
<!-- 			<p onclick="moveRanking('06')" style="background-image:url('../img/kokkok20/kokkok20_jonhap_new.png');"> -->
<!-- 			</p> -->
<!-- 			<p onclick="moveRanking('07')" style="background-image:url('../img/kokkok20/kokkok20_unsong_new.png'); margin-bottom:.5em;"> -->
<!-- 			</p> -->
			<p>
				<img src="../img/kokkok20/kokkok20_jaje_new.png" onclick="moveRanking('02')" style="width:49%;">
				<img src="../img/kokkok20/kokkok20_sigong_new.png" onclick="moveRanking('05')" style="width:49%;">
			</p>
			<p>
				<img src="../img/kokkok20/kokkok20_jangbi_new.png" onclick="moveRanking('04')" style="width:49%;">
				<img src="../img/kokkok20/kokkok20_gisolja_new.png" onclick="moveRanking('03')" style="width:49%;">
			</p>
			<p>
				<img src="../img/kokkok20/kokkok20_unsong_new.png" onclick="moveRanking('07')" style="width:49%;">
				<img src="../img/kokkok20/kokkok20_jonhap_new.png" onclick="moveRanking('06')" style="width:49%;">
			</p>
		</div>
	</div>
	
</div>
</body>
</html>